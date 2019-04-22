(function ($) {
 "use strict";
    
    //---------------------------------------------
    //Nivo slider
    //---------------------------------------------
    // $('#ensign-nivoslider').nivoSlider({
    //     effect: 'random',
    //     slices: 15,
    //     boxCols: 8,
    //     boxRows: 4,
    //     animSpeed: 500,
    //     pauseTime: 5000,
    //     startSlide: 0,
    //     directionNav: true,
    //     controlNavThumbs: true,
    //     pauseOnHover: false,
    //     manualAdvance: true
    // });

    // ----------------------
    // Home Slider
    // ----------------------
    var $heroSlider = $('.hero-slider').owlCarousel({
        animateIn: 'lightSpeedIn',
        animateOut: 'lightSpeedOut',
        autoplay: true,
        autoplayTimeout: 5000,
        dots: false,
        loop: true,
        mouseDrag: false,
        nav: false,
        responsive: {
            0: {
                items: 1
            }
        }
    });

    $('.hero-slider-nav').on('click', function (e) {
        e.preventDefault();

        if ($(this).hasClass('prev')) {
            $heroSlider.trigger('prev.owl.carousel');
        } else {
            $heroSlider.trigger('next.owl.carousel');
        }
    });

})(jQuery); 