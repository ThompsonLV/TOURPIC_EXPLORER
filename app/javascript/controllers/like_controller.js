import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {

  connect() {
    this.clicked = false
    this.stop = false
  }
    aime(event) {
      if (this.stop) return;

      if (this.clicked) {
        const x = event.x
        const y = event.y
        const html = `<i class="fas fa-heart heart" style="top: ${y}px; left: ${x}px"></i>`
        event.currentTarget.insertAdjacentHTML("afterend", html)
        setTimeout(() => {
          document.querySelector(".heart").classList.add("go")
        }, 1000);
        this.stop = true

        const token = document.querySelector("meta[name='csrf-token'").content
        fetch(`/user_monuments/${event.currentTarget.dataset.userMonumentId}`, {
          method: "PATCH",
          headers: {
            'X-CSRF-Token': token,
          }
        })
      }
      this.clicked = true
      setTimeout(() => {
        this.clicked = false
      }, 1000);
    }
}
