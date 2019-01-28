@categoriesSort = ->
  $("[data-object~=categories-sortable]").each( ->
    $this = $(this)
    $this.sortable(
      axis: "y"
      stop: ->
        params = {}
        params.category_ids = $this.sortable("toArray", attribute: "data-category-id")
        $.post($this.data("path"), params, null, "script")
        true
    )
  )
