import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="table"
export default class extends Controller {
  static targets = ["goodWeathers", "allWeathers"]
  connect() {
    console.log(this.goodWeathersTarget);
    console.log(this.allWeathersTarget);
  }

  changeTable(event) {
    const btn = event.currentTarget
    if (btn.classList.contains("less")) {
      btn.innerText = "Voir plus"
    } else {
      btn.innerText = "Voir moins"
    }
    btn.classList.toggle("less")
    this.goodWeathersTarget.classList.toggle("hidden")
    this.allWeathersTarget.classList.toggle("hidden")
  }
}
