import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="table"
export default class extends Controller {
  static targets = ["goodWeathers", "allWeathers"]
  connect() {
    console.log("table controller");
    console.log(this.goodWeathersTarget);
    console.log(this.allWeathersTarget);
  }

  changeTable() {
    this.goodWeathersTarget.classList.toggle("hidden")
    this.allWeathersTarget.classList.toggle("hidden")
  }
}
