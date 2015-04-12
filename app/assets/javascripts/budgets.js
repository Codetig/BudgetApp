$(document).ready(function(){
  var cdata; // for Flot chart data
  
  var chartUrl = $('#mon-bar').attr('data-url');
  // console.log(cdata);
  //flot
  if(chartUrl){
    $.getJSON(chartUrl, function(data){
      cdata = data;
      console.log(cdata);
      var plotData = [
      {label: "Actual Income", data: cdata.incomea, color: "green"},
      {label: "Actual Expense", data: cdata.expensea, color: "red"}
      ];
      $(".btn-block").first().attr('class', "btn btn-success btn-block");
      drawBar(plotData, $("#mon-bar"), "Actual Income and Expenses by Month");
    });
  }

  $('.btn-block').on('click', function(e){
    var btext = $(this).text(),
    btitle = "", plotData = [];

    if (btext === $('.btn-success').text()){
      return;
    }

    $('.btn-success').attr('class','btn btn-default btn-block');
    $(this).attr('class', "btn btn-success btn-block");

    if(btext === 'Actual Income Vs Actual Expense'){
      btitle = 'Actual Income Vs Actual Expense';
      plotData = [
      {label: "Actual Income", data: cdata.incomea, color: "green"},
      {label: "Actual Expense", data: cdata.expensea, color: "red"}
      ];
      
    } else if(btext === 'Projected Income Vs Projected Expense'){
      btitle = 'Projected Income Vs Projected Expense';
      plotData = [
      {label: "Projected Income", data: cdata.incomep, color: "green"},
      {label: "Projected Expense", data: cdata.expensep, color: "red"}
      ];
      
    } else if(btext === 'Projected Income Vs Actual Income'){
      btitle = 'Projected Income Vs Actual Income';
      plotData = [
      {label: "Projected Income", data: cdata.incomep, color: "blue"},
      {label: "Actual Income", data: cdata.incomea, color: "yellow"}
      ];
      
    } else if(btext === 'Projected Expense Vs Actual Expense'){
      btitle = 'Projected Expense Vs Actual Expense';
      plotData = [
      {label: "Projected Expense", data: cdata.expensep, color: "yellow"},
      {label: "Actual Expense", data: cdata.expensea, color: "red"}
      ];
      
    }

    drawBar(plotData, $("#mon-bar"), btitle);
  }); //button click listener ends

  function drawBar(data, place, title) {
    $('.chart-title').text(title);
    $("#mon-bar").empty();
    var month_array = [[1.5, "Jan"], [2.5, "Feb"], [3.5, "Mar"], [4.5, "Apr"], [5.5,"May"], [6.5, "Jun"], [7.5, "Jul"], [8.5, "Aug"], [9.5, "Sep"], [10.5, "Oct"], [11.5, "Nov"], [12.5, "Dec"]];
    $.plot(place, data, {
          series: {
            bars: {show: true}
          },
          xaxis: {ticks: month_array}
        });
  }


 //formerly part of the if statement.
        // $.plot($("#monSeriesE"), [data.expense], {
      //   xaxis: {ticks: month_array},
      //   series: {
      //     color: 'red',
      //     label: 'Actual Expenses by Month',
      //     bars: {show: true}
      //   }
      // }); // can make a function that compares actuals, prejecteds and projected vs actual income and expense

      // $.plot($("#mon-bar"), [{label: "Actual Income", data: data.income, color: "green"}, {label: "Actual Expense", data: data.expense, color: "red"}], {
      //     series: {
      //       bars: {show: true},
      //       label: "Actual Income by Month"
      //     },
      //     xaxis: {ticks: month_array}
      //   });

  // function get_month_name(month_timestamp) {
  //   var month_date = new Date(month_timestamp);
  //   var month_numeric = month_date.getMonth();
  //   var month_array = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  //   var month_string = month_array[month_numeric];

  //   return month_string;
  //   }
  
});