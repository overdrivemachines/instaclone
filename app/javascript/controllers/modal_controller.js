import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  // static targets = [""];

  // executed when an element has data-controller="modal"
  // div.modal is in users/follow.html.erb
  connect() {
    const followModal = new bootstrap.Modal(this.element, {});
    // show the modal
    followModal.show();
  }
}
