import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quizz"
export default class extends Controller {
  static targets = ["input", "quizz", "form", "hidden"]

  connect() {
    this.questions = []
  }

  answer(event) {
    event.preventDefault();

    const url = `${this.formTarget.action}`
    this.questions.push(this.formTarget.dataset.questionId)
    this.hiddenTarget.value = this.questions

    console.log(this.questions);

    fetch(url, {
      method: "POST",
      headers: {
        Accept: "text/plain"
      },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then(data => {
        console.log(data);
        this.quizzTarget.innerHTML = data
      })
  }
}
