import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="load-more"
export default class extends Controller {
  static targets = ['image'];

  connect() {
    console.log("Load more controller connected");
    const images = this.imageTargets;
    console.log(images);
    console.log("hey coucou")
  }
}
