$(document).ready(function() 
{
  // whole category filter height
  //

  var h    = parseInt($('.fields_container').height());
  var trpx = parseInt($('.time-range').css('left'));
  var trpy = parseInt($('.time-range').css('top'));
  $('<input type="hidden" name="filter_layout[height]"      value="'  +h+ '" />').appendTo($('#filter_layout_form'));
  $('<input type="hidden" name="filter_layout[time_range_x]" value="'+trpx+'" />').appendTo($('#filter_layout_form'));
  $('<input type="hidden" name="filter_layout[time_range_y]" value="'+trpy+'" />').appendTo($('#filter_layout_form'));

  $('#search_form .fields_container').resizable({
    maxWidth: 680, 
    minWidth: 680,
    stop: function(event, ui) {
      $('input[name="filter_layout[height]"]').val(parseInt($(this).height()));
    }
  });

  $('.time-range').draggable({
    containment: "parent",
    grid: [2,2],
    stop: function(event, ui) {
      $('input[name="filter_layout[time_range_x]"]').val(parseInt($(this).css('left')));
      $('input[name="filter_layout[time_range_y]"]').val(parseInt($(this).css('top')));
    }
  });

  // given characteristics for that filter
  //

  $('.characteristic').each(function(){
    var w = parseInt($(this).width());
    var h = parseInt($(this).height());
    var x = parseInt($(this).css('left'));
    var y = parseInt($(this).css('top'));
    var p = parseInt($(this).children('.value').css('left'));
    var id= $(this).attr('id');

    $('<input type="hidden" name="characteristics['+id+'][filter_layout][x]"       for="'+id+'_x" value="'+x+'" />').appendTo($('#filter_layout_form'));
    $('<input type="hidden" name="characteristics['+id+'][filter_layout][y]"       for="'+id+'_y" value="'+y+'" />').appendTo($('#filter_layout_form'));
    $('<input type="hidden" name="characteristics['+id+'][filter_layout][width]"   for="'+id+'_w" value="'+w+'" />').appendTo($('#filter_layout_form'));
    $('<input type="hidden" name="characteristics['+id+'][filter_layout][height]"  for="'+id+'_h" value="'+h+'" />').appendTo($('#filter_layout_form'));
    $('<input type="hidden" name="characteristics['+id+'][filter_layout][padding]" for="'+id+'_p" value="'+p+'" />').appendTo($('#filter_layout_form'));
  });

  $('#search_form .value').draggable({ 
    axis: "x", 
    containment: "parent",
    stop: function(event, ui) {
      $('input[for="'+$(this).parent().attr('id')+'_p"]').val(parseInt($(this).css('left')));
    }
  });

  $('.characteristic').draggable({
    grid: [2,2], 
    containment: 'parent',
    stop: function(event, ui) {
      $('input[for="'+$(this).attr('id')+'_x"]').val(parseInt($(this).css('left')));
      $('input[for="'+$(this).attr('id')+'_y"]').val(parseInt($(this).css('top')));
    }
  }).resizable({
    maxWidth: 680, 
    maxHeight: 20,
    minHeight: 20,
    stop: function(event, ui) {
      $('input[for="'+$(this).attr('id')+'_w"]').val(parseInt($(this).width()));
      $('input[for="'+$(this).attr('id')+'_h"]').val(parseInt($(this).height()));
    }
  });
});

