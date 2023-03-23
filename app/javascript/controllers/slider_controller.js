import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["slider", "output"]

	static values = {
		text: String
	}

	connect() {
		if (this.textValue == "Percent") {
			this.sliderTarget.setAttribute("aria-valuetext", Math.trunc(this.sliderTarget.value * 100) + "%")
			this.outputTarget.innerText = this.sliderTarget.getAttribute("aria-valuetext")
		}
	}

	maintainFocus() {
		this.sliderTarget.focus()
	}

	updateValueText() {
		if (this.textValue == "Percent") {
			this.sliderTarget.setAttribute("aria-valuetext", Math.trunc(this.sliderTarget.value * 100) + "%")
			this.outputTarget.innerText = this.sliderTarget.getAttribute("aria-valuetext")
		}
	}
}