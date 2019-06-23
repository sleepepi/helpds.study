$(document)
  .on("click", "[data-object~=toggle-search-container]", ->
    $(".search-container").toggleClass("search-container-visible")
    setFocusEnd($($(this).data("target"))[0])
    false
  )
