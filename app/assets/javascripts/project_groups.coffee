$ ->
  $(document).on 'turbolinks:load', ->
    $('.edit_project_group input[type=text]').change ->
      $(this).submit()

    $('.edit_project_group input[type=checkbox]').click ->
      # $('.edit_project_group').submit()
      $(this).submit()

    $('#search_host_form input[type=text]').on 'change keydown paste input', ->
      $(this).submit()

    # $('#print_host_ids input[type=checkbox]').click ->
    #   alert(1)
