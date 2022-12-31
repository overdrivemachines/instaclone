// Helper function to select elements
// returns element with matching ID
// or
// returns array of elements with matching class
function $(el) {
  if (el.charAt(0) === "#") {
    // if el begins with # then find element with id
    return document.getElementById(el.substring(1));
  } else {
    return document.querySelectorAll(el);
  }
}
// make the function available
window.$ = $;

// This function runs on every page "load"
document.addEventListener("turbo:load", () => {
  //////////////////////////////////////////////////
  // Bootstrap Popover
  //////////////////////////////////////////////////
  const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
  const popoverList = [...popoverTriggerList].map((popoverTriggerEl) => new bootstrap.Popover(popoverTriggerEl));

  //////////////////////////////////////////////////
  // Return to Top Button
  //////////////////////////////////////////////////
  const returnToTopBtn = $("#return-to-top");

  // When the user scrolls down 520px from the top of the document, show the button
  window.onscroll = function () {
    scrollFunction();
  };

  function scrollFunction() {
    if (document.body.scrollTop > 520 || document.documentElement.scrollTop > 520) {
      returnToTopBtn.style.display = "block";
    } else {
      returnToTopBtn.style.display = "none";
    }
  }

  // When the user clicks on the button, scroll to the top of the document
  function returnToTop() {
    document.body.scrollTop = 0; // For Safari
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
  }

  window.returnToTop = returnToTop;
});
