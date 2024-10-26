import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["welcomeMessage"]

  connect() {
      this.welcomeMessageTarget.classList.remove("hidden")

      const messages = this.welcomeMessageTarget.querySelectorAll(".welcome-content-message")
      messages.forEach((message, index) => {
        message.classList.add("show-toast-animation")
        message.style.animationDelay = `${index * 0.8}s`
      })
  }
}
