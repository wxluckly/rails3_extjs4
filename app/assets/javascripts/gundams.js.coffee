jQuery ->
  $container = $('#container')
  $container.imagesLoaded ->
      $container.masonry({
        itemSelector : '.item',
        columnWidth : 290
      })