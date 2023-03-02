import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video", "container"]

  connect() {
  }

  setBackground({params: { color }}) {
  	this.containerTarget.style.background = color
  }
}