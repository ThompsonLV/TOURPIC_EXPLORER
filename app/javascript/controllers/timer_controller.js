import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {

  static targets = [ "clock" ]
  connect() {
    console.log("ok")
    const clock = this.clockTarget;
    let timeLeft = 30;

    const timerId = setInterval(countdown, 1000);

    function countdown() {
      if (timeLeft == -1) {
        clearTimeout(timerId);
        doSomething();
      } else {
        clock.innerHTML = timeLeft
        console.log(clock)
        timeLeft--;
      }
    }
  }
}
