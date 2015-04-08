$(document).ready(function(){
  console.log("we are active");
  var fdata; //for form data to be sent to server for update
  
  //category addition section behavior
    // show
  $(".cat-add-link").on('click', function(e){
    // console.log("in the listener");
    e.preventDefault();
    $(".addcat").show();
    $('.periods').toggle();
  });

   $('.show-cat-edit').on('click', function(e){
    // console.log("in show cat edit listener");
    e.preventDefault();
    $(this).parents('.disp').children('.cat-edit-form').toggleClass('.hidden');
  });

  $('#show-periods').on('click', function(e){
    // console.log("show periods");
    e.preventDefault();
    $('.catform > .periods').toggle();
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
        pForm.parents('.disp').find('li > .show-cat-edit').text(d.name);
        pForm.parents('.disp').find('li > .pval').text(d.proj_val);
        pForm.parents('.disp').find('li > .amt').text("" + (parseFloat(d.period1) + parseFloat(d.period2) + parseFloat(d.period3) + parseFloat(d.period4)));
        drawPie();
      },
      error: function(d){alert("value change not allowed, please review your form");}
    }); //end of ajax call
  });

//Pie charts with Flot
  function drawPie(){
    // body...

    var pDataI = [],
    pDataE=[],
    pUrl = $('#i-pie').attr('data-url'),
    pcolors = ['blue', 'green', 'red', 'purple', 'white', 'orange', 'black', 'yellow'];

    $.getJSON(pUrl, function(data){
      if(data){
        // console.log(data);
      data.expense.forEach(function(exp, i){
        pDataE.push({label: exp[0], data: exp[1], color: pcolors[i]});
      });

      data.income.forEach(function(inc, i){
        pDataI.push({label: inc[0], data: inc[1], color: pcolors[i]});
      });

      $.plot($('#i-pie'), pDataI, {
        series: {
          pie: {
            show: true
          }
        },
        legend: {
          show: false
        }
      });

      $.plot($('#e-pie'), pDataE, {
        series: {
          pie: {
            show: true
          }
        },
        legend: {
          show: false
        }
      });
      }
    });
  }
  drawPie();



});//end of doc ready