//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require custom

//= require_tree .


$(document).ready(function(){


	/****	 NAVBAR SHOW AFTER scroll  ****/

	$(document).scroll(function(){
		var y = $(this).scrollTop();
		if (y > 640) {
			$('#menu').fadeIn();
		} else {
			$('#menu').fadeOut();
		}
	});


});