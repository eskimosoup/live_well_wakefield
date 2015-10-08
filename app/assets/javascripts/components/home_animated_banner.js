var backwards, interval;
$(function() {
  interval = setInterval(runAnimation, 4000);
});


function runAnimation() {
  if(parseInt($('.home-sprites').css('background-position-x')) == -1560) {
    backwards = true;
  } else if(parseInt($('.home-sprites').css('background-position-x')) === 0) {
    backwards = false;
  }

  if(backwards === true) {
    $('.home-background').animate({ 'background-position-x': "+=78" }, 500);
    $('.home-sprites').animate({ 'background-position-x': "+=390" }, 500);
  } else {
    $('.home-background').animate({ 'background-position-x': "-=78" }, 500);
    $('.home-sprites').animate({ 'background-position-x': "-=390" }, 500);
  }

  clearInterval(interval);
  interval = setInterval(runAnimation, 2000);

  $('.home-client-stories').slick('slickNext');
}

$(window).blur(function(){
  clearInterval(interval);
});

$(window).focus(function(){
  interval = setInterval(runAnimation, 2000);
});
