import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["input", "toolbox", "contentBlock"]
	static values = ["block"]

	connect() {
		// Create a media condition that targets viewports at least 768px wide
		const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
		// Check if the media query is true
		if (mediaQuery.matches) {
  			// Then trigger an alert
  			alert('Media Query Matched!')
		}

		//this.inputTarget.classList.add("d-none")
		this.createEditable()
		alert("It's working")
		var mainFrame = document.getElementById("contentEditable")
		mainFrame.addEventListener("DOMCharacterDataModified", (event) => {
			const blocks = this.blockJSON("contentEditable")
			this.inputTarget.value = JSON.stringify({ blocks })
		})
		mainFrame.addEventListener("keyup", (event) => {
			if(event.key === "Backspace") {
				const blocks = this.blockJSON("contentEditable")
				this.inputTarget.value = JSON.stringify({ blocks })
			}
		})	
	}

	createEditable() {
		const mainFrame = document.createElement("p")
		mainFrame.id = "contentEditable"
		mainFrame.innerHTML = '<p class="border border-dark p-4" contenteditable="true">This is heaven</p>'
		this.element.appendChild(mainFrame)
	}
	blockJSON(element) {
		const blocks = []
		const elm = document.getElementById(element)
		const block = {
			type: elm.tagName,
			text: elm.innerText
		}
		blocks.push(block)
		return blocks
	}
}