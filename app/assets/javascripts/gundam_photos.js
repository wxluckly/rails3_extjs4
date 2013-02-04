$(function() {
  if(action == "index"){

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

  }else if(action == "avatar"){

    // Create variables (in this scope) to hold the API and image size
    var jcrop_api, boundx, boundy, scale;

    $('#cropbox').Jcrop({        
      boxWidth: 650, 
      boxHeight: 650,
      onChange: updatePreview,
      onSelect: updatePreview,
      setSelect : [0, 0, 80, 100],
      aspectRatio : 80/100
    },function(){
        // Use the API to get the real image size
        var bounds = this.getBounds();
        boundx = bounds[0];
        boundy = bounds[1];
        var img = new Image();
        img.src = $('#cropbox').attr("src");
        scale = img.height / $('#cropbox').height();
        // Store the API in the jcrop_api variable
        jcrop_api = this;
      });

    function updatePreview(coords)
    {
      if (parseInt(coords.w) > 0)
      {
        var rx = 400 / coords.w;
        var ry = 500 / coords.h;
        var lw = $('#cropbox').width();
        var lh = $('#cropbox').height();

        $("#crop_x").val(Math.round(coords.x * scale));
        $("#crop_y").val(Math.round(coords.y * scale));
        $("#crop_w").val(Math.round(coords.w * scale));
        $("#crop_h").val(Math.round(coords.h * scale)); 

        $('#preview').css({
          width: Math.round(rx * lw) + 'px',
          height: Math.round(ry * lh) + 'px',
          marginLeft: '-' + Math.round(rx * coords.x) + 'px',
          marginTop: '-' + Math.round(ry * coords.y) + 'px'
        });
      }
    };
  }
});