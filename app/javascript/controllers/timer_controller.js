import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {

  static targets = [ "clock" ]
  connect() {
    let  countdown = 30;
    this.clockTarget.innerHTML = countdown;
    const toto =  this.clockTarget
    setInterval(function() {
      countdown = --countdown <= 0 ? 0 : countdown;
      toto.innerHTML = countdown
    }, 1000);
  }
}
