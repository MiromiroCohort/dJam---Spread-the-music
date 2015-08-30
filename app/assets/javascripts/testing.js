//= require jquery
//= require jquery_ujs
//= require_tree .

 $.ajax({
      url: "localhost:6060",
      type: "POST",
      success: function(data) {
        console.log(data)
      },
      error: function(data) {
        alert(data);
      }
    });

 $.getJSON("localhost:6600/", function( data ) { console.log(data) });

 $.getJSON( "ajax/test.json", function( data ) {
  var items = [];
  $.each( data, function( key, val ) {
    items.push( "<li id='" + key + "'>" + val + "</li>" );
  });