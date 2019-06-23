# frozen_string_literal: true

# Helps format numbers and other fields in tables.
module TableHelper
  def table_number(number)
    if number.blank?
      ""
    elsif number == 0
      content_tag(:span, number, class: "text-muted")
    else
      number_with_delimiter number
    end
  end
end
