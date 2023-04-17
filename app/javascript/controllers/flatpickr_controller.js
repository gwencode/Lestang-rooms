import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
// Import the rangePlugin from the flatpickr library
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "startTime", "endTime" ]

  connect() {
    flatpickr(this.startTimeTarget, {
      altInput: true,
      altFormat: "d/m/Y",
      // Provide an id for the plugin to work
      plugins: [new rangePlugin({ input: "#end_date"})]

      // enableTime: true
    })
    flatpickr(this.endTimeTarget, {
      altInput: true,
      altFormat: "d/m/Y",

      // enableTime: true
    })
  }
}
