import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {
  static targets = ["countdown"];

  connect() {
    console.log("Connected");
  }

  startCountdown(secondsUntilEnd) {
    const now = new Date().getTime();
    const endTime = new Date(now + secondsUntilEnd * 1000);

    const countdown = setInterval(() => {
      const now = new Date();
      const secondsRemaining = (endTime - now) / 1000;

      if (secondsRemaining <= 0){
        clearInterval(countdown);
        this.countdownTarget.innerHTML = "Reminder Time";
        return;
      }

      const secondsPerDay = 86400;
      const secondsPerHour = 3600;
      const secondsPerMinute = 60;

      const days = Math.floor(secondsRemaining/secondsPerDay);
      const hours = Math.floor((secondsRemaining%secondsPerDay)/secondsPerHour);
      const minutes = Math.floor((secondsRemaining%secondsPerHour)/secondsPerMinute);
      const seconds = Math.floor(secondsRemaining%secondsPerMinute);

      this.countdownTarget.innerHTML = `${days} days, ${hours} hours, ${minutes} minutes, ${seconds} seconds`;
    }, 1000);
  }

  sendEmails() {
    const secondsUntilEnd = this.countdownTarget.dataset.secondsUntilEndValue;
    this.startCountdown(secondsUntilEnd);
  }
}