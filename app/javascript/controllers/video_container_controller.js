import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video", "container"]

  connect() {
  }

  setBackground() {
  	this.containerTarget.style.background = "red"
  }
}