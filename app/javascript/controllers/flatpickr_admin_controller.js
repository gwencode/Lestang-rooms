import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"

// Connects to data-controller="flatpickr-admin"
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
    console.log("Connected to flatpickr-admin controller")
    if (this.defaultAvailableSlotsValue === false) {
      flatpickr(this.startTimeTarget, {
        "locale": French,
        altInput: true,
        altFormat: "d/m/Y",
        enable: this.arrivalsEnabledValue,
        minDate: "today",
        maxDate: new Date().fp_incr(this.availableDaysValue),
        inline: true,
        position: "auto center"
      })

      flatpickr(this.endTimeTarget, {
        "locale": French,
        altInput: true,
        altFormat: "d/m/Y",
        enable: this.departuresEnabledValue,
        minDate: "today",
        maxDate: new Date().fp_incr(this.availableDaysValue),
        inline: true,
        position: "auto center"
      })

    } else {
      console.log(this.arrivalsDisabledValue)

      flatpickr(this.startTimeTarget, {
        "locale": French,
        altInput: true,
        altFormat: "d/m/Y",
        disable: this.arrivalsDisabledValue,
        minDate: "today",
        maxDate: new Date().fp_incr(this.availableDaysValue),
        inline: true,
        position: "auto center"
      })

      flatpickr(this.endTimeTarget, {
        "locale": French,
        altInput: true,
        altFormat: "d/m/Y",
        disable: this.departuresDisabledValue,
        minDate: "today",
        maxDate: new Date().fp_incr(this.availableDaysValue),
        inline: true,
        position: "auto center"
      })
    }
  }
}
