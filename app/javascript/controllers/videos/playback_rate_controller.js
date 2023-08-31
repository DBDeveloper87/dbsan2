import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["rate025", "rate050", "rate100", "rate200", "rate400"]
	
	connect() {
		this.setValue()
	}

	setValue() {
		const video = document.getElementById("video")
	
		switch (video.playbackRate) {
		case 0.25:
			this.rate025Target.checked = true
			break
		case 0.59:
			this.rate050Target.checked = true
			break
		case 1:
			this.rate100Target.checked = true
			break
		case 2:
			this.rate200Target.checked = true
			break
		case 4:
			this.rate400Target.checked = true
			break
		}
	}

	updateValue( {params: { speed }} ) {
		const video = document.getElementById("video")
	
		video.playbackRate = speed
	}
}