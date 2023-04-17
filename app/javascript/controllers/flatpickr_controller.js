import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"
// Import the rangePlugin from the flatpickr library
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "startTime", "endTime" ]
  static values = {
    datesDisabled: Array
  }

  connect() {
    // console.log(this.datesDisabledValue)

    flatpickr(this.startTimeTarget, {
      "locale": French,
      altInput: true,
      altFormat: "d/m/Y",
      disable: this.datesDisabledValue,
      // Provide an id for the plugin to work
      plugins: [new rangePlugin({ input: "#end_date"})]

      // enableTime: true
    })
    flatpickr(this.endTimeTarget, {
      "locale": French,
      altInput: true,
      altFormat: "d/m/Y",
      disable: this.datesDisabledValue,
      // enableTime: true
    })
  }
}
