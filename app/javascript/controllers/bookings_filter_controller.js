import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bookings-filter"
export default class extends Controller {
  connect() {
    console.log("Connected to bookings-filter controller")
  }

  allFilter() {
    console.log("click")
  }

  futurFilter() {
    console.log("click futur")
  }

  pastFilter() {
    console.log("click past")
  }
}
