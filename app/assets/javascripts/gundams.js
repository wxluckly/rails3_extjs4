function filter_gundams(){
  $.get("/gundams", {
      dimension_id: $("#search_dimension_id").val(),
      period_id: $("#search_period_id").val()
  },function(){}, "script");
}

$(function() {
  if(action == "show"){

    var $container = $('#container');
    $container.imagesLoaded(function() {
      $container.masonry({
        itemSelector: '.item',
        columnWidth: 290
      });
    });

  }else if(action == "index"){

    var periods = $('#search_period_id').html();
    $('#search_dimension_id').change(function(){
      var dimension = $('#search_dimension_id :selected').text();
      var options = $(periods).filter("optgroup[label='" + dimension + "']").html();
      $('#search_period_id').html("<option value></option>"+options);
      filter_gundams();
    });

    $('#search_period_id').change(filter_gundams);

  }
});