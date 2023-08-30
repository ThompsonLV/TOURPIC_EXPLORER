import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photos"
export default class extends Controller {
  // connect() {
  //   this.cameraButton = this.element.querySelector("#camera-button");
  //   this.cameraFeed = this.element.querySelector("#camera-feed");

  //   console.log(this.cameraButton);

  //   this.cameraButton.addEventListener("click", this.openCamera.bind(this));
  // }
  // async openCamera() {
  //   try {
  //     const stream = await navigator.mediaDevices.getUserMedia({ video: true });
  //     this.cameraFeed.srcObject = stream;
  //   } catch (error) {
  //     console.error("Erreur lors de l'accès à la caméra :", error);
  //   }
  // }
}
