$(document).on("click", ".toggle-class", function(e) {  
  var toggleContainer = $(this).attr('data-container');
  var toggleClass     = $(this).attr('data-class');
  var dataReturn      = $(this).attr('data-return');

  $(toggleContainer).toggleClass(toggleClass);

  if (dataReturn === 'false') {
    e.preventDefault();
  }
});
