//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require jquery.turbolinks
//= require_tree .

$(document).ready(function(){


    Highcharts.setOptions({
      colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
    });


  $('#genrechart').highcharts({
      chart: {
          type: 'column'
      },
      color: {
          linearGradient: { x1: 0, x2: 0, y1: 0, y2: 1 },
          stops: [
              [0, '#003399'],
              [1, '#3366AA']
          ]
      },
      title: {
          text: 'Basic drilldown'
      },
      xAxis: {
          type: 'category'
      },

      legend: {
          enabled: false
      },

      plotOptions: {
          series: {
              borderWidth: 0,
              dataLabels: {
                  enabled: true
              }
          }
      },

      series: [{
          name: 'Things',
          colorByPoint: true,
          data: <%= Genre.all.map {|ge| @user.tracks.where(genre: ge).count } %>
      }],
      drilldown: {
          series: [{
              id: 'animals',
              data: [
                  ['Cats', 4],
                  ['Dogs', 2],
                  ['Cows', 1],
                  ['Sheep', 2],
                  ['Pigs', 1]
              ]
          }, {
              id: 'fruits',
              data: [
                  ['Apples', 4],
                  ['Oranges', 2]
              ]
          }, {
              id: 'cars',
              data: [
                  ['Toyota', 4],
                  ['Opel', 2],
                  ['Volkswagen', 2]
              ]
          }]
      }
  });

  /****  NAVBAR SHOW AFTER scroll  ****/
  $('#menu').hide();
  $(document).scroll(function(){
    var y = $(this).scrollTop();
    if (y > 640) {
      $('#menu').fadeIn();
    } else {
      $('#menu').fadeOut();
    }
  });

  /**** smooth section moves ****/
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
    e.preventDefault();
    $(this).tab('show');
  });
  
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
});



