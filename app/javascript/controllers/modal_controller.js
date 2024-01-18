import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['modal']

  connect() {
    // this.modalTarget.addEventListener("turbo:submit-end", function(event) {
    //   if (event.detail.success) {
    //     $(this).modal("hide")
    //   }
    // })

    this.modalTarget.addEventListener("turbo:submit-end", (event) => {
      if (event.detail.success) {
        $(this.modalTarget).modal("hide");
      }
    })
  }
}
