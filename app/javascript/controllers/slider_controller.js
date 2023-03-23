import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static values = {
		text: String
	}

	connect() {
		if (this.textValue == "Percent") {
			this.element.setAttribute("aria-valuetext", (this.element.value * 100) + "%")
		}
	}

	maintainFocus() {
		this.element.focus()
	}

	updateValueText() {
		if (this.textValue == "Percent") {
			this.element.setAttribute("aria-valuetext", (this.element.value * 100) + "%")
		}
	}
}