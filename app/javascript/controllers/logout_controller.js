import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  logout(event) {
    event.preventDefault()
    const result = confirm("ログアウトします。よろしいですか？")
    if (result) {
      // JSを使ってフォームを作成し送信
      const form = document.createElement("form")
      form.method = "POST"
      form.action = this.element.href

      const csrfToken = document.querySelector("meta[name=csrf-token]").content
      const methodInput = document.createElement("input")
      methodInput.type = "hidden"
      methodInput.name = "_method"
      methodInput.value = "delete"

      const csrfInput = document.createElement("input")
      csrfInput.type = "hidden"
      csrfInput.name = "authenticity_token"
      csrfInput.value = csrfToken

      form.appendChild(methodInput)
      form.appendChild(csrfInput)
      document.body.appendChild(form)

      form.submit()
    }
  }
}
