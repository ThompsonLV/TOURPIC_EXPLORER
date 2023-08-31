import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photos"
export default class extends Controller {

  static targets = ["camera"]
  static values ={
    coordinates: Array
  }

  connect() {
    this.verifieUserLocation();
    this.cameraButton = this.element.querySelector("#camera-button");
    this.cameraFeed = this.element.querySelector("#camera-feed");
    this.capturedImage = this.element.querySelector("#captured-image");
    this.captureButton = this.element.querySelector("#capture-button");

    this.cameraButton.addEventListener("click", this.openCamera.bind(this));
    this.captureButton.addEventListener("click", () => {
      this.capturePicture();
      this.stopCameraStream(); // Call the method to stop the camera stream
    });
  }

  async openCamera() {
    this.captureButton.style.display = "block";
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ video: true });
      this.cameraFeed.srcObject = stream;
    } catch (error) {
      console.error("Erreur lors de l'accès à la caméra :", error);
    }
  }

  async capturePicture() {
    const canvas = document.createElement("canvas");
    canvas.width = this.cameraFeed.videoWidth;
    canvas.height = this.cameraFeed.videoHeight;

    const context = canvas.getContext("2d");
    context.drawImage(this.cameraFeed, 0, 0, canvas.width, canvas.height);

    this.capturedImage.src = canvas.toDataURL("image/png");
    this.capturedImage.style.display = "block";
    setTimeout(() => {
      this.capturedImage.style.display = "none";
      this.captureButton.style.display = "none";
    }, 3000);
  }

  stopCameraStream() {
    if (this.cameraFeed.srcObject) {
        const tracks = this.cameraFeed.srcObject.getTracks();
        tracks.forEach(track => track.stop());
        this.cameraFeed.srcObject = null;
    }
  }

  verifieUserLocation() {
    const monumentCoordinates = this.coordinatesValue
    const camera = this.cameraTarget
    console.log("Monument coordonnée", monumentCoordinates);

    navigator.geolocation.getCurrentPosition(function(position) {
      const userLongitude = position.coords.longitude;
      const userLatitude = position.coords.latitude;
      const userCoordinates = [userLatitude, userLongitude]
      console.log("User coordonnée", userCoordinates);

      fetch(`/distance?user=${userCoordinates}&monument=${monumentCoordinates}`)
      .then(response => response.json())
      .then(data => {
        if (data <= 0.03) {
          camera.classList.toggle("d-none");
          console.log("yup");
        } else {
          console.log("nope");
        }
      });
    });
  };
};
