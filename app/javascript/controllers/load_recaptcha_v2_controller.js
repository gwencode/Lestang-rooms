import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { siteKey: String }

  connect() {
    console.log("Hello, Recaptcha Controller!", this.siteKeyValue)
  }

  initialize() {
    console.log("Replace Recaptcha!", this.siteKeyValue)
    grecaptcha.render("recaptchaV2", { sitekey: this.siteKeyValue } )
  }
}
