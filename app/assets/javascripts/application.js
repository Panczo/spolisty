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

	var $root = $('html, body');
	$('a').click(function() {
	    $root.animate({
	        scrollTop: $( $.attr(this, 'href') ).offset().top - 75
	    }, 800);
	    return false;
	});


});