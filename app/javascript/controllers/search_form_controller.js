import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['form', 'option', 'submit']

  connect() {
    this.formTarget.addEventListener('click', function(event) {
      event.stopPropagation();
    });
    this.submitTarget.disabled = true;
    this.optionTargets.forEach(option => {
      option.addEventListener('change', () => {
        if (option.checked) {
          this.formTarget.action = option.value;
          const mainFrameIncludes = ['podcasts', 'podcast_albums', 'album_homepages'].some(keyword => this.formTarget.action.includes(keyword));
          if (this.formTarget.action.includes('confessions')) {
            this.formTarget.setAttribute('data-turbo-frame', 'board');
          } else if (mainFrameIncludes) {
            this.formTarget.setAttribute('data-turbo-frame', 'main');
          }
          this.submitTarget.disabled = false;
        }
      });
    });
  }
}
