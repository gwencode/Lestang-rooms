import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-review"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("Hello from edit_review_controller.js")
  }

  displayForm() {
    this.formTarget.classList.toggle("d-none")
  }
}
