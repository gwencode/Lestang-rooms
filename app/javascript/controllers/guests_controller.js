import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="guests"
export default class extends Controller {
  static targets = ["partial", "guests", "prices", "arrival", "departure", "instruction", "submit"]
  static values = { maxGuests: Number }

  connect() {
    // console.log(this.pricesTarget)
    // console.log(this.partialTarget)
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
    let dateStr = this.arrivalTarget.value
    // console.log(dateStr)
    let guests = parseInt(this.guestsTarget.value)
    // console.log(guests)
    if (dateStr.length > 11) {
      let arrival = dateStr.substring(0, 10);
      let departure = dateStr.substring(14);
      let date2 = new Date(departure);
      let date1 = new Date(arrival);
      let diff = date2.getTime() - date1.getTime();
      let nights = Math.ceil(diff / (1000 * 3600 * 24));
      if (nights >= 1) {
        const url =`/rooms/${id}?nights=${nights}&guests=${guests}`
        fetch(url)
        .then(response => response.text())
        .then((html) => {
          // console.log(html);
          this.pricesTarget.innerHTML = html;
          this.partialTarget.classList.remove("d-none");
          this.submitTarget.classList.remove("d-none");
          this.instructionTarget.classList.add("d-none");
        })
      }
    } else {
      this.partialTarget.classList.add("d-none")
      this.submitTarget.classList.add("d-none")
      this.instructionTarget.classList.remove("d-none")
    }
  }
}
