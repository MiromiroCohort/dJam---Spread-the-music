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


  $(".vote-btn").on('click', function() {
    var hashName = this.id
    var score = parseInt($("#" + hashName).closest("div").prev().text())+1
    $("#" + hashName).closest("div").prev().text(score)
    var outRow = $("#" + hashName).closest(".row")
    outRow.animate({opacity: '0.5'}, "slow")
    sortRow(outRow, score)
    outRow.animate({opacity: '1'}, "slow");

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


  function sortRow(thisRow, thisRowScore) {
    var allRows = $(".container").find(".row")
    var i = 0
    do {
      if (parseInt($(allRows[i]).find(".count").html()) < thisRowScore) {
        console.log($(thisRow))
        console.log($(allRows[i]).find(".count").html())
        $(thisRow).insertBefore($(allRows[i]))      
        i = allRows.length +1
      } else {
        i++
      }
    }
    while (i < allRows.length)
  }

  function sortPage () {
    var rowList = $(".container").find(".row")
    for (var currentRow = rowList.length-1; currentRow > -1; currentRow--){
      rowScore = parseInt($(rowList[currentRow]).find(".count").html())
      sortRow(rowList[currentRow], rowScore)
    }
  }

  sortPage()
  if ($("#countdown").text()) {
    remainingTime()
  }


  function remainingTime() {
    var counter = $("#countdown").text()
    thisTimer = setInterval(function () {
      var mins = Math.floor(counter/60)
      var secs = counter - (60*mins)
      $("#countdown").text(mins + " : " + secs)
      counter--
      if (counter < 10) {
        console.log("checking")
        updateNowPlaying()
      }
    }, 1000);
  }

  function updateNowPlaying () {
    $.ajax({
      url: "/playing",
      type: "GET",
      dataType: "json",
      success: function(data) {
        $("#song-title").html(data["artist"] + " : " + data["title"])
        alert(parseInt(data["length"]))
        $("#countdown").html(parseInt(data["length"]))
      },
      error: function(data) {
        alert('Sorry - did not get anything');
      }
    })
    sortPage()
    remainingTime()
  }


});

