var backwards, interval;
var timeDelay = 8000;

$(function() {
  interval = setInterval(runAnimation, timeDelay);
});

function runAnimation() {
  $('.home-client-stories').fadeOut(500, function() {
    $('.home-client-stories').slick('slickNext');
  });

  if(parseInt($('.home-sprites').css('left')) == -1560) {
    backwards = true;
  } else if(parseInt($('.home-sprites').css('left')) === 0) {
    backwards = false;
  }

  if(backwards === true) {
    $('.home-background').animate({ 'left': "+=58px" }, 500);
    $('.home-sprites').animate({ 'left': "+=390px" }, 500, function() {
      $('.home-client-stories').fadeIn(500);
    });
  } else {
    $('.home-background').animate({ 'left': "-=58px" }, 500);
    $('.home-sprites').animate({ 'left': "-=390px" }, 500, function() {
      $('.home-client-stories').fadeIn(500);
    });
  }

  clearInterval(interval);
  interval = setInterval(runAnimation, timeDelay);
}

$.winFocus({
  blur: function(event) {
    clearInterval(interval);
  },
  focus: function(event) {
    interval = setInterval(runAnimation, timeDelay);
  }
});
