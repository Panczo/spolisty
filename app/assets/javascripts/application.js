//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
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

	/****	smooth section moves ****/
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
  

  $('ul.nav.nav-pills li a').click(function() {           
    $(this).parent().addClass('active').siblings().removeClass('active');           
	});

  /*  tooltip   */
	$('[data-toggle="tooltip"]').tooltip();

  /*  User navbar menu in provile page  */

  $('#usernav a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  });
/*
  $('#usernav a').click(function (e) {
    $(this).parents
    e.preventDefault()
    $(this).parent().addClass("active")
    $(this).tab('show')
  })*/

  $("#userplaylists").on("click", "p", function() {
    
    alert("hello");
  });



});



