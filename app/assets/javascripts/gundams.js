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

    var periods = $('#Gundam_period_id').html();
    $('#Gundam_dimension_id').change(function(){
      var dimension = $('#Gundam_dimension_id :selected').text();
      var options = $(periods).filter("optgroup[label='" + dimension + "']").html();
      $('#Gundam_period_id').html("<option value></option>"+options);
    });

  }
});