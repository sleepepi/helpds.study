# frozen_string_literal: true

# Displays and caches a single report from Slice.
class Report < ApplicationRecord
  # Constants
  REPORT_TYPES = [
    ["Expressions by Site", "expressions_by_site"],
    ["Randomizations by Site by Month", "randomizations_by_site_by_month"],
    ["Filter by Site by Month", "expression_by_site_by_month"],
    ["Report Card", "report_card"],
    ["Data Checks", "data_checks"]
  ]

  EXPECTED_RANDOMIZATIONS = []

  ORDERS = {
    "archived" => "reports.archived desc",
    "active" => "reports.archived",
    "cached" => "reports.last_cached_at",
    "cached desc" => "reports.last_cached_at desc",
    "name" => "reports.name",
    "name desc" => "reports.name desc"
  }
  DEFAULT_ORDER = "reports.archived, reports.name"

  # Concerns
  include Searchable
  def self.searchable_attributes
    %w(name)
  end

  include Squishable
  squish :name, :filter_expression, :group_expression

  # Accessors
  attr_accessor :row_hashes

  # Callbacks
  after_save :set_report_rows

  # Validations
  validates :name, :report_type, presence: true

  # Relationships
  belongs_to :project
  has_many :report_rows, -> { order(Arel.sql("report_rows.position nulls last")) }, dependent: :destroy
  def reverse_report_rows
    report_rows.reorder(Arel.sql("report_rows.position desc nulls first"))
  end

  # Methods
  def refresh!
    return unless project

    (json, status) = Slice::SendJson.get(report_api_url)
    return status unless status.is_a?(Net::HTTPOK)

    case report_type
    when "randomizations_by_site_by_month", "expression_by_site_by_month", "data_checks"
      update_header_row(json["sites"] || [])
      create_report_row_results(json["rows"] || [])
    when "expressions_by_site"
      update_header_row(json["sites"] || [])
      update_report_row_results(json["rows"] || [])
    else # "report_card"
      update data: json
    end
    update last_cached_at: Time.zone.now
    status
  end

  def report_type_name
    REPORT_TYPES.find { |_name, value| value == report_type }&.first
  end

  def chart?
    report_type.in?(%w(randomizations_by_site_by_month expression_by_site_by_month))
  end

  def compute_totals?
    report_type.in?(%w(randomizations_by_site_by_month expression_by_site_by_month data_checks))
  end

  def table?
    report_type.in?(%w(randomizations_by_site_by_month expression_by_site_by_month data_checks expressions_by_site))
  end

  def grades?
    report_type == "report_card"
  end

  def total_count
    report_rows.sum do |report_row|
      result = report_row.result || {}
      result["count"].to_i
    end
  end

  def muted_row_count
    report_rows.where(muted: true).sum do |report_row|
      result = report_row.result || {}
      result["count"].to_i
    end
  end

  private

  def report_api_url
    case report_type
    when "expressions_by_site"
      subject_counts_api_url
    when "randomizations_by_site_by_month"
      randomizations_by_site_by_month_api_url
    when "expression_by_site_by_month"
      expression_by_site_by_month_api_url
    when "report_card"
      report_card_api_url
    when "data_checks"
      data_checks_api_url
    end
  end

  def randomizations_by_site_by_month_api_url
    "#{project.slice_url}/randomizations.json?sites=#{sites_enabled ? "1" : "0"}"
  end

  def expression_by_site_by_month_api_url
    "#{project.slice_url}/expression.json?sites=#{sites_enabled ? "1" : "0"}"\
      "&filter=#{CGI.escape(filter_expression)}"\
      "&group=#{CGI.escape(group_expression)}"
  end

  def subject_counts_api_url
    expressions = report_rows.pluck(:expression).collect { |exp| "expressions[]=#{CGI.escape(exp)}" }.join("&")
    "#{project.slice_url}/subject-counts.json?#{expressions}&sites=#{sites_enabled ? "1" : "0"}"
  end

  def report_card_api_url
    "#{project.slice_url}/report-card.json"
  end

  def data_checks_api_url
    "#{project.slice_url}/data-checks.json?sites=#{sites_enabled ? "1" : "0"}"
  end

  def update_header_row(sites)
    header = [{ label: "Overall" }]
    sites.each do |site|
      header << {
        id: site["id"],
        label: site["number_and_short_name"]
      }
    end
    update header: header
  end

  def create_report_row_results(results)
    report_rows.where(position: nil).delete_all
    results.each_with_index do |result, index|
      report_row = report_rows.where(position: index).first_or_create(label: "Temp")
      report_row.update(label: result["label"], result: result)
    end
    report_rows.where("position >= ?", results.size).delete_all
  end

  def update_report_row_results(results)
    report_rows.each_with_index do |report_row, index|
      report_row.update result: results[index]
    end
  end

  def set_report_rows
    return unless row_hashes&.is_a?(Array)

    row_ids = row_hashes.collect { |row| row[:report_row_id] }.select(&:present?)
    report_rows.where.not(id: row_ids).destroy_all

    row_hashes.each_with_index do |row, index|
      next if row[:label].blank?

      report_row = report_rows.find_by(id: row[:report_row_id])
      if report_row
        report_row.update(
          position: index,
          label: row[:label],
          expression: row[:expression],
          muted: (row[:muted] == "1")
        )
      else
        report_rows.create(
          position: index,
          label: row[:label],
          expression: row[:expression],
          muted: (row[:muted] == "1")
        )
      end
    end
  end
end
