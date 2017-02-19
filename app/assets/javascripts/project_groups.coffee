$ ->
  $(document).on 'turbolinks:load', ->

    $('.edit_project_group input[type=text]').change ->
      $(this).submit()

    $('.edit_project_group input[type=checkbox]').click ->
      # $('.edit_project_group').submit()
      $(this).submit()
