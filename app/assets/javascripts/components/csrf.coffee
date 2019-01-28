@csrfSetup = ->
  $.ajaxSetup(
    beforeSend: (xhr) ->
      xhr.setRequestHeader("X-CSRF-Token", csrfToken())
  )
