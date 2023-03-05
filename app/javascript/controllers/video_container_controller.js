import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video", "container", "wheel"]

  connect() {
  }

  setBackground({params: { color, picker }}) {
    if (picker === "changed") {
      this.containerTarget.style.background = this.wheelTarget.value
    }
  	else {
      this.containerTarget.style.background = color
    }
  }

  setSpeed({params: { speed }}) {
    this.videoTarget.playbackRate = speed
  }
}