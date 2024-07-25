import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {

  static targets = ["side"];

  toggle() {
    this.sideTarget.classList.toggle("hidden");
  }
}
