import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["unlockedMonuments", "myMonuments", "classement"]
  connect() {

  }

  toggle1(event){
    event.preventDefault()
    console.log("element1");
    this.unlockedMonumentsTarget.classList.remove("d-none");
    this.myMonumentsTarget.classList.add("d-none");
    this.classementTarget.classList.add("d-none")
  }

  toggle2(event){
    event.preventDefault()
    console.log("element2");
    this.myMonumentsTarget.classList.remove("d-none");
    this.unlockedMonumentsTarget.classList.add("d-none");
    this.classementTarget.classList.add("d-none")
  }

  toggle3(event){
    event.preventDefault()
    console.log("element3");
    this.classementTarget.classList.remove("d-none");
    this.unlockedMonumentsTarget.classList.add("d-none");
    this.myMonumentsTarget.classList.add("d-none")
  }
}
