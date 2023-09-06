import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="darken-link"
export default class extends Controller {
  static targets = ["link1", "link2", "link3"]

  connect() {
    setTimeout(function(){
  }, 2000);
    console.log("URL de la page : ", window.location.pathname);
  }
}
