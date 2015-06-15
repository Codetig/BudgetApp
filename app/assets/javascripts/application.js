// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  $('.alert').fadeOut(5000);

  //Writeups on the home page
  var pInfo;
  $('body').on('click', '.s-info', function(e){
    var p = $(this).attr('href').charAt(2);
    pInfo && pInfo.toggleClass('hidden');
    pInfo = p === "b" ? $('#budget') : p === "w" ? $('#workings') : $('#about');
    pInfo.toggleClass('hidden');
  });


  //Help link for information on elements
  
  var setDBox = function(el){
    $('.ui-dialog').remove();
    $('#dialog-box').remove();

    $('.after-nav').prepend('<div id="dialog-box", title="Info"><p></p></div>');
    
    if(el){
      $('#dialog-box p').text(el.attr("title"));
      $('#dialog-box').dialog();
      //activating tooltips again.
      //Need to see how users react to so many tooltips and fine tune???
      $(document).tooltip();
    } else {
      $('#dialog-box').remove();
    } 
    return;
  };

  $('.help').tooltip();
  

  $('.help').click(function(e){
    e.preventDefault();
    if($(this).text() === "Help"){
      $(this).text('Tooltips Off');
      $('.itips').toggle();
      $(document).tooltip();
    } else {
      // location.reload();
      $(this).text('Help');
      $(document).tooltip('destroy');
      $('.itips').toggle();
      setDBox();
      $('.help').tooltip();
    }
  });

    //dialog information boxes
  $('body').on('click', '.itips', function(e){
    e.preventDefault();
    //tooltips does not work with dialog widget because I'm using the title attribute for both.
    $(document).tooltip('destroy'); 
    setDBox($(e.target).parent().parent());
  });



  $('#accordion').accordion({collapsible: true});

  // $('.itips').dialog();

});