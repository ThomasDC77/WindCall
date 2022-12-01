import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="filters"
export default class extends Controller {
  static targets = [
    "form",
    "sliderOne",
    "sliderTwo",
    "rangeOne",
    "rangeTwo",
    "sliderBar",
  ];
  connect() {
    console.log("coucou");
    this.minGap = 0;
    this.sliderMaxValue = this.sliderOneTarget.max;
    this.slideOne();
    this.slideTwo();
  }

  slideOne() {
    if (
      parseInt(this.sliderTwoTarget.value) -
        parseInt(this.sliderOneTarget.value) <=
      this.minGap
    ) {
      this.sliderOneTarget.value =
        parseInt(this.sliderTwoTarget.value) - this.minGap;
    }
    this.rangeOneTarget.textContent = this.sliderOneTarget.value;
    this.fillColor();
  }

  slideTwo() {
    if (
      parseInt(this.sliderTwoTarget.value) -
        parseInt(this.sliderOneTarget.value) <=
      this.minGap
    ) {
      this.sliderTwoTarget.value =
        parseInt(this.sliderOneTarget.value) + this.minGap;
    }
    this.rangeTwoTarget.textContent = this.sliderTwoTarget.value;
    this.fillColor();
  }

  fillColor() {
    this.percent1 = (this.sliderOneTarget.value / this.sliderMaxValue) * 100;
    this.percent2 = (this.sliderTwoTarget.value / this.sliderMaxValue) * 100;
    this.sliderBarTarget.style.background = `linear-gradient(to right, #dadae5 ${this.percent1}% , #1C3E46 ${this.percent1}% , #1C3E46 ${this.percent2}%, #dadae5 ${this.percent2}%)`;
  }
}
