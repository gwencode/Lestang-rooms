import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guests"
export default class extends Controller {
  static targets = ["partial", "guests", "prices", "arrival", "departure", "instruction", "submit", "minNights", "maxNights"]
  static values = { maxGuests: Number }

  connect() {
    // console.log(this.pricesTarget)
    // console.log(this.partialTarget)
    // console.log(this.minNightsTarget)
  }

  decrease() {
    if (1 < parseInt(this.guestsTarget.value)) {
      this.guestsTarget.value = parseInt(this.guestsTarget.value) - 1
      this.setDates()
    }
  }

  increase() {
    if (parseInt(this.guestsTarget.value) < this.maxGuestsValue) {
      this.guestsTarget.value = parseInt(this.guestsTarget.value) + 1
      this.setDates()
    }
  }

  setDates() {
    let arrival = new Date(this.arrivalTarget.value);
    let departure = new Date(this.departureTarget.value);
    let guests = parseInt(this.guestsTarget.value)
    if (departure > arrival) {
      let diff = departure.getTime() - arrival.getTime();
      let nights = Math.ceil(diff / (1000 * 3600 * 24));
      if (nights >= 1) {
        const url =`/rooms/${id}?nights=${nights}&guests=${guests}&arrival=${this.arrivalTarget.value}&departure=${this.departureTarget.value}`
        fetch(url)
        .then(response => response.text())
        .then((html) => {
          // console.log(html);
          this.pricesTarget.innerHTML = html;
          let minNights = parseInt(this.minNightsTarget.innerText)
          let maxNights = parseInt(this.maxNightsTarget.innerText)
          this.partialTarget.classList.remove("d-none");
          if (nights > maxNights) {
            // console.log("nights > maxNights", nights, maxNights)
            this.submitTarget.classList.add("d-none");
            this.instructionTarget.classList.remove("d-none");
          } else if (nights >= minNights) {
            // console.log("nights >= minNights", nights, minNights)
            this.submitTarget.classList.remove("d-none");
            this.instructionTarget.classList.add("d-none");
          } else {
            // console.log("nights < nights", minNights, minNights)
            this.submitTarget.classList.add("d-none");
            this.instructionTarget.classList.remove("d-none");
          }
        })
      }
    } else {
      this.partialTarget.classList.add("d-none")
      this.submitTarget.classList.add("d-none")
      this.instructionTarget.classList.remove("d-none")
    }
  }
}
