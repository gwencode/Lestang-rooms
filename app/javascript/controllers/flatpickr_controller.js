import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"
// Import the rangePlugin from the flatpickr library
// import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "startTime", "endTime" ]
  static values = {
    arrivalsDisabled: Array,
    departuresDisabled: Array,
    defaultAvailableSlots: Boolean,
    arrivalsEnabled: Array,
    departuresEnabled: Array,
    availableDays: Number
  }

  connect() {
    console.log(this.defaultAvailableSlotsValue)


    if (this.defaultAvailableSlotsValue === false) {
      console.log("if")
      console.log(this.arrivalsEnabledValue)
      console.log(this.departuresEnabledValue)

      flatpickr(this.startTimeTarget, {
        "locale": French,
        altInput: true,
        altFormat: "d/m/Y",
        enable: this.arrivalsEnabledValue,
        minDate: "today",
        maxDate: new Date().fp_incr(this.availableDaysValue),
      })

      flatpickr(this.endTimeTarget, {
        "locale": French,
        altInput: true,
        altFormat: "d/m/Y",
        enable: this.departuresEnabledValue,
        minDate: "today",
        maxDate: new Date().fp_incr(this.availableDaysValue)
        // enableTime: true
      })

    } else {
      console.log("else")
      console.log(this.arrivalsDisabledValue)

      flatpickr(this.startTimeTarget, {
        "locale": French,
        altInput: true,
        altFormat: "d/m/Y",
        disable: this.arrivalsDisabledValue,
        minDate: "today",
        maxDate: new Date().fp_incr(this.availableDaysValue),
      })

      flatpickr(this.endTimeTarget, {
        "locale": French,
        altInput: true,
        altFormat: "d/m/Y",
        disable: this.departuresDisabledValue,
        minDate: "today",
        maxDate: new Date().fp_incr(this.availableDaysValue)
        // enableTime: true
      })
    }
  }

  // flatpickr(this.startTimeTarget, {
    // disable: this.arrivalsDisabledValue,
    // // Provide an id for the plugin to work
    // plugins: [new rangePlugin({ input: "#departure"})]
    // enableTime: true
  // })

}
