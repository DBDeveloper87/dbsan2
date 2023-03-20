import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  static targets = ["video", "container", "playButton", "playButtonIcon", "currentTime", 
    "duration", "ccButton", "adButton", "settingsButton", "castButton", "pipButton",
     "pipButtonIcon", "fsButton", "fsButtonIcon", "wheel"]

  connect() {
    this.tooltips()
    
    this.videoTarget.addEventListener("timeupdate", (event) => {
      this.displayCurrentTime()
    })

    this.videoTarget.addEventListener("loadedmetadata", (event) => {
      this.displayDuration()
    })  
  }

  tooltips() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
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

  playPause() {
    if (this.playButtonIconTarget.classList.contains("bi-play-fill")) {
      this.playButtonIconTarget.classList.remove("bi-play-fill")
      this.playButtonIconTarget.classList.add("bi-pause-fill")
      this.playButtonTarget.setAttribute("aria-label", "Pause (k)")
      const tooltip = bootstrap.Tooltip.getInstance('#playButton')
      tooltip.setContent({".tooltip-inner": "Pause (k)"})
    } else {
      this.playButtonIconTarget.classList.add("bi-play-fill")
      this.playButtonIconTarget.classList.remove("bi-pause-fill")
      this.playButtonTarget.setAttribute("aria-label", "Play (k)")
      const tooltip = bootstrap.Tooltip.getInstance('#playButton')
      tooltip.setContent({".tooltip-inner": "Play (k)"})
    }
  }

  displayCurrentTime() {
    const currentTime = Math.trunc(this.videoTarget.currentTime)
    const hours = Math.trunc(currentTime / 3600)
    const minutes = Math.trunc((currentTime - (hours * 3600)) / 60)
    const seconds = Math.trunc(currentTime - (hours * 3600) - (minutes * 60))
    let sec_string = seconds.toString()
    if (seconds < 10) {
      sec_string = "0" + seconds.toString()
    }

    if (hours > 0) {
      this.currentTimeTarget.datetime = "PT" + hours.toString() + "H" + minutes.toString() + "M" + seconds.toString()
      this.currentTimeTarget.innerText = hours.toString() + ":" + minutes.toString() + ":" + sec_string
    } else {
      this.currentTimeTarget.datetime = "PT" + minutes.toString() + "M" + seconds.toString()
      this.currentTimeTarget.innerText = minutes.toString() + ":" + sec_string
    }
  }

  displayDuration() {
    const duration = Math.trunc(this.videoTarget.duration)
    const hours = Math.trunc(duration / 3600)
    const minutes = Math.trunc((duration - (hours * 3600)) / 60)
    const seconds = Math.trunc(duration - (hours * 3600) - (minutes * 60))
    let sec_string = seconds.toString()
    if (seconds < 10) {
      sec_string = "0" + seconds.toString()
    }

    if (hours > 0) {
      this.durationTarget.datetime = "PT" + hours.toString() + "H" + minutes.toString() + "M" + seconds.toString()
      this.durationTarget.innerText = hours.toString() + ":" + minutes.toString() + ":" + sec_string
    } else {
      this.durationTarget.datetime = "PT" + minutes.toString() + "M" + seconds.toString()
      this.durationTarget.innerText = minutes.toString() + ":" + sec_string
    }
  }

  toggleCC() {
    if (this.ccButtonTarget.classList.contains("btn-dark")) {
      this.ccButtonTarget.classList.remove("btn-dark")
      this.ccButtonTarget.classList.add("btn-light")
      this.ccButtonTarget.classList.add("fw-bolder")
      this.ccButtonTarget.setAttribute("aria-pressed", "true")
    } else {
      this.ccButtonTarget.classList.add("btn-dark")
      this.ccButtonTarget.classList.remove("btn-light")
      this.ccButtonTarget.classList.remove("fw-bolder")
      this.ccButtonTarget.setAttribute("aria-pressed", "false")
    }
  }

  toggleAD() {
    if (this.adButtonTarget.classList.contains("btn-dark")) {
      this.adButtonTarget.classList.remove("btn-dark")
      this.adButtonTarget.classList.add("btn-light")
      this.adButtonTarget.classList.add("fw-bolder")
      this.adButtonTarget.setAttribute("aria-pressed", "true")
    } else {
      this.adButtonTarget.classList.add("btn-dark")
      this.adButtonTarget.classList.remove("btn-light")
      this.adButtonTarget.classList.remove("fw-bolder")
      this.adButtonTarget.setAttribute("aria-pressed", "false")
    }
  }

  toggleSettings() {
    if (this.settingsButtonTarget.classList.contains("btn-dark")) {
      this.settingsButtonTarget.classList.remove("btn-dark")
      this.settingsButtonTarget.classList.add("btn-light")
      // this.settingsButtonTarget.setAttribute("aria-expanded", "true")
    } else {
      this.settingsButtonTarget.classList.add("btn-dark")
      this.settingsButtonTarget.classList.remove("btn-light")
      // this.settingsButtonTarget.setAttribute("aria-expanded", "false")
    }
  }

  toggleCast() {
    if (this.castButtonTarget.classList.contains("btn-dark")) {
      this.castButtonTarget.classList.remove("btn-dark")
      this.castButtonTarget.classList.add("btn-light")
      this.castButtonTarget.setAttribute("aria-pressed", "true")
    } else {
      this.castButtonTarget.classList.add("btn-dark")
      this.castButtonTarget.classList.remove("btn-light")
      this.castButtonTarget.setAttribute("aria-pressed", "false")
    }
  }

  togglePip() {
    if (this.pipButtonIconTarget.classList.contains("bi-pip")) {
      this.pipButtonIconTarget.classList.remove("bi-pip")
      this.pipButtonIconTarget.classList.add("bi-pip-fill")
      this.pipButtonTarget.classList.remove("btn-dark")
      this.pipButtonTarget.classList.add("btn-light")
      this.pipButtonTarget.setAttribute("aria-pressed", "true")
    } else {
      this.pipButtonIconTarget.classList.add("bi-pip")
      this.pipButtonIconTarget.classList.remove("bi-pip-fill")
      this.pipButtonTarget.classList.add("btn-dark")
      this.pipButtonTarget.classList.remove("btn-light")
      this.pipButtonTarget.setAttribute("aria-pressed", "false")
    }
  }

  toggleFs() {
    if (this.fsButtonIconTarget.classList.contains("bi-fullscreen")) {
      this.fsButtonIconTarget.classList.remove("bi-fullscreen")
      this.fsButtonIconTarget.classList.add("bi-fullscreen-exit")
      this.fsButtonTarget.setAttribute("aria-label", "Exit Fullscreen (f)")
      const tooltip = bootstrap.Tooltip.getInstance('#fsButton')
      tooltip.setContent({".tooltip-inner": "Exit Fullscreen (f)"})
    } else {
      this.fsButtonIconTarget.classList.add("bi-fullscreen")
      this.fsButtonIconTarget.classList.remove("bi-fullscreen-exit")
      this.fsButtonTarget.setAttribute("aria-label", "Enter Fullscreen (f)")
      const tooltip = bootstrap.Tooltip.getInstance('#fsButton')
      tooltip.setContent({".tooltip-inner": "Enter Fullscreen (f)"})
    }
  }
}