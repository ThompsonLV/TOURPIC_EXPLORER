import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {

  connect() {
    var tabs = document.querySelector('.tabs-buttons .swiper-wrapper');

    var tabButtons = new Swiper('.tabs-buttons', {
      slidesPerView: 'auto',
      freeMode: true,
      // scrollbar: '.swiper-scrollbar',
    });

    var tabContent = new Swiper('.tabs-content', {
      on: {
        slideChange: function () {
          tabs.children[tabContent.previousIndex].classList.remove('active');
          tabs.children[tabContent.activeIndex].classList.add('active');
        },
      },
    });
  }
}
