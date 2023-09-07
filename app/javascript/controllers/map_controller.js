import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [4.8348625, 45.7694579], // starting center in [lng, lat]
      zoom: 12 // starting zoom
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.#addLocateUserToMap()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      if (marker.info_window) {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window)

        const customMarker = document.createElement("div")
        customMarker.innerHTML = marker.marker_html

        new mapboxgl.Marker(customMarker)
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup)
          .addTo(this.map)
        } else {
          new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(this.map)
      }
    })
  }
  #fitMapToMarkers() {
    // const bounds = new mapboxgl.LngLatBounds()
    // this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    // this.map.fitBounds(bounds, { padding: 20, maxZoom: 30, duration: 0 })
  }

  #addLocateUserToMap() {
    // Add geolocate control to the map.
    this.map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
        enableHighAccuracy: true
        },
        // When active the map will receive updates to the device's location as it changes.
        trackUserLocation: true,
        // Draw an arrow next to the location dot to indicate which direction the device is heading.
        showUserHeading: true
      }),
    );
  }

}
