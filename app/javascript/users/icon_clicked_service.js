function toggleLikeAndBookmarkIcon(iconElement, url, cssClass) {
  $.ajax({
    url: url,
    type: "POST",
    headers: {
      "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content"),
    },
  });

  if (cssClass === "heart") {
    iconElement.toggleClass("fill-red");
  }

  iconElement.toggleClass("stroke-red");
}

function handleBookmarkPodcastAlbumsClick(element) {
  const url =
    "/users/podcast_albums/" + element.data("album-id") + "/toggle_bookmark";
  toggleLikeAndBookmarkIcon(element, url, "bookmark");
}

function handleLikePodcastAlbumsClick(element) {
  const url = "/users/podcast_albums/" + element.data("album-id") + "/like";
  toggleLikeAndBookmarkIcon(element, url, "heart");
}

function handleBookmarkPodcastClick(element) {
  const url = "/users/podcasts/" + element.data("id") + "/toggle_bookmark";
  toggleLikeAndBookmarkIcon(element, url, "bookmark");
}

function handleLikePodcastClick(element) {
  const url = "/users/podcasts/" + element.data("id") + "/toggle_like";
  toggleLikeAndBookmarkIcon(element, url, "heart");
}
