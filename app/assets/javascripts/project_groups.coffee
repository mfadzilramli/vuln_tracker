$ ->
  $(document).on 'turbolinks:load', ->
    $('.edit_project_group input[type=text]').change ->
      $(this).trigger('submit.rails')

    $('.edit_project_group input[type=checkbox]').click ->
      $(this).trigger('submit.rails')

    # $('#search_host_form input[type=text]').on 'change keydown paste input', ->
    #   $(this).submit()

    # $('#print_host_ids input[type=checkbox]').click ->
    #   alert(1)
