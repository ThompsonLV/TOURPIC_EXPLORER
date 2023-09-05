import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quizz"
export default class extends Controller {
  static targets = ["input", "quizz", "form", "hidden", "suivant"]

  connect() {
    this.questions = [];
  }

  select(event) {

    if (event.currentTarget.dataset.success === "true") {
      this.inputTargets.forEach((input => {
        if (!input.checked){
          input.disabled = true;
        }
      } ))
      event.currentTarget.classList.add("correct-answer")
      this.suivantTarget.disabled = false
    } else {
      this.inputTargets.forEach((input => {
        if (!input.checked) { input.disabled = true; }
      } ))

      event.currentTarget.classList.add("incorrect-answer")

      this.suivantTarget.disabled = false

      const correctAnswer = this.quizzTarget.querySelector('[data-success="true"]');
      if (correctAnswer) {
        correctAnswer.classList.add("correct-answer");
      }
    }

  }
  next(event) {
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
