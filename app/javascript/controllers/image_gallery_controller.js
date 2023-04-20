import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['gallery', 'image'];

  connect() {
    // On écoute le chargement de toutes les images
    const images = this.imageTargets;
    images.forEach((image, index) => {
      // console.log(`Hauteur de l'image : ${image.offsetHeight}px`);
      // console.log(`Position de l'image : ${image.offsetTop}px`);

      // const position = image.getBoundingClientRect().top;
      // const height = image.getBoundingClientRect().height;

      if (index >= 3) {
        let previousImage = images[index - 3];
        // console.log('index', index + 1, 'previousImage', previousImage);

        // console.log('---------------------');

        let previousHeight = previousImage.offsetHeight;
        // console.log(typeof(previousHeight))
        // console.log('previousHeight', previousHeight)

        // console.log('---------------------');

        let previousPositionString = previousImage.style.top;
        // console.log(typeof(previousPositionString))
        // console.log('previousPositionString', previousPositionString)

        // console.log('---------------------');

        let previousPosition = parseInt(previousPositionString);
        previousPosition = isNaN(previousPosition) ? 0 : previousPosition;
        // console.log(typeof(previousPosition))
        // console.log('previousPosition', previousPosition)

        // console.log('---------------------');

        let newTopPosition = previousHeight + previousPosition + 16;
        // console.log(typeof(previousPosition))
        // console.log('newTopPosition', newTopPosition);

        // console.log('---------------------');

        image.style.position = 'relative'
        image.style.top = `${newTopPosition}px`;
        // console.log('image.style.top', image.style.top)

        // console.log('---------------------');
        // console.log('---------------------');
        // console.log(image);
        // console.log('new image-position', image.offsetTop)
      }
    });
    const lastImage = images[images.length - 1];
    const lastImagePosition = lastImage.style.top;
    this.galleryTarget.style.height = lastImagePosition;
    console.log(this.galleryTarget);
  }
}

// export default class extends Controller {
//   static targets = ['image'];

//   connect() {
//     // On écoute le chargement de toutes les images
//     const images = this.imageTargets;
//     const promises = images.map(image => new Promise(resolve => {
//       if (image.complete) {
//         resolve();
//       } else {
//         image.addEventListener('load', resolve);
//         image.addEventListener('error', resolve);
//       }
//     }));
//     Promise.all(promises).then(() => {
//       // On calcule les hauteurs des images et on les positionne
//       this.positionImages();
//     });
//   }

//   positionImages() {
//     const images = this.imageTargets;
//     const cols = 3; // nombre de colonnes
//     const colWidth = 100 / cols; // largeur de chaque colonne en pourcentage
//     let colHeights = new Array(cols).fill(0); // tableau des hauteurs de chaque colonne
//     images.forEach(image => {
//       // On trouve la colonne la plus courte
//       const minCol = colHeights.indexOf(Math.min(...colHeights));
//       // On calcule la position de l'image
//       const xPos = minCol * colWidth;
//       const yPos = colHeights[minCol];
//       // On positionne l'image
//       image.style.position = 'absolute';
//       image.style.left = `${xPos}%`;
//       image.style.top = `${yPos}px`;
//       // On met à jour la hauteur de la colonne
//       colHeights[minCol] += image.offsetHeight;
//     });
//     // On définit la hauteur de la galerie pour éviter les débordements
//     const maxHeight = Math.max(...colHeights);
//     this.element.style.height = `${maxHeight}px`;
//   }
// }
