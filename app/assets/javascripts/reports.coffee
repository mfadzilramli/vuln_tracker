# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'turbolinks:load', ->
    $('#print_items input[type=checkbox]').change ->
      if @checked
        $.ajax
          type: 'POST',
          url: 'insert/' + @value
      else
        $.ajax
          type: 'POST'
          url: 'delete/' + @value
