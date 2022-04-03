import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "states", "counties" ]

  updateStates(event) {
    fetch(this.data.get("url"), { 
      method: 'POST', 
      body: JSON.stringify( { country: [...event.target.selectedOptions].map(option => option.value), parvalue: this.data.get("parvalue")}),
      credentials: "include",
      dataType: 'script',
      headers: {
        "X-CSRF-Token": getMetaValue("csrf-token"),
        "Content-Type": "application/json"
      },
    })
      .then(response => response.text())
      .then(html => {
        this.statesTarget.innerHTML = html
      })
  }

  updateCounties(event) {
    fetch(this.data.get("url"), { 
      method: 'POST', 
      body: JSON.stringify( { state_province: [...event.target.selectedOptions].map(option => option.value)}),
      credentials: "include",
      dataType: 'script',
      headers: {
        "X-CSRF-Token": getMetaValue("csrf-token"),
        "Content-Type": "application/json"
      },
    })
      .then(response => response.text())
      .then(html => {
        this.countiesTarget.innerHTML = html
      })
  }
}

function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`)
  return element.getAttribute("content")
}