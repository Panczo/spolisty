//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require custom

//= require_tree .


$(document).ready(function(){


	/****	 NAVBAR SHOW AFTER scroll  ****/
	$('#menu').hide();
	$(document).scroll(function(){
		var y = $(this).scrollTop();
		if (y > 640) {
			$('#menu').fadeIn();
		} else {
			$('#menu').fadeOut();
		}
	});

	/*	smooth section moves */
	var $root = $('html, body');
	$('a').click(function() {
	    $root.animate({
	        scrollTop: $( $.attr(this, 'href') ).offset().top - 75
	    }, 800);
	    return false;
	});

  $('.navbar-nav [data-toggle="tooltip"]').tooltip();
  $('.navbar-twitch-toggle').on('click', function(event) {
      event.preventDefault();
      $('.navbar-twitch').toggleClass('open');
  });
  



});



