import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {
	connect() {
		
		console.log("Bootstrap Tooltips should be working")
	}
}