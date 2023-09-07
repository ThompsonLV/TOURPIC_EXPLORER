import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hover-picture"
export default class extends Controller {
  static targets = ["photo", "addlargephoto", "removelargephoto", "blured"]

  connect() {
    console.log("hover picture");
    console.log(this.photoTarget.src);
  }

  addphoto(event) {
    event.preventDefault(event);
    console.log(event.currentTarget);
    const url_image = event.currentTarget.src;
    this.bluredTarget.classList.add("blured");
    this.addlargephotoTarget.insertAdjacentHTML("beforeend", `<img src="${url_image}" alt="" class="large-image" data-hover-picture-target="removelargephoto">`)
  }

  removephoto(event){
    event.preventDefault(event)
    console.log("untouch");
    this.bluredTarget.classList.remove("blured");
    this.removelargephotoTarget.remove()

  }
}
