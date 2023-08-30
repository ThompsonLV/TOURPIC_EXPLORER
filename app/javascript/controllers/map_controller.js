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
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.#getUserLocationAndRoute()
    // Ajouté
  }

  #addMarkersToMap() {
    console.log(this.markersValue);

    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #getUserLocationAndRoute() {
    navigator.geolocation.getCurrentPosition(position => {
      const userLngLat = [position.coords.longitude, position.coords.latitude];

      const directions = new MapboxDirections({
        accessToken: mapboxgl.accessToken,
        unit: 'km',
        profile: 'mapbox/driving-traffic', // Vous pouvez ajuster le profil de déplacement
        interactive: false,
        controls: { instructions: false }
      });

      directions.setOrigin(userLngLat);
      directions.setDestination([ MONUMENT_LONGITUDE, MONUMENT_LATITUDE ]);

      this.map.addControl(directions, 'top-left');
    });
  }
}
