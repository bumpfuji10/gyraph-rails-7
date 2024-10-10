import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "overlay", "calendarContent"]

  // コントローラーのインスタンスプロパティとして closeCalendar メソッドを定義
  initialize() {
    this.boundCloseCalendar = this.closeCalendar.bind(this);
  }

  openCalendar() {
    this.overlayTarget.classList.remove('hidden');

    fetch("/calendars")
      .then(response => response.text())
      .then(html => {
        this.calendarContentTarget.innerHTML = html;
        document.addEventListener("click", this.boundCloseCalendar);
      })
      .catch(error => {
        console.error("Error loading calendar:", error);
      });
  }

  closeCalendar(event) {
    if (!this.calendarContentTarget.contains(event.target)) {
      this.overlayTarget.classList.add('hidden');
      document.removeEventListener("click", this.boundCloseCalendar);
    }
  }
}
