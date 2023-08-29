import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="quizz"
export default class extends Controller {

  connect() {
    console.log("connect");
  }

  increment() {
    console.log("button");
    console.log();
    // il faut changer l'index
    // il faut rendre la nouvelle partial avec l'index augmenté
    // quand l'index > 5, alors affiché un bouton submit
  }
}
