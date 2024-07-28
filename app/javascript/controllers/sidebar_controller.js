import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["side"];

  toggle() {
    const menuIcon = document.getElementById("menu-icon");
    const sidebar = this.sideTarget;
    const overlay = document.getElementById("overlay");

    sidebar.classList.toggle('open');
    menuIcon.classList.toggle('open');
    overlay.style.display = sidebar.classList.contains('open') ? 'block' : 'none';

    console.log(sidebar.classList.contains('open'))
    if (sidebar.classList.contains('open')) {
      menuIcon.innerHTML = '✕';
    } else {
      menuIcon.innerHTML = '☰';
    }
  }
}
