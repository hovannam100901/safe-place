var playPauseIconAlbum = $("#play-pause-icon-album");
var listPodcastItem = $(".podcast-item");
var listPodcastItemArrays = listPodcastItem.map(function () { return $(this).data('audio')}).get();
var listLikedPodcastItem = $("input[name='liked_podcast']").map(function () {return parseInt(this.value)}).get();
var listBookmarkedPodcastItem = $("input[name='bookmarked_podcast']").map(function() {return parseInt(this.value)}).get();

listPodcastItem.on("click", function () {
  let index = listPodcastItem.index(this);
  if (!checkIfIncludeAudio(podcasts[currentPodcastIndex], listPodcastItem)) {
    loadNewPlaylistPodcast(listPodcastItemArrays, index, listLikedPodcastItem, listBookmarkedPodcastItem);
  } else {
    loadPodcast(index);
    playPodcast();
  }
  isPlaying = true;
  playPauseIconAlbum
    .removeClass("fa-circle-play play")
    .addClass("fa-circle-pause pause");
});

playPauseIconAlbum.on("click", function () {
  if (playPauseIconAlbum.hasClass("play")) {
    if (!checkIfIncludeAudio(podcasts[currentPodcastIndex], listPodcastItem)) {
      loadNewPlaylistPodcast(listPodcastItemArrays, 0, listLikedPodcastItem, listBookmarkedPodcastItem);
    } else {
      playPodcast();
    }
    isPlaying = true;
    playPauseIconAlbum
      .removeClass("fa-circle-play play")
      .addClass("fa-circle-pause pause");
  } else {
    isPlaying = false;
    pausePodcast();
    playPauseIconAlbum
      .removeClass("fa-circle-pause pause")
      .addClass("fa-circle-play play");
  }
});

$(".bookmark_podcast_albums").on("click", function () {
    handleBookmarkPodcastAlbumsClick($(this));
});

$(".heart_podcast_albums").on("click", function () {
    handleLikePodcastAlbumsClick($(this));
});

function updatePlayPauseAblumIcon() {
  if (checkIfIncludeAudio(podcasts[currentPodcastIndex], listPodcastItem) && !audioPlayer.paused) {
    playPauseIconAlbum
      .removeClass("fa-circle-play play")
      .addClass("fa-circle-pause pause");
  } else {
    playPauseIconAlbum
      .removeClass("fa-circle-pause pause")
      .addClass("fa-circle-play play");
  }
}

function checkIfIncludeAudio(element, listElement) {
  if (typeof element != "undefined" && podcasts.length != 0) {
    for (var i = 0; i < listElement.length; i++) {
      if ($(listElement[i]).data("audio").id === element.id) {
        return true;
      }
    }
  }
  return false;
}

$("#play-pause-icon").on("click", updatePlayPauseAblumIcon);

updatePlayPauseAblumIcon();
