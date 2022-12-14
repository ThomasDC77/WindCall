import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  connect() {
    console.log(this.element.classList);
    const container = this.element
    setTimeout(() => {
      container.classList.remove('loading')
      container.classList.add('loaded')
    }, 1000);
  }
}
