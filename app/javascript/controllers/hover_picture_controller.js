import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hover-picture"
export default class extends Controller {
  static targets = ["photo", "addlargephoto", "removelargephoto", "blured"]

  connect() {
    console.log("hover picture");
    console.log(this.photoTarget.src);


    // this.photoTarget.addEventListener("touchstart", (event) => {
    //   clearTimeout(timer)
    //   const url_image = event.currentTarget.src;
    //   timer = setTimeout((event) => {
    //       this.bluredTarget.classList.add("blured");
    //       this.addlargephotoTarget.insertAdjacentHTML("beforeend", `<img src="${url_image}" alt="" class="large-image" data-hover-picture-target="removelargephoto">`)
    //     }, 500);
    // })

    // this.photoTarget.addEventListener("touchend", () => {
    //   console.log("untouch");
    //   if (this.removelargephotoTarget)  {
    //     this.bluredTarget.classList.remove("blured");
    //     this.removelargephotoTarget.remove();
    //   }
    //   clearTimeout(timer)
    // })

  }

  addphoto(event) {
    // let touchDuration = 0;
    // const startTime = Date.now();
    // console.log("start time", startTime);

    const url_image = event.currentTarget.src;
    this.timer = setTimeout((event) => {
        this.bluredTarget.classList.add("blured");
        this.toto = this.addlargephotoTarget.insertAdjacentHTML("beforeend", `<img id="toto" src="${url_image}" alt="" class="large-image" data-hover-picture-target="removelargephoto">`)
      }, 300);
    }



  removephoto(event){
    console.log("untouch");
    const toto = document.querySelector("#toto")
    if (document.querySelector("#toto"))  {
      this.bluredTarget.classList.remove("blured");
      toto.remove();
    }
    clearTimeout(this.timer)
  }
}
