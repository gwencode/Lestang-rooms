import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    // Ajouter des écouteurs d'événement pour le zoom de la carte
    this.map.on("zoom", () => {
      // Appeler une méthode pour modifier la taille de l'élément
      this.#updateMarkerSize()
    })
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 14, duration: 0 })
  }

  #updateMarkerSize() {
    const background = document.getElementById("background-marker")
    const zoom = this.map.getZoom()
    if (zoom > 15) {
      const size = 400 + (zoom - 14) * 500 // Modifier cette valeur pour ajuster la taille des marqueurs en fonction de votre préférence
      background.style.width = size + "px"
      background.style.height = size + "px"
    } else if (zoom > 14) {
      const size = 400 + (zoom - 14) * 400
      background.style.width = size + "px"
      background.style.height = size + "px"
    } else if (zoom > 13.5) {
      const size = 400 + (zoom - 14) * 300
      background.style.width = size + "px"
      background.style.height = size + "px"
    } else if (zoom > 12.8) {
      const size = 400 + (zoom - 14) * 200
      background.style.width = size + "px"
      background.style.height = size + "px"
    } else {
      const size = 400 + (zoom - 14) * 170
      background.style.width = size + "px"
      background.style.height = size + "px"
    }
  }
}
