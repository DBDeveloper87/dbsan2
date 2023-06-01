import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["firstPrice", "sizes", "size", "shirtImage", "shirtDescription", 
			"donationFields", "donationField", "firstName", "lastName"
		]
	static values = {challenge: String}

	connect() {
		if (this.firstPriceTarget.getAttribute("data-participant-shirt") == "true") {
			if (this.sizesTarget.classList.contains("d-none")) {
				let shirtimg = this.firstPriceTarget.getAttribute("data-participant-shirtimg")
				let shirtdescription = this.firstPriceTarget.getAttribute("data-participant-shirtdescription")

				this.sizesTarget.classList.remove("d-none")
				this.shirtImageTarget.setAttribute("src", shirtimg )
				this.shirtDescriptionTarget.innerText = shirtdescription
				this.sizeTargets.forEach( (e) => {
					e.disabled = false
				})
			}
		}	
	}

	showHideShirtSizes({params: {shirt, shirtimg, shirtdescription} }) {
		if (shirt == true) {
			this.sizesTarget.classList.remove("d-none")
			this.shirtImageTarget.setAttribute("src", shirtimg )
			this.shirtDescriptionTarget.innerText = shirtdescription
			this.sizeTargets.forEach( (e) => {
				e.disabled = false
			})
		} else {
			this.sizesTarget.classList.add("d-none")
			this.sizeTargets.forEach( (e) => {
				e.checked = false
				e.disabled = true
			})
		}
	}

	showHideDonationFields( {params: {donations}}) {
		if (donations == "show") {
			this.donationFieldsTarget.classList.remove("d-none")
			this.donationFieldTargets.forEach( (e) => {
				e.disabled = false
				if (e.placeholder == "Program") {
					e.value = this.challengeValue + " for " + this.firstNameTarget.value + " " + this.lastNameTarget.value
				}
			})
		} else if (donations == "hide") {
			this.donationFieldTargets.forEach( (e) => {
				if (e.placeholder == "Program") {
					e.value = null
				}
				e.disabled = true
			})
			this.donationFieldsTarget.classList.add("d-none")
		}
	}

}