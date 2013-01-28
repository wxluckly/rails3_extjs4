$(function() {
  var $container = $('#container');
  $container.imagesLoaded(function() {
    $container.masonry({
      itemSelector: '.item',
      columnWidth: 230
    });
  });

  $(window).scroll(function() {
    var url;
    url = $('.pagination .next a').attr('href');
    if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
      $('.pagination').text("Fetching more content...");
      $.getScript(url);
    }
  });
});