$(document).ready(function(){
  var cdata; // for Flot chart data
  
  var chartUrl = $('#monSeriesI').attr('data-url');
  // console.log(chartUrl);
  //flot
  if(chartUrl){
    $.getJSON(chartUrl, function(data){
      var month_array = [[1.5, "Jan"], [2.5, "Feb"], [3.5, "Mar"], [4.5, "Apr"], [5.5,"May"], [6.5, "Jun"], [7.5, "Jul"], [8.5, "Aug"], [9.5, "Sep"], [10.5, "Oct"], [11.5, "Nov"], [12.5, "Dec"]];
      $.plot($("#monSeriesE"), [data.expense], {
        xaxis: {ticks: month_array},
        series: {
          color: 'red',
          label: 'Actual Expenses by Month',
          bars: {show: true}
        }
      });

      $.plot($("#monSeriesI"), [data.income], {
          series: {
            bars: {show: true},
            color: 'green',
            label: "Actual Income by Month"
          },
          xaxis: {ticks: month_array}
        });

    });
  }

  // function get_month_name(month_timestamp) {
  //   var month_date = new Date(month_timestamp);
  //   var month_numeric = month_date.getMonth();
  //   var month_array = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  //   var month_string = month_array[month_numeric];

  //   return month_string;
  //   }
  
});