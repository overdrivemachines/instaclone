import { Controller } from "@hotwired/stimulus";

// Used by comments/edit.html.erb
// Resizes the height of the edit and new textareas to fit content
export default class extends Controller {
  static targets = ["txtarea"];

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
}
