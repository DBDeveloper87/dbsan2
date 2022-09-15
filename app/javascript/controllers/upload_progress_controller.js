import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "file_field", "progress", "progressText", "progressWidth" ]

  initialize() {
  }

  connect() {
    console.log("Hello Uploader")
    this.element.addEventListener("direct-upload:progress", this.updateProgress.bind(this))

    this.element.addEventListener("direct-upload:error", event => {
      event.preventDefault()
      const { id, error } = event.detail
      console.log(error)
    })
  }

  showProgress() {
    this.file_fieldTarget.style.display = "none"
    this.progressTarget.style.display = "block"
    this.element.requestSubmit()
  }

  updateProgress() {
    const { id, progress } = event.detail
    this.progressWidthTarget.style.width = `${Math.round(progress)}%`
    this.progressTextTarget.innerHTML = `${Math.round(progress)}% complete`
  }

  disconnect() {
    this.element.removeEventListener("direct-upload:progress", this.updateProgress)
  }
}