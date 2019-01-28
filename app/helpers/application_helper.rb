# frozen_string_literal: true

# Generic methods used across all views.
module ApplicationHelper
  def simple_check(checked)
    checked ? icon("fas", "check-square") : icon("far", "square")
  end
end
