import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guests"
export default class extends Controller {
  static targets = ["guests", "prices", "arrival", "departure"]
  static values = { maxGuests: Number }

  connect() {
    console.log(this.pricesTarget)
  }

  decrease() {
    if (1 < parseInt(this.guestsTarget.value)) {
      this.guestsTarget.value = parseInt(this.guestsTarget.value) - 1
    }
  }

  increase() {
    if (parseInt(this.guestsTarget.value) < this.maxGuestsValue) {
      this.guestsTarget.value = parseInt(this.guestsTarget.value) + 1
    }
    console.log(this.arrivalTarget.value)
    console.log(typeof(this.arrivalTarget.value))
  }

  setDates() {
    let dateStr = this.arrivalTarget.value
    if (dateStr.length > 11) {
      let arrival = dateStr.substring(0, 10);
      let departure = dateStr.substring(14);
      let date2 = new Date(departure);
      let date1 = new Date(arrival);
      let diff = date2.getTime() - date1.getTime();
      let days = Math.ceil(diff / (1000 * 3600 * 24));
      // console.log(days)
    }
  }
}
