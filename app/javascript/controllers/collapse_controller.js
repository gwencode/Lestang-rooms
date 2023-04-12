import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="collapse"
export default class extends Controller {
  connect() {
    console.log("Collapse controller connected")
  }

  hide() {
    console.log(this.element)
    this.element.classList.add("d-none")
  }
}
