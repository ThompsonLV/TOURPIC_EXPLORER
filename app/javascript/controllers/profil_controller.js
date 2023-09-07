import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profil"
export default class extends Controller {
  static targets = ["avatar"];

  connect() {
    console.log(this.avatarTarget);

    const originalWidth  = this.avatarTarget.style.width;
    const originalHeight = this.avatarTarget.style.height;

    document.addEventListener('scroll', (e) => {
      const scrollY = window.scrollY;
      console.log(scrollY);
      if (scrollY > 200) {
        // this.avatarTarget.style.width = '60px';
        // this.avatarTarget.style.height = '60px';
        this.avatarTarget.classList.add('small')
      } else {
        // this.avatarTarget.style.width = originalWidth;
        // this.avatarTarget.style.height = originalHeight;
        this.avatarTarget.classList.remove('small')
      }
    })
  }
}
