import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "overlay", "calendarContent"]

  openCalendar() {
    this.overlayTarget.classList.remove('hidden');

    fetch("/calendars")
    .then(response => response.text())
    .then(html => {
      this.calendarContentTarget.innerHTML = html;
    })
    .catch(error => {
      console.error(error);
    });
  }

  closeCalendar() {
    this.overlayTarget.classList.add('hidden');
  }
}
