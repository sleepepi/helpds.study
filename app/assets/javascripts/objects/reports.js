"use strict";

function reportRowsSort() {
  $("[data-object~=report-rows-sortable]").each(function() {
    var $this = $(this);
    $this.sortable({
      axis: "y"
    });
  });
}

function toggleReportFields(value) {
  $("[data-report-types]").hide();
  if (value != "") {
    $("[data-report-types~=" + value + "]").show();
  }
}

$(document)
  .on("click", "[data-object~=remove-report-row]", function() {
    $(this).closest("[data-object~=report-row]").remove();
    return false;
  })
  .on("change", "#report_report_type", function() {
    toggleReportFields($(this).val());
    return false;
  });
