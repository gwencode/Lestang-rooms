import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="up-button"
export default class extends Controller {
  static targets = [ "button" ]

  connect() {
    window.addEventListener("scroll", this.handleScroll.bind(this))
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this))
  }

  handleScroll() {
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop

    if (scrollTop > 400) {
      this.buttonTarget.classList.remove("d-none")
      // console.log("higher scroll 400")
    } else {
      this.buttonTarget.classList.add("d-none")
    }
  }

  // hide() {
  //   this.element.classList.add("d-none")
  // }
}
