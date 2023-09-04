import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swiper"
export default class extends Controller {
  static targets = ["touch", "unlockedMonuments", "myMonuments", "classement"];


  connect() {
  }

  handleStart(evt) {
  const touch = evt.touches[0];
  this.xPosStart = touch.clientX;
  evt.preventDefault();
  }

  handleEnd(evt) {
    const touch = evt.changedTouches[0];
    const xPosEnd = touch.clientX;
    evt.preventDefault();
    const myMonuments = this.myMonumentsTarget
    const unlockedMonuments = this.unlockedMonumentsTarget
    const classement = this.classementTarget


    const difference = xPosEnd - this.xPosStart;
    const minDistance = 100
    console.log("Différence entre xPosStart et xPosEnd:", difference);
    if (difference < -minDistance && !unlockedMonuments.classList.contains("d-none")) {
      unlockedMonuments.classList.add("d-none");
      myMonuments.classList.remove("d-none");
    }else if(difference < -minDistance && !myMonuments.classList.contains("d-none")){
      myMonuments.classList.add("d-none");
      classement.classList.remove("d-none");
    }else if(difference < -minDistance && !classement.classList.contains("d-none")){
      classement.classList.add("d-none");
      unlockedMonuments.classList.remove("d-none");
    }else if (difference > minDistance && !unlockedMonuments.classList.contains("d-none")) {
      unlockedMonuments.classList.add("d-none");
      classement.classList.remove("d-none");
    }else if(difference > minDistance && !myMonuments.classList.contains("d-none")){
      myMonuments.classList.add("d-none");
      unlockedMonuments.classList.remove("d-none");
    }else if(difference > minDistance && !classement.classList.contains("d-none")){
      classement.classList.add("d-none");
      myMonuments.classList.remove("d-none");
    }else{
    }
  }
}
