import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-review"
export default class extends Controller {
  static targets = ["form"]

  displayForm() {
    this.formTarget.classList.toggle("d-none")
  }
}
