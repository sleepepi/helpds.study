"use strict";

function pageReportsSort() {
  $("[data-object~=page-reports-sortable]").each(function() {
    var $this = $(this);
    $this.sortable({
      axis: "y"
    });
  });
}

$(document)
  .on("click", "[data-object~=remove-page-report]", function() {
    $(this).closest("[data-object~=page-report]").remove();
    return false;
  });
