# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'turbolinks:load', ->
    # $('.print_items input[type=checkbox]').click ->
    #   $('.print_items').submit()
    #   # $(this).submit()
    $('#print_items input[type=checkbox]').change ->
      $(this).submit()
      # $(this).submit()
