window.App ?= {}

App.util =
  get_comic: (direction, html_element) ->
    console.log('fetching ' + direction + ' comic')
    feed_parent = $(html_element).parents('.comic-wrap')

    getId = (attr, prefix) -> attr

    feed_id = feed_parent.attr('data-id')
    feed_item_id = $(html_element).attr('data-id')

    request_url = '/comics/' + getId(feed_id, 'feed_') + '/strip/' + getId(feed_item_id, 'feed_item_')
    $.ajax({
      url: request_url,
      data: {direction: direction},
      success: (data)->
        console.log("fetched")

        feed_parent.html(data)

        setTimeout(->
          console.error("Reattaching listeners for " + feed_id)
          parent = $('#feed_' + feed_id)
          $(".next", parent).click( (e) ->
            App.util.get_comic('next', this);
            e.preventDefault();
          );

          $(".previous", parent).click( (e) ->
            console.error("prev")
            App.util.get_comic('previous', this)
            e.preventDefault();
          );

          App.util.setup_nav(parent)
        0)
    })

  setup_nav: (context) ->
    $(".left, .right", context).hover(
      -> $(this).animate({opacity: 1})
      -> $(this).animate({opacity: 0.2}))

  settings_setup: ->
    setFeedsSelected = (selected) ->
      $('.feed input').prop('checked', selected)
    $('.controls a.all').on('click', -> setFeedsSelected(true))
    $('.controls a.none').on('click', -> setFeedsSelected(false))
