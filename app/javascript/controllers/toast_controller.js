import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toast"]

  connect() {
    this.toastTarget.classList.remove("hidden");
    this.toastTarget.classList.add("fade-in");

    this.timeout = setTimeout(() => {
      this.hideToast();
    }, 3000);
  }

  hideToast() {
    this.toastTarget.classList.remove("fade-in");
    this.toastTarget.classList.add("fade-out");
  }

  hideToastOnClick() {
    clearTimeout(this.timeout);
    this.hideToast();
  }
}
