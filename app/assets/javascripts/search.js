function change_select_content(periods){
  var dimension = $('#search_dimension_id :selected').text();
  var options = $(periods).filter("optgroup[label='" + dimension + "']").html();
  $('#search_period_id').html("<option value></option>"+options);
}

$(function() {
  if(action == "index"){
    
    var periods = $('#search_period_id').html();
    change_select_content(periods);
    
    $('#search_dimension_id').change(function(){
      change_select_content(periods);
    });

    $('#search_query').autocomplete({
      source: "/search_suggestions"
    });

  }
});