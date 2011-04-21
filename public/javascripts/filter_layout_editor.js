(function() {
  (function($) {
    $.fn.initContainer = function(options) {
      if (options == null) {
        options = {};
      }
      options.resizable || (options.resizable = true);
      options.draggable || (options.draggable = true);
      options.grid || (options.grid = [2, 2]);
      options.collection || (options.collection = 'containers');
      return $(this).initCanvasItem(options);
    };
    $.fn.initCanvasItem = function(options) {
      var aim, form, h, name, p, w, x, y;
      if (options == null) {
        options = {};
      }
      options.w || (options.w = 600);
      options.h || (options.h = 100);
      options.maxw || (options.maxw = 680);
      options.maxh || (options.maxh = 9999);
      options.minw || (options.minw = 20);
      options.minh || (options.minh = 20);
      options.grid || (options.grid = [4, 4]);
      options.collection || (options.collection = false);
      options.containment || (options.containment = 'parent');
      options.draggable || (options.draggable = false);
      options.resizable || (options.resizable = false);
      options.paddable || (options.paddable = false);
      options.layout || (options.layout = $(this).attr('id'));
      if (options.collection) {
        name = options.collection + '[' + $(this).attr('id') + ']' + '[' + options.layout + ']';
      } else {
        name = options.layout;
      }
      form = $($(this).attr('rel'));
      if (options.resizable) {
        w = parseInt($(this).width());
        h = parseInt($(this).height());
        $('<input type  ="hidden" \
                      name  ="' + name + '[height]" \
                      value ="' + h + '" />').appendTo(form);
        $('<input type  ="hidden" \
                      name  ="' + name + '[width]" \
                      value ="' + w + '" />').appendTo(form);
        $(this).resizable({
          grid: options.grid,
          maxWidth: options.maxw,
          minWidth: options.minw,
          stop: function(event, ui) {
            $('input[name="' + name + '[width]"]').val(parseInt($(this).width()));
            return $('input[name="' + name + '[height]"]').val(parseInt($(this).height()));
          }
        });
      }
      if (options.draggable) {
        x = parseInt($(this).css('left'));
        y = parseInt($(this).css('top'));
        $('<input type  ="hidden" \
                      name  ="' + name + '[x]" \
                      value ="' + x + '" />').appendTo(form);
        $('<input type  ="hidden" \
                      name  ="' + name + '[y]" \
                      value ="' + y + '" />').appendTo(form);
        $(this).draggable({
          grid: options.grid,
          containment: options.containment,
          stop: function(event, ui) {
            $('input[name="' + name + '[x]"]').val(parseInt($(this).css('left')));
            return $('input[name="' + name + '[y]"]').val(parseInt($(this).css('top')));
          }
        });
      }
      if (options.paddable) {
        aim = $(this).find('.value');
        p = parseInt(aim.css('left'));
        $('<input type  ="hidden" \
                      name  ="' + name + '[padding]" \
                      value ="' + p + '" />').appendTo(form);
        return aim.draggable({
          axis: "x",
          containment: "parent",
          stop: function(event, ui) {
            return $('input[name="' + name + '[padding]"]').val(parseInt($(this).css('left')));
          }
        });
      }
    };
  })(jQuery);
}).call(this);

$(document).ready(function() 
{
  // whole category filter height
  //
  $('.fields_container').find('.container').each(function() {
    return $(this).initContainer({
      collection: 'characteristic_containers',
      layout:     'filter_layout'
    });
  });

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

