import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['mainFrame']
  static history = []
  static currentPosition = -1
  static observer = null

  connect() {
    this.observeFrameChanges()
  }

  observeFrameChanges() {
    this.constructor.observer = new MutationObserver((mutationsList) => {
      for (const mutation of mutationsList) {
        if (mutation.type === "attributes" && mutation.attributeName === "src") {
          const newSrc = this.mainFrameTarget.getAttribute("src")

          if (newSrc !== this.constructor.history[this.constructor.currentPosition]) {
            this.constructor.currentPosition++
            this.constructor.history[this.constructor.currentPosition] = newSrc
          }
        }
      }
    })
    this.constructor.observer.observe(this.mainFrameTarget, { attributes: true })
  }

  disconnect() {
    this.constructor.observer.disconnect()
  }

  reconnect() {
    this.constructor.observer.observe(this.mainFrameTarget, { attributes: true })
  }

  back() {
    if (this.constructor.currentPosition > 0) {
      this.constructor.currentPosition--
      this.disconnect()
      this.loadMainFrame(this.constructor.history[this.constructor.currentPosition])
      this.reconnect();
    }
  }

  forward() {
    if (this.constructor.currentPosition < this.constructor.history.length - 1) {
      this.constructor.currentPosition++
      this.disconnect()
      this.loadMainFrame(this.constructor.history[this.constructor.currentPosition])
      this.reconnect()
    }
  }

  loadMainFrame(src) {
    this.mainFrameTarget.setAttribute("src", src)
  }
}
