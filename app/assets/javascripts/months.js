$(document).ready(function(){

  var fdata; //for form data to be sent to server for update
  //category addition section behavior
    // show
  $(".cat-add-link").on('click', function(e){
    // console.log("in the listener");
    e.preventDefault();
    $(".addcat").show();
    $('.periods').hide();
  });
  $('#show-periods').on('click', function(e){
    e.preventDefault();
    $('.periods').toggle();
  });

    //hide
  $('.close-add').on('click', function(e){
    e.preventDefault();
    $(".addcat").hide();
  });
  

  //Page behavior
    //showing and hiding description
  $('.show-desc').on('click', function(e){
    e.preventDefault();
    $(this).parent().find('.desc').toggleClass('hidden');
  });

  $('.show-cat-edit').on('click', function(e){
    e.preventDefault();
    $(this).closest('div').find('.cat-edit-form').toggleClass('hidden');
  });

  $('.disp input').on('change', function(e){
    var pForm = $(this).parents('form'); //for refencing the form the change occurred
    fdata = pForm.serializeArray();
    var url = pForm.attr('action');
    $.ajax({
      url: url,
      type: "PUT",
      dataType: "json",
      data: fdata,
      success: function(d){ 
        pForm.parents('.disp').find('li > .pval').text(d.proj_val);
        pForm.parents('.disp').find('li > .amt').text("" + (parseFloat(d.period1) + parseFloat(d.period2) + parseFloat(d.period3) + parseFloat(d.period4)));
      },
      error: function(d){alert("value change not allowed, please review your form");}
    }); //end of ajax call
  });


});//end of doc ready