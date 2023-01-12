import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["txtarea"];
  connect() {
    // Called when comment edit form is generated
    this.resizeTextArea();
  }

  resizeTextArea() {
    // this.element is div.comment
    // Called when text changes in textarea
    this.txtareaTarget.style.height = "auto";
    this.txtareaTarget.style.height = this.txtareaTarget.scrollHeight + "px";
  }
}
