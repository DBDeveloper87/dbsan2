import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["input", "toolbox", "contentBlock"]
	static values = ["block"]

	connect() {
		if (this.inputTarget.value == "" || this.inputTarget.value == null) {
			this.insertEditableContent()
			this.insertBlock()
			this.updateJSONString()		
		}
	}

	insertEditableContent() {
		const editableContent = document.createElement("div")
		editableContent.id = "editableContent"
		editableContent.classList.add("border")
		editableContent.classList.add("border-dark")
		editableContent.classList.add("p-4")
		editableContent.classList.add("mt-4")
		//editableContent.setAttribute("data-action", "keydown.enter@document->content-json#hello")
		this.element.appendChild(editableContent)
	}

	insertBlock() {
		const editableContent = document.getElementById("editableContent")
		fetch("/blocks/paragraph?position=1" )
			.then((res) => res.text())
        .then((html) => {
          const fragment = document
            .createRange()
            .createContextualFragment(html);

          editableContent.appendChild(fragment);
        })
	}
	
	updateJSONString() {
		const ec = document.getElementById("editableContent")
		const blocks = Array.from(ec.children)
		let blockJSON = []
		blocks.forEach(block => {
			const children = Array.from(block.children)

			let tag = "P"
			let text = null

			children.forEach(child => {
				if (child.tagName = tag) {
					text = child.innerText
				}
			})

			const json = {
				tag: tag,
				text: text
			}

			blockJSON.push(json)
		})
		alert(blockJSON)
	}
}
