import { Controller } from "@hotwired/stimulus";

// Used by comments/edit.html.erb
// Resizes the height of the edit and new textareas to fit content
export default class extends Controller {
  static targets = ["txtarea", "commentForm"];

  // Called when comment edit form is generated
  connect() {
    this.resizeTextArea();
  }

  // Called when input changes in an edit or new textarea
  resizeTextArea() {
    // this.element is div.comment
    this.txtareaTarget.style.height = "auto";
    this.txtareaTarget.style.height = this.txtareaTarget.scrollHeight + "px";
  }

  // called when text area is focused
  removeFlashMessages() {
    const textSuccessEl = this.commentFormTarget.querySelector(".text-success");
    const textDangerEl = this.commentFormTarget.querySelector(".text-danger");
    // TODO: Instead of remove() add a css animate class to fade out
    if (textSuccessEl) {
      textSuccessEl.remove();
    }
    if (textDangerEl) {
      textDangerEl.remove();
    }
  }
}
