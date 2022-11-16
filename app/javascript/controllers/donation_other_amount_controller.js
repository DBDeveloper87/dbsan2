import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="donation-other-amount"
export default class extends Controller {
  static targets = ["radio10", "radio25", "radio50", "radio100", "input_other"]

  connect() {
  }

  uncheckRadios() {
    this.radio10Target.checked = false
    this.radio25Target.checked = false
    this.radio50Target.checked = false
    this.radio100Target.checked = false
  }

  removeOther() {
    this.input_otherTarget.value = null
  }
}
