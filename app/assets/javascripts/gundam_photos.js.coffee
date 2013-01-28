jQuery ->
  $container = $('#container')
  $container.imagesLoaded ->
      $container.masonry({
        itemSelector : '.item',
        columnWidth : 230
      })

  $(window).scroll ->
    url = $('.pagination .next a').attr('href')
    if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
      $('.pagination').text("Fetching more content...")
      $.getScript(url)