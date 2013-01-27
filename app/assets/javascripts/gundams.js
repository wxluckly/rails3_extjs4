$(function(){
  var $container = $('#container');
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector : '.item',
      columnWidth : 290
    });
  });
});