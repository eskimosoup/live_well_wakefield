$(function() {
  setInterval(runAnimation, 2000);
});

var backwards;

function runAnimation() {
  console.log(parseInt($('.home-sprites').css('background-position-x')));

  if(parseInt($('.home-sprites').css('background-position-x')) == -1560) {
    backwards = true;
  } else if(parseInt($('.home-sprites').css('background-position-x')) == 0) {
    backwards = false;
  }

  if(backwards === true) {
    $('.home-background').animate({ 'background-position-x': "+=78" }, 500);
    $('.home-sprites').animate({ 'background-position-x': "+=390" }, 500);
  } else {
    $('.home-background').animate({ 'background-position-x': "-=78" }, 500);
    $('.home-sprites').animate({ 'background-position-x': "-=390" }, 500);
  }
}
