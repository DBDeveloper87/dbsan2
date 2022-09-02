import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { orders: String }
  static targets = [ 'orders_menu', 'rightside' ]

  renderOrders() {
    fetch(this.ordersValue)
      .then(response => response.text())
      .then(html => this.rightsideTarget.innerHTML = html)
  }
}