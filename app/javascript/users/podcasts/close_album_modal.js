$('#podcastAlbumModal').on('hidden.bs.modal', function (e) {
  const frame = document.querySelector('turbo-frame[id="modal_for_podcast_album"]');
  if (frame) {
    frame.innerHTML = '';
  }
});
document.addEventListener('turbo:submit-end', function (event) {
  const deleteButton = document.getElementById('deleteButton');
      if (event.detail.success && event.detail.formSubmission) {
          $("#podcastAlbumModal").modal("hide");
      }
  });