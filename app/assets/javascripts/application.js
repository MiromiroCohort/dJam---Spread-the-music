//= require jquery
//= require jquery_ujs
//= require_tree .

$( document ).ready(function() {

  $( "#search-song-form" ).on('submit', function( event ) {
    event.preventDefault();
    var query = $("#query").val();

    $.ajax({
        url: "/track/scrape?query=" + query,
        type: "GET",
        success: function(data) {
          var songs = data.songs[0];
          $(".search-results" ).remove();
          $("article").append("<section class=search-results></section>");
          displaySongs(songs);
          addSong();
        },
        error: function(data) {
           console.log('Displaying songs was not successful!');
        }
      });
      return false;
    });

  function addSong(){
    $( ".add-song-button" ).on('click', function( event ) {
      event.preventDefault();
      var video_id = $(this).data("id");
      var title = $("#"+video_id+" .song-title").html();
      var artist = 'YouTube';
      var song_data = {title: title, artist: artist, video_id: video_id}
      console.log(song_data);
    $.ajax({
        url: "/track/add?query=",
        data: song_data,
        type: "POST",
        success: function(data) {
        },
        error: function(data) {
           console.log('Adding song was not successful!');
        }
      });
      return false;
    });
  };


  function displaySongs(songs){
    console.log(songs)
    var items = [];
    $.each(songs, function( song ) {
      items.push( "<li id=" + song + ">" +
      "<h2 class="+"song-title" + ">" + songs[song]["title"] + "</h2>" +
      "<img class="+"song-img" + " src=" + songs[song]["image"] + ">" +
      "<button class="+"add-song-button"+' data-id='+ song + ' href=' + '/add' + ">Add</button>"+
      "</li>" );
    });

    $( "<ul/>", {"class": "song",html: items.join( "" )}).appendTo( ".search-results" );
  };


  $(".vote_btn").on('click', function() {
    var hashName = this.id
    var score = (parseInt($("#"+hashName).closest("td").next().text())+1)
    $("#"+hashName).closest("td").next().text(score)
    $.ajax({
      url: "/vote?song_ref=" + this.id,
      type: "POST",
      success: function(data) {
        console.log(data)
      },
      error: function(data) {
        alert('Sorry - your vote was not added');
      }
    });
  });


});

 // <section class="playlist-list">
 //            <div class="panel panel-default">
 //              <div class="panel-heading">MVP Playlist Songs</div>
 //              <ul class="list-group">

 //                <li class="list-group-item">
 //                  <div id="1" class="row">
 //                    <a href="#" class="">
 //                      <div class="media col-xs-3">
 //                        <figure>
 //                          <img class="media-object img-rounded img-responsive"  src="http://placehold.it/125x125" alt="placehold.it/125x125" >
 //                        </figure>
 //                      </div>
 //                      <div class="col-xs-6">
 //                        <p class="list-group-item-heading"> Song Name </p>
 //                        <p class="list-group-item-text"> Artist Name </p>
 //                      </div>
 //                    </a>
 //                    <div class="col-xs-3 text-center">
 //                      <button data-id="1" type="button" class="btn btn-default btn-lg btn-block vote-button"> ^ </button>
 //                      <p class="vote-number">1337</p>
 //                    </div>
 //                  </div>
 //                </li>



