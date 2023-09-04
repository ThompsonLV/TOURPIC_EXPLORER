import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    end: Array,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    const end = this.endValue

    let start; // Variable pour stocker le point de départ

    navigator.geolocation.getCurrentPosition(function(position) {
      const userLongitude = position.coords.longitude
      const userLatitude = position.coords.latitude
      start = [userLongitude, userLatitude]

      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v12',
        center: start,
        zoom: 10
      })

      async function getRoute(end) {
        const url = `https://api.mapbox.com/directions/v5/mapbox/walking/${start[0]}%2C${start[1]}%3B${end[0]}%2C${end[1]}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=pk.eyJ1IjoiY2hhcmxlc2RtIiwiYSI6ImNsa3RxdmQ4ZDBkZTQzZHBwdmhsd3d1bzcifQ.v8xgyQaTJA9sW6y7NMcM4w`
        const query = await fetch(url, { method: 'GET' })

        const json = await query.json()

        const data = json.routes[0]
        const route = data.geometry.coordinates
        const geojson = {
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'LineString',
            coordinates: route
          }
        }

        // Si la route existe déjà sur la carte, nous la réinitialiserons en utilisant setData
        if (map.getSource('route')) {
          map.getSource('route').setData(geojson)
        } else {
          map.addLayer({
            id: 'route',
            type: 'line',
            source: {
              type: 'geojson',
              data: geojson
            },
            layout: {
              'line-join': 'round',
              'line-cap': 'round'
            },
            paint: {
              'line-color': '#3887be',
              'line-width': 5,
              'line-opacity': 0.75
            }
          })
        }

        // Ajoutez un point à l'arrivée et définissez sa couleur
        map.addLayer({
          id: 'end-point',
          type: 'circle',
          source: {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [
                {
                  type: 'Feature',
                  properties: {},
                  geometry: {
                    type: 'Point',
                    coordinates: end // Les coordonnées de l'arrivée
                  }
                }
              ]
            }
          },
          paint: {
            'circle-radius': 8,
            'circle-color': '#3887be' // Couleur rouge
          }
        })
      }

      map.on('load', () => {
        // Faites une demande initiale d'itinéraire au chargement de la carte
        getRoute(end)

        // Ajoutez le point de départ à la carte
        map.addLayer({
          id: 'start-point',
          type: 'circle',
          source: {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [
                {
                  type: 'Feature',
                  properties: {},
                  geometry: {
                    type: 'Point',
                    coordinates: start
                  }
                }
              ]
            }
          },
          paint: {
            'circle-radius': 8,
            'circle-color': '#3887be' // Couleur bleue
          }
        })
      })
    })
  }
}
