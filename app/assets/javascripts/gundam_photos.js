$(function(){
  var $container = $('#container');
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector : '.item',
      columnWidth : 230,
      margin : "0px 0 14px 0"
    });
  });
});