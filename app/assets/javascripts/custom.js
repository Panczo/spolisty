$(document).ready(function(){

	$('#success-sub').hide();
	

	/*** SHOW NAVBAR ***/
  $('#show_user_tracks').click(function(e){
    e.preventDefault();
    $('.filter-tracks').fadeToggle();
  });

});