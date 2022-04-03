import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = [ "vaccinationtypes" ]

	showVaccinationTypes() {
		this.vaccinationtypesTarget.classList.remove("d-none")	 
	}
	hideVaccinationTypes() {
		this.vaccinationtypesTarget.classList.add("d-none")	 
	}
}