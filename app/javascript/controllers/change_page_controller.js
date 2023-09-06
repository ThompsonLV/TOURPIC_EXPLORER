import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-page"
export default class extends Controller {
  static values = { url: String }

  connect() {

    const url = this.urlValue
    console.log(url);
    setTimeout(function() {
      // Changez l'URL de la page vers celle que vous souhaitez rediriger
      window.location.replace(url)
    }, 2000);
  }
}
