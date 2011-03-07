$(document).ready(function() 
{
  // whole category form height
  //
  var h = parseInt($('.fields_container').height());
  $('<input type="hidden" name="form_layout[height]"      value="'  +h+ '" />').appendTo($('#form_layout_form'));

  $('#form .fields_container').resizable({
    maxWidth: 680, 
    minWidth: 680,
    stop: function(event, ui) {
      $('input[name="form_layout[height]"]').val(parseInt($(this).height()));
    }
  });

  // given characteristics for that form
  //

  $('.characteristic').each(function(){
    var w = parseInt($(this).width());
    var h = parseInt($(this).height());
    var x = parseInt($(this).css('left'));
    var y = parseInt($(this).css('top'));
    var p = parseInt($(this).children('.value').css('left'));
    var id= $(this).attr('id');

    $('<input type="hidden" name="characteristics['+id+'][form_layout][x]"       for="'+id+'_x" value="'+x+'" />').appendTo($('#form_layout_form'));
    $('<input type="hidden" name="characteristics['+id+'][form_layout][y]"       for="'+id+'_y" value="'+y+'" />').appendTo($('#form_layout_form'));
    $('<input type="hidden" name="characteristics['+id+'][form_layout][width]"   for="'+id+'_w" value="'+w+'" />').appendTo($('#form_layout_form'));
    $('<input type="hidden" name="characteristics['+id+'][form_layout][height]"  for="'+id+'_h" value="'+h+'" />').appendTo($('#form_layout_form'));
    $('<input type="hidden" name="characteristics['+id+'][form_layout][padding]" for="'+id+'_p" value="'+p+'" />').appendTo($('#form_layout_form'));
  });

  $('#form .value').draggable({ 
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

