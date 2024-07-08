import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["publishRecord"]

  handleClick(event) {
    let result = confirm("公開します。よろしいですか？");
    if (!result) {
      event.preventDefault();
    }
  }
}
