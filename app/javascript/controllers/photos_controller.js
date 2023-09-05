import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["camera"]
  static values ={
    coordinates: Array,
    monumentId: Number,
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
    });
  }

  async openCamera() {
    this.captureButton.style.display = "block";
    this.cameraFeed.style.display = "block";
    this.cameraButton.style.display = "none";
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } });
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
    // this.capturedImage.style.display = "block";

    fetch(this.capturedImage.src)
    .then(response => response.blob())
    .then(data => {
      const formData = new FormData();
      formData.append('photo', data, 'captured_image.png');
      formData.append('monumentId', this.monumentIdValue);

      fetch(`/monuments/${this.monumentIdValue}/user_monuments`, {
        method: 'POST',
        body: formData,
        headers: {
          Accept: 'application/json',
        },
      })
      .then(() => {
        this.stopCameraStream();
      });
    })
  }

    async stopCameraStream() {
    if (this.cameraFeed.srcObject) {
      const tracks = this.cameraFeed.srcObject.getTracks();
      tracks.forEach(track => track.stop());
      this.cameraFeed.srcObject = null;
    }
    window.location.reload();
  }

  verifieUserLocation() {
    const monumentCoordinates = this.coordinatesValue
    const camera = this.cameraTarget

    navigator.geolocation.getCurrentPosition(function(position) {
      const userLongitude = position.coords.longitude;
      const userLatitude = position.coords.latitude;
      const userCoordinates = [userLatitude, userLongitude]

      fetch(`/distance?user=${userCoordinates}&monument=${monumentCoordinates}`)
      .then(response => response.json())
      .then(data => {
        if (data <= 0.03) {
          camera.classList.remove("d-none");
        } else {
          camera.classList.add("d-none");
        }
      });
    });
  };
};
