// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="carousel-height"
// export default class extends Controller {
//   static targets = ["carousel", "item" ]

//   connect() {
//     console.log("Hello Carousel Controller!");
//     console.log(this.carouselTarget);
//     console.log(this.itemTargets);

//     let maxHeight = 0;
//     this.itemTargets.forEach((item) => {
//       console.log("item: ", item)
//       const height = item.offsetHeight;
//       console.log("height of item: ", height);
//       if (height > maxHeight) {
//         maxHeight = height;
//         console.log("max height in loop: ", maxHeight);
//       }
//     });
//     console.log("max height after loop: ", maxHeight);
//     console.log(maxHeight);
//     console.log("carouselTarget.style.height before change: ", this.carouselTarget.style.height);
//     this.carouselTarget.style.height = `${maxHeight}px`;
//     console.log("carouselTarget.style.height after change: ", this.carouselTarget.style.height);
//   }
// }
