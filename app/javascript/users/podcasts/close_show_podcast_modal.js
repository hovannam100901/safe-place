$('#listPodcastModal').on('hidden.bs.modal', function (e) {
    const frame = document.querySelector('turbo-frame[id="show_list_podcast"]');
    if (frame) {
      frame.innerHTML = '';
    }
  });