import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["togglableElement1", "togglableElement2", "changeTitle"]

  connect() {
  }

  fire() {
    this.togglableElement1Target.classList.toggle("d-none");
    this.togglableElement2Target.classList.toggle("d-none");

    if (this.changeTitleTarget.textContent == "Voir monuments") {
      this.changeTitleTarget.textContent = "Voir classement"
    } else {
      this.changeTitleTarget.textContent = "Voir monuments"
    }
  }
}
