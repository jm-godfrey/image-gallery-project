document.addEventListener("DOMContentLoaded", () => {
  const fileInput = document.getElementById("photo-upload");
  const submitBtn = document.getElementById("submit-photo-btn");

  if (fileInput && submitBtn) {
    fileInput.addEventListener("change", () => {
      submitBtn.disabled = fileInput.files.length === 0;
    });
  }
});
