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
          // console.log(previousHeight)
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

  expandImage(event) {
    const clickedImage = event.currentTarget;
    // console.log(clickedImage);
    const src = clickedImage.getAttribute('src');
    // console.log(src);

    const modal = document.createElement('div');
    modal.classList.add('modal', 'fade');
    modal.setAttribute('tabindex', '-1');
    modal.setAttribute('role', 'dialog');
    modal.innerHTML = `
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-body text-center">
            <img src="${src}" class="img-fluid" style="max-height: 80vh; position: relative" alt="">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="position: absolute; right: 16px"></button>
          </div>
        </div>
      </div>
    `;
    document.body.appendChild(modal);
    $(modal).modal('show');
    $(modal).on('hidden.bs.modal', function () {
      document.body.removeChild(modal);
    });
  }
}
