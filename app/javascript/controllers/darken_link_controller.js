import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="darken-link"
export default class extends Controller {
  static targets = ["link1", "link2", "link3"]

  connect() {
    console.log(window.location.pathname);
    const path = window.location.pathname;
    switch (path){
      case "/":
        this.link1Target.classList.add("dark-blue")
        this.link2Target.classList.remove("dark-blue")
        this.link3Target.classList.remove("dark-blue")
        break;
      case "/my_profil":
        this.link1Target.classList.remove("dark-blue")
        this.link2Target.classList.add("dark-blue")
        this.link3Target.classList.remove("dark-blue")
        break;
      case "/parameters":
        this.link1Target.classList.remove("dark-blue")
        this.link2Target.classList.remove("dark-blue")
        this.link3Target.classList.add("dark-blue")
        break;
    }
  }
}
