import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="direction"
export default class extends Controller {
  static values = {
    apiKey: String,
    end: Array,
  }
  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    const end = this.endValue
    console.log(end);
    // const start = [-122.677738,45.522458]

    navigator.geolocation.getCurrentPosition(function(position) {
      const userLongitude = position.coords.longitude;
      const userLatitude = position.coords.latitude;
      const start = [userLongitude, userLatitude];
      console.log("start", start);
      console.log("end", end);
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v12',
        center: start,
        zoom: 10
      });

      async function getRoute(end) {


        const url = `https://api.mapbox.com/directions/v5/mapbox/walking/${start[0]}%2C${start[1]}%3B${end[0]}%2C${end[1]}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=pk.eyJ1IjoiY2hhcmxlc2RtIiwiYSI6ImNsa3RxdmQ4ZDBkZTQzZHBwdmhsd3d1bzcifQ.v8xgyQaTJA9sW6y7NMcM4w`
        // const url = `https://api.mapbox.com/directions/v5/mapbox/walking/${start[0]},${start[1]};${end[0]},${end[1]}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=${mapboxgl.accessToken}`
        const query = await fetch(url,
          { method: 'GET' }
        );

        const json = await query.json();

        const data = json.routes[0];
        const route = data.geometry.coordinates;
        const geojson = {
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'LineString',
            coordinates: route
          }
        };
            // if the route already exists on the map, we'll reset it using setData
        if (map.getSource('route')) {
          map.getSource('route').setData(geojson);
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
          });
        }
      }

      map.on('load', () => {

        // make an initial directions request that
        // starts and ends at the same location
        getRoute(end);

        // Add starting point to the map
        map.addLayer({
          id: 'point',
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
            'circle-color': '#3887be'
          }
        });
      });
    });
  }
}
