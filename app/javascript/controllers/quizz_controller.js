import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="quizz"
export default class extends Controller {
  static values = { numberOfQuestions: Number, numberOfAnsweredQuestions: Number }
  static targets = ["input", "quizz", "answer"]

  connect() {
    console.log("connect");
    console.log(this.numberOfQuestionsValue);
    this.quizzTarget.dataset.numberOfAnsweredQuestions = 1

  }

  increment(event) {
    event.preventDefault();
    console.log("button");
    console.log(this.inputTarget.value) // me rend l'id de l'answer
    console.log(this.answerTarget.action) // me donne le path de user_answer

    const url = `${this.answerTarget.action}`

    fetch(url, {
      method: "POST",
      headers: {},
      body: JSON.stringify(data, this.inputTarget)
    })
      .then(response => response.text())
      .then(response.text)
  }
}
