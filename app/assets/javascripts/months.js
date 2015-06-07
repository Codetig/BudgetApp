$(document).ready(function(){
  var fdata; //for form data to be sent to server for update
  
  //category addition section behavior
    // show
  $(".cat-add-link, .goal-add-link").on('click', function(e){

    if ($(this).attr('class') === "cat-add-link") {
    // console.log("in the listener");
    $(".addcat").show();
    $('.periods').hide();
    // console.log($(this).parents('h3').text());
    //For some reason the visual does not keep up with this change.
    var expBool = $(this).parents('h3').text() === "Income "? false : true;
    $('#category_expense').attr('checked', expBool);
    // console.log($('#category_expense').attr('checked'));
    } else {
      // console.log($(this).attr('class'));
      e.preventDefault();
      $(".addgoal").show();
    }
  });

   $('.show-cat-edit').on('click', function(e){
    // console.log("in show cat edit listener");
    e.preventDefault();
    $('.disp').find('li').children().removeClass('bg-success');
    $(this).parents('.disp').children('.cat-edit-form').toggleClass('hidden');
  });

  $('#show-periods').on('click', function(e){
    // console.log("show periods");
    e.preventDefault();
    $('.periods').toggle();
  });

    //hide
  $('.close-add').on('click', function(e){
    e.preventDefault();
    $(".addcat").hide();
    $(".addgoal").hide();
  });
  

  //Page behavior
    //showing and hiding description

  $('body').on('click', '.dummy', function(e){
    e.preventDefault();
    $(this).removeClass('btn-primary');
    $(this).addClass('btn-success');

  });

  $('.show-desc').on('click', function(e){
    e.preventDefault();
    $(this).parent().find('.desc').toggleClass('hidden');
  });


  $('.disp input').on('change', function(e){
    var pForm = $(this).parents('form'); //for refencing the form the change occurred
    var hl = [
    pForm.parents('.disp').find('li > .show-cat-edit').text(),
    pForm.parents('.disp').find('li > .pval').text(),
    pForm.parents('.disp').find('li > .amt').text(),
    ''
    ];
    fdata = pForm.serializeArray();
    console.log($(this).attr('id'));
    var url = pForm.attr('action');
    $('.dummy').removeClass('btn-success');
    $('.dummy').addClass('btn-primary');
    pForm.parents('.disp').find('li').children().removeClass('bg-success');

    $.ajax({
      url: url,
      type: "PUT",
      dataType: "json",
      data: fdata,
      success: function(d){ 
        // pForm.parents('.disp').find('li > img').remove(); //causes multiple confirm bug
        var actSum = (parseFloat(d.period1) + parseFloat(d.period2) + parseFloat(d.period3) + parseFloat(d.period4));
        var emoji = function(category){
          if(d.expense){
            return category.proj_val > actSum ? '/assets/happy.png' : category.proj_val < actSum ? '/assets/sad.png' : '/assets/neut.png';
          } else {
            return category.proj_val > actSum ? '/assets/sad.png' : category.proj_val < actSum ? '/assets/happy.png' : '/assets/neut.png';
          }
        };
        pForm.parents('.disp').find('li > .show-cat-edit').text(d.name);
        pForm.parents('.disp').find('li > .pval').text(d.proj_val);
        pForm.parents('.disp').find('li > .amt').text("" + actSum);
        hl[3] = (d.name.toLowerCase() != hl[0].toLowerCase())? pForm.parents('.disp').find('li > .show-cat-edit') : (d.proj_val != hl[1])? pForm.parents('.disp').find('li > .pval') : pForm.parents('.disp').find('li > .amt');
        hl[3].addClass('bg-success');
        pForm.parents('.disp').find('li > img').attr('src', emoji(d));
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
    pcolors = ['blue', 'green', 'red', 'purple', 'brown', 'green', 'black', 'yellow'];

    $.getJSON(pUrl, function(data){
      if(data){
        // console.log(data);
      data.expense.forEach(function(exp, i){
        pDataE.push({label: exp[0], data: exp[1], color: pcolors[i]});
        // console.log(pcolors[i]);
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