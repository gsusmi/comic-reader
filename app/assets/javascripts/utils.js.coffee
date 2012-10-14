window.App ?= {}

App.util =
  get_comic: (direction, html_element) ->
    console.log('fetching ' + direction + ' comic')
    feed_parent = $(html_element).parents('.comic-wrap')
    feed_id = feed_parent.attr('id')
    feed_item_id = html_element.id

    request_url = '/comics/' + feed_id + '/strip/' + feed_item_id
    $.ajax({
      url: request_url,
      data: {direction: direction},
      success: (data)->
        console.log("fetched")

        feed_parent.find('.comic').fadeOut('normal')
        feed_parent.html(data)
        feed_parent.show('normal', () ->
          feed_parent.find('.comic').fadeIn('normal')
        )
        window.feed_parent = feed_parent
        $(".next").click( () ->
          App.util.get_comic('next', this);
        );

        $(".previous").click( () ->
          App.util.get_comic('previous', this)
        );
    })