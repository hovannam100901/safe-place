var mediaPlayer = JSON.parse(localStorage.getItem("mediaPlayer")) || {};
var {
  currentIndex: currentPodcastIndex = 0,
  listLiked = [],
  listBookmarked = [],
  playlist: podcasts = [],
} = mediaPlayer;

var audioPlayer = audioPlayer || $("#audio-player")[0];
var currentTimePlaying = currentTimePlaying || 0;
var audioCurrentTimeText = $("#audio_current_time")[0];
var isPlaying = isPlaying || false;

$(document).ready(function () {
  initializePodcast();
  setEventListeners();
  window.addEventListener("beforeunload", function () {
    setMediaPlayerToLocalStorage(
      podcasts,
      currentPodcastIndex,
      listLiked,
      listBookmarked
    );
  });
});

function initializePodcast() {
  if (podcasts.length > 0) {
    loadNewPlaylistPodcast(
      podcasts,
      currentPodcastIndex,
      listLiked,
      listBookmarked
    );
    audioPlayer.currentTime = currentTimePlaying;
    $("#volume-slider").val(audioPlayer.volume);
  }
}

function setEventListeners() {
  $(document).off("click", "#play-pause-icon");
  $(document).off("input", "#seek-slider");
  $(document).off("input", "#volume-slider");
  $(document).off("click", "#forward-button");
  $(document).off("click", "#rewind-button");
  $(document).off("click", "#prev-button");
  $(document).off("click", "#next-button");
  $(document).off("click", ".podcast-item");
  $(document).off("click", "#bookmark_podcast");
  $(document).off("click", "#heart_podcast");

  $("#play-pause-icon").on("click", function () {
    $(this).hasClass("fa-circle-play") ? playPodcast() : pausePodcast();
  });

  audioPlayer.onplay = function () {
    $("#play-pause-icon")
      .removeClass("fa-circle-play")
      .addClass("fa-circle-pause");
  };

  audioPlayer.onpause = function () {
    $("#play-pause-icon")
      .removeClass("fa-circle-pause")
      .addClass("fa-circle-play");
  };

  $("#seek-slider").on("input", function () {
    adjustAudioSeek();
  });

  audioPlayer.addEventListener("ended", function () {
    playNextPodcast();
  });

  audioPlayer.addEventListener("timeupdate", updateAudioTime);

  $("#volume-slider").on("input", function () {
    audioPlayer.volume = $(this).val();
  });

  $("#forward-button").on("click", function () {
    forwardFifteenSeconds();
  });

  $("#rewind-button").on("click", function () {
    rewindFifteenSeconds();
  });

  $("#prev-button").on("click", function () {
    playPreviousPodcast();
  });

  $("#next-button").on("click", function () {
    playNextPodcast();
  });

  $(".podcast-item").on("click", function () {
    selectPodcastItem($(this));
  });

  $("#bookmark_podcast").on("click", function () {
    handleBookmarkPodcastClick($(this));
    let currentPodcast = podcasts[currentPodcastIndex];
    if (listBookmarked.includes(currentPodcast.id)) {
      listBookmarked = listBookmarked.filter((item) => item !== currentPodcast.id);
      $(this).addClass("stroke-opacity-50");
    } else {
      listBookmarked.push(currentPodcast.id);
      $(this).removeClass("stroke-opacity-50");
    }
    setMediaPlayerToLocalStorage(
      podcasts,
      currentPodcastIndex,
      listLiked,
      listBookmarked
    );
  });

  $("#heart_podcast").on("click", function () {
    handleLikePodcastClick($(this));
    let currentPodcast = podcasts[currentPodcastIndex];
    if (listLiked.includes(currentPodcast.id)) {
      listLiked = listLiked.filter((item) => item !== currentPodcast.id);
      $(this).addClass("stroke-opacity-50");
    } else {
      listLiked.push(currentPodcast.id);
      $(this).removeClass("stroke-opacity-50");
    }
    setMediaPlayerToLocalStorage(
      podcasts,
      currentPodcastIndex,
      listLiked,
      listBookmarked
    );
  });

  updateMediaFrameVisibility();
}

function loadNewPlaylistPodcast(
  newListPodcast,
  currentPodcastIndex,
  listLikedPodcastItem,
  listBookmarkedPodcastItem
) {
  podcasts = [];
  const podcastList = $("#podcast-list");
  podcastList.empty();
  newListPodcast.forEach(function (podcast) {
    podcasts.push(podcast);
    const imageSrc =
      podcast.image && podcast.image.url
        ? podcast.image.url
        : "/assets/podcast_default.jpg";

    const listItem = `<li class="list-group-item podcast-list-item" data-index="${podcast.id}">
      <div class="d-flex align-items-center">
        <span class="m-2">
          <img class="playlist_podcast_image" width="100" height="100" src="${imageSrc}"></img>
        </span>
        <span class="m-2">
          <p class="m-0 fs-5 fw-bold playlist_podcast_name">${podcast.name}</p>
          <p class="m-0 fw-lighter text_opacity_50 playlist_podcast_author">${podcast.author_name}</p>
        </span>
        <span class="ms-auto">
          <i class="music_icon fa-solid fa-music fa-xl" style="color: #1f7564;" data-index="${podcast.id}"></i>
        </span>
      </div>
    </li>`;

    podcastList.append(listItem);
  });
  listLiked = listLikedPodcastItem;
  listBookmarked = listBookmarkedPodcastItem;
  loadPodcast(currentPodcastIndex);
  $(".podcast-list-item").on("click", podcastListItemClick);
}

function podcastListItemClick() {
  const index = $(this).data("index");
  currentPodcastIndex = podcasts.findIndex((podcast) => podcast.id === index);
  loadPodcast(currentPodcastIndex);
}

function loadPodcast(index) {
  let currentPodcast = podcasts[index];
  currentPodcastIndex = index;
  loadAudio(currentPodcast);
  displayPodcastInfo(currentPodcast);
  manageHeartIcon(currentPodcast);
  manageBookmarkIcon(currentPodcast);
  highlightCurrentPodcast(currentPodcast.id);
  updateMediaFrameVisibility();
  const durationFormattedTime = formatTime(currentPodcast.duration);
  $("#audio_max_time")[0].textContent = durationFormattedTime;
}

function highlightCurrentPodcast(currentId) {
  $(".music_icon").each(function () {
    currentId === $(this).data("index")
      ? $(this).addClass("fa-beat")
      : $(this).removeClass("fa-beat");
  });
}

function loadAudio(podcast) {
  audioPlayer.src = podcast.audio.url;
  audioPlayer.oncanplaythrough = function () {
    isPlaying ? playPodcast() : pausePodcast();
  };
}

function displayPodcastInfo(podcast) {
  $("#podcast_name").text(podcast.name);
  const podcastImage = $("#podcast_image");
  $("#podcast_author").text(podcast.author_name);

  podcast.image.url
    ? (podcastImage[0].src = podcast.image.url)
    : (podcastImage[0].src = "/assets/podcast_default.jpg");
}

function manageHeartIcon(podcast) {
  const heartIcon = $("#heart_podcast");
  heartIcon.data("id", podcast.id);
  listLiked.includes(podcast.id)
    ? heartIcon.addClass("fill-red stroke-red").removeClass("stroke-opacity-50")
    : heartIcon
        .removeClass("fill-red stroke-red")
        .addClass("stroke-opacity-50");
}

function manageBookmarkIcon(podcast) {
  const bookmarkIcon = $("#bookmark_podcast");
  bookmarkIcon.data("id", podcast.id);
  listBookmarked.includes(podcast.id)
    ? bookmarkIcon.addClass("stroke-red").removeClass("stroke-opacity-50")
    : bookmarkIcon.removeClass("stroke-red").addClass("stroke-opacity-50");
}

function playPodcast() {
  if (audioPlayer.src !== "") {
    $("#play-pause-icon")
      .removeClass("fa-circle-play")
      .addClass("fa-circle-pause");
    if (!audioPlayer.paused) {
      return;
    }
    playPodcastSafely();
    isPlaying = true;
  }
}

function pausePodcast() {
  $("#play-pause-icon")
    .removeClass("fa-circle-pause")
    .addClass("fa-circle-play");
  audioPlayer.pause();
  isPlaying = false;
}

function updateMediaFrameVisibility() {
  var mediaFrame = $("turbo-frame[id=media]");
  podcasts.length == 0 ? mediaFrame.hide() : mediaFrame.show();
}

function forwardFifteenSeconds() {
  audioPlayer.currentTime += 15;
}

function rewindFifteenSeconds() {
  audioPlayer.currentTime -= 15;
}

function adjustAudioSeek() {
  const seekTo = audioPlayer.duration * ($("#seek-slider").val() / 100);
  audioPlayer.currentTime = seekTo;
}

function updateAudioTime() {
  currentTimePlaying = audioPlayer.currentTime;
  const duration = audioPlayer.duration;

  const currentFormattedTime = formatTime(currentTimePlaying);

  const seekValue = (currentTimePlaying / duration) * 100;
  $("#seek-slider").val(seekValue);
  audioCurrentTimeText.textContent = currentFormattedTime;
}

function formatTime(time) {
  const minutes = Math.floor(time / 60);
  const seconds = Math.floor(time - minutes * 60);
  return `${minutes}:${seconds < 10 ? "0" : ""}${seconds}`;
}

function playPreviousPodcast() {
  currentPodcastIndex =
    (currentPodcastIndex - 1 + podcasts.length) % podcasts.length;
  loadPodcast(currentPodcastIndex);
}

function playNextPodcast() {
  currentPodcastIndex = (currentPodcastIndex + 1) % podcasts.length;
  loadPodcast(currentPodcastIndex);
}

function selectPodcastItem(item) {
  const index = item.data("audio").id;
  currentPodcastIndex = podcasts.findIndex((podcast) => podcast.id === index);
  loadPodcast(currentPodcastIndex);
  playPodcast();
}

function setMediaPlayerToLocalStorage(
  playlist,
  currentIndex,
  listLiked,
  listBookmarked
) {
  let mediaPlayerHash = {
    playlist: playlist,
    currentIndex: currentIndex,
    listLiked: listLiked,
    listBookmarked: listBookmarked,
  };
  localStorage.removeItem("mediaPlayer");
  localStorage.setItem("mediaPlayer", JSON.stringify(mediaPlayerHash));
}

function playPodcastSafely() {
  if (audioPlayer.readyState >= 2) {
    // Check if the audio is loaded and ready to play
    audioPlayer.play().catch((error) => {
      console.error("Error while playing the audio:", error);
    });
  } else {
    audioPlayer.addEventListener("canplay", playPodcastSafely);
  }
}
