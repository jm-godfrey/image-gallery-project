document.addEventListener("DOMContentLoaded", () => {
  const images = Array.from(document.querySelectorAll(".gallery-image")).map(img => img.dataset.fullImageUrl);
  let currentIndex = 0;
  let slideshowInterval;

  const slideshowModal = document.getElementById("slideshowModal");
  const slideshowImage = document.getElementById("slideshowImage");

  if (!slideshowModal || !slideshowImage) return;

  const showImage = index => {
    if (images.length === 0) return;
    slideshowImage.src = images[index];
  };

  const startSlideshow = () => {
    currentIndex = 0;
    showImage(currentIndex);
    slideshowInterval = setInterval(() => {
      currentIndex++;
      if (currentIndex >= images.length) {
        clearInterval(slideshowInterval);
        const closeBtn = slideshowModal.querySelector('[data-bs-dismiss="modal"]');
        if (closeBtn) closeBtn.click();
        return;
      }
      showImage(currentIndex);
    }, 3000);
  };

  slideshowModal.addEventListener("show.bs.modal", startSlideshow);
  slideshowModal.addEventListener("hide.bs.modal", () => clearInterval(slideshowInterval));
});
