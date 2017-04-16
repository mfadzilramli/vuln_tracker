# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'turbolinks:load', ->
    # $('.new_report_file input[type=file]').change ->
    #   filename = $('input[type=file]').val().split('\\').pop()
    #   $('#selected_filename').text(filename)
    $('.import_tracking input[type=file]').change ->
      input = document.getElementById('tracking_data')
      output = document.getElementById('selected_filename')
      output.innerHTML = '<ul>'
      i = 0
      while i < input.files.length
        output.innerHTML += '<li>' + input.files.item(i).name + '</li>'
        ++i
      output.innerHTML += '</ul>'
