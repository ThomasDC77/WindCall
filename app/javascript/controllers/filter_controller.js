import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  selectFilter(event) {
    const parentElement = event.currentTarget.parentElement;
    const img = parentElement.querySelector(".css-logo-button");
    img.classList.toggle('selected');
  }
}
