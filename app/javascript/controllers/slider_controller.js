import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	maintainFocus() {
		this.element.focus()
	}
}