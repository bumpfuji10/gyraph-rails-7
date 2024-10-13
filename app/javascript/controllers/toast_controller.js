import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toast"]

  connect() {
    this.showToast();
  }

  showToast() {
    this.toastTarget.classList.remove("hidden");
    this.toastTarget.classList.add("fade-in");

    setTimeout(() => {
      this.hideToast();
    }, 300000);
  }

  hideToast() {
    this.toastTarget.classList.remove("fade-in");
    this.toastTarget.classList.add("fade-out");

    this.toastTarget.addEventListener('animationend', () => {
      this.toastTarget.classList.add("hidden");
    }, { once: true });
  }
}
