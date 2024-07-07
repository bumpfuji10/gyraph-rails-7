import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fieldsContainer"]

  appendForm(event) {
    event.preventDefault();

    const template = this.cloneDetailFormTemplate()
    const newIndex = new Date().getTime().toString();
    this.replaceNewFormIndex(template, newIndex)
  }

  cloneDetailFormTemplate() {
    return document.getElementById('practice-record-details-template').content.cloneNode(true);
  }

  replaceNewFormIndex(template, newIndex) {
    template.querySelectorAll("input, textarea").forEach(input => {
      input.name = input.name.replace(/NEW_FORM/g, newIndex);
    });
    return this.fieldsContainerTarget.appendChild(template);
  }

  removeAppendedForm(event) {
    event.preventDefault();
    const fieldSet = event.target.closest('.nested-fields');
    if (fieldSet) {
      fieldSet.remove();
    }
  }
}
