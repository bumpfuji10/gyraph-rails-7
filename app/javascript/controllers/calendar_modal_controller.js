import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "overlay"]

  openCalendar() {
    this.overlayTarget.classList.remove('hidden');
  }

  closeCalendar() {
    this.overlayTarget.classList.add('hidden');
  }
}
