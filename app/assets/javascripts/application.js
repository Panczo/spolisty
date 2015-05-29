//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require jquery.turbolinks
//= require filterable
//= require bootstrap-select
//= require jquery.raty
//= require_tree .



var ready;
ready = function() {

  /****  NAVBAR SHOW AFTER scroll  ****/
  var pathname = window.location.pathname;
  if (pathname === "/") {
    $('#menu').hide();
    $(document).scroll(function(){
      var y = $(this).scrollTop();
      if (y > 640) {
        $('#menu').fadeIn();
      } else {
        $('#menu').fadeOut();
      }
    });
  }


  /**** smooth section moves ****/
  var $root = $('html, body');
  $('a').click(function() {
      $root.animate({
          scrollTop: $( $.attr(this, 'href') ).offset().top - 350
      }, 800);
      return false;
  });

  $('.navbar-nav [data-toggle="tooltip"]').tooltip();
  $('.navbar-twitch-toggle').on('click', function(event) {
      event.preventDefault();
      $('.navbar-twitch').toggleClass('open');
  });
  

/*  $('ul.nav.nav-pills li a').click(function() {           
    $(this).parent().addClass('active').siblings().removeClass('active');           
  });*/

  /*  tooltip   */
  $('[data-toggle="tooltip"]').tooltip();

  /*  User navbar menu in provile page  */

/*  $('.usernav a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  });*/
  
  /*  Playlist Tracks   */

  $('.ulliststyle').hide();
  $('.usrplay').on("click", 'p.playlist_option', function() {
    $(this).parent('.usrplay').find('.ulliststyle').fadeToggle("slow");
    $(this).find('i').toggleClass("fa-chevron-down fa-chevron-up");
  });

  $( ".trackline" ).click(function() {
    var src = $('iframe').attr('src');
    var newsrc = $(this).attr('data-tracknumber');
    $('iframe').attr("src", newsrc);
    $('iframe').click();
  });

  /* Filer track by genre on user show page */
  $("#portfolio-list").filterable();

  $('.selectpicker').selectpicker({
    style: 'btn btn-block',
    size: '20'
  });

  $('.review_rating').raty({
    path: '/assets/',
    number: 10,
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    }
  });

  $('#star-rating').raty({
    number: 10,
    path: '/assets/',
    scoreName: 'review[rating]'
  });



};

$(document).ready(ready);
$(document).on('page:change', ready);


