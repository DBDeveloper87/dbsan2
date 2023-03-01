import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video", "container"]

  connect() {
  	alert("Working")
  	this.videoTarget.playbackRate = 2.0
  }

  setBackground() {
  	this.containerTarget.style.background = "red"
  }
}