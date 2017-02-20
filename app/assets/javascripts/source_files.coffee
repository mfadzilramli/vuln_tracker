# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# $('input[type="file"]').change(function(){
# var file_name = $(this).val();
# });
$ ->
  $(document).on 'turbolinks:load', ->
    $('.new_source_file input[type=file]').change ->
      $('#demo_text').show()
