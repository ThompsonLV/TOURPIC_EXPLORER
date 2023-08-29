import { Controller } from "@hotwired/stimulus"

static targets = ["togglableElement"]

// Connects to data-controller="quizz"
export default class extends Controller {
  connect() {
    console.log("hello")
  }

}
