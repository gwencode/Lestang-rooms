import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guests"
export default class extends Controller {
  static targets = ["price"]
  static values = { maxGuests: Number }

  connect() {
  }

  decrease() {
    if (1 < parseInt(this.priceTarget.value)) {
      this.priceTarget.value = parseInt(this.priceTarget.value) - 1
    }
  }

  increase() {
    if (parseInt(this.priceTarget.value) < this.maxGuestsValue) {
      this.priceTarget.value = parseInt(this.priceTarget.value) + 1
    }
  }
}
