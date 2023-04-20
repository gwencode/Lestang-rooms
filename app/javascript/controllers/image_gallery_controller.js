import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['gallery', 'image'];

  connect() {
    // On écoute le chargement de toutes les images
    const columns = window.innerWidth >= 992 ? 3 :
                window.innerWidth >= 768 ? 2 : 1;
    if (columns > 1) {
      const images = this.imageTargets;
      images.forEach((image, index) => {
        if (index >= columns) {
          let previousImage = images[index - columns];
          let previousHeight = previousImage.offsetHeight;
          let previousPositionString = previousImage.style.top;
          let previousPosition = parseInt(previousPositionString);
          previousPosition = isNaN(previousPosition) ? 0 : previousPosition;
          let newTopPosition = previousHeight + previousPosition + 16;
          image.style.position = 'relative'
          image.style.top = `${newTopPosition}px`;
        }
      });
      const lastImages = [images[images.length - 1], images[images.length - 2], images[images.length - 3], images[images.length - 4], images[images.length - 5], images[images.length - 6]];
      const maxImagePosition = Math.max(...lastImages.map(image => parseInt(image.style.top)));
      // console.log(maxImagePosition);
      this.galleryTarget.style.height = `${maxImagePosition + images[0].offsetHeight}px`;
      // console.log(this.galleryTarget.style.height);
      // console.log(this.galleryTarget);
    }
  }
}
