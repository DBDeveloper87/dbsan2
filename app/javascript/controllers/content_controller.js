import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["input", "label"]

	connect() {
		alert("It's working")
		this.inputTarget.classList.add("d-none")
		this.labelTarget.classList.add("d-none")
	}

}