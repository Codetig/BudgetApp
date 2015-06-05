$(document).ready(function(){
  $('body').on('click', '.t-goal-edit', function(e){
    e.preventDefault();
    $('.goal-edit').toggle();
  });
});