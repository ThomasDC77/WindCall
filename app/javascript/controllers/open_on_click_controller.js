import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="open-on-click"
export default class extends Controller {

  connect() {
    console.log("Toto le Zozo");
  }

  static targets = [ "description" ]


  toggleDescription() {
    this.descriptionTarget.hidden = !this.descriptionTarget.hidden
  }
}
