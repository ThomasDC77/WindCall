import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  closeModal() {
    this.element.remove()
  }
}
