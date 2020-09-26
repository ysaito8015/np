function docReady(fn) {
  // see if DOM is already available
  if (document.readyState === "complete" || document.readyState === "interactive") {
    // call on next available tick
    setTimeout(fn, 1);
  } else {
    document.addEventListener("DOMContentLoaded", fn);
  }
}
function openModal() {
  document.getElementById("backdrop").style.display = "block"
  document.getElementById("exampleModal").style.display = "block"
  document.getElementById("exampleModal").className += "show"
}
function closeModal() {
  document.getElementById("backdrop").style.display = "none"
  document.getElementById("exampleModal").style.display = "none"
  document.getElementById("exampleModal").className += document.getElementById("exampleModal").className.replace("show", "")
}
// Get the modal
var modal = document.getElementById('exampleModal');

docReady(function() {
    // DOM is loaded and ready for manipulation here
    openModal()
});


// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    closeModal()
  }
}
