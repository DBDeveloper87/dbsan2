import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["input", "toolbox", "toolbar", "toolbarP", "toolbarH2",
		"toolbarH3", "toolbarH4", "toolbarH5", "toolbarH6",  "contentBlock"]
	
	connect() {
		this.setToolbar()
		this.contentBlockTarget.addEventListener("focus", (event) => {
			this.toolboxTarget.classList.remove("d-none")
		})
		this.contentBlockTarget.addEventListener("keydown", (event) => this.newParagraph())
		this.toolboxTarget.addEventListener("click", (event) => {
			this.toolboxTarget.classList.add("active")
		})
		this.element.addEventListener("keyup", (event) => this.hideToolbar())	
	}

	newParagraph() {
		if (event.key == "Enter") {
			event.preventDefault()
			const paragraph = document.createElement("P")
			this.element.appendChild(paragraph)
			paragraph.style.background = "black"
			paragraph.style.color = "white"
			paragraph.innerText = "Hello, this is a new paragraph"
			paragraph.setAttribute("contenteditable", true)
			paragraph.focus()
		}
	}
	seth2() {
		const node = document.createElement("H2")
		this.element.insertBefore(node, this.contentBlockTarget)
		node.innerText = this.contentBlockTarget.innerText
		this.contentBlockTarget.remove()
		node.setAttribute("contenteditable", true)
		node.setAttribute("data-content-block-target", "contentBlock")
		this.contentBlockTarget.focus()
		this.setToolbar()
	}

	setToolbar() {
		if (this.contentBlockTarget.tagName == "P") {
			this.toolbarPTarget.classList.add("active")		
		} else {
			this.toolbarPTarget.classList.remove("active")
		}

		if (this.contentBlockTarget.tagName == "H2") {
			this.toolbarH2Target.classList.add("active")		
		} else {
			this.toolbarH2Target.classList.remove("active")
		}

		if (this.contentBlockTarget.tagName == "H3") {
			this.toolbarH3Target.classList.add("active")		
		} else {
			this.toolbarH3Target.classList.remove("active")
		}

		if (this.contentBlockTarget.tagName == "H4") {
			this.toolbarH4Target.classList.add("active")		
		} else {
			this.toolbarH4Target.classList.remove("active")
		}

		if (this.contentBlockTarget.tagName == "H5") {
			this.toolbarH5Target.classList.add("active")		
		} else {
			this.toolbarH6Target.classList.remove("active")
		}

		if (this.contentBlockTarget.tagName == "H6") {
			this.toolbarH6Target.classList.add("active")		
		} else {
			this.toolbarH6Target.classList.remove("active")
		}
	}
	
	hideToolbar() {
		if (event.code == "Space" && !this.toolboxTarget.classList.contains("d-none")) {
			if (this.toolbarTarget.classList.contains("show")) {
				this.toolboxTarget.click()
				this.contentBlockTarget.focus()
				this.toolboxTarget.classList.remove("active")
			}	
		}
	}	
}