import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fieldsContainer"]

  append(event) {
    event.preventDefault();

    const template = this.cloneDetailFormTemplate()
    const newIndex = new Date().getTime().toString();
    this.replaceNewFormIndex(template, newIndex)
  }

  // フォームテンプレートを複製
  cloneDetailFormTemplate() {
    return document.getElementById('practice-record-details-template').content.cloneNode(true);
  }

  // フォームテンプレートをDOMに追加
  replaceNewFormIndex(template, newIndex) {
    template.querySelectorAll("input, textarea").forEach(input => {
      input.name = input.name.replace(/NEW_FORM/g, newIndex);
    });
    return this.fieldsContainerTarget.appendChild(template);
  }
}
