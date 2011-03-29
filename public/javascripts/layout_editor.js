/* DO NOT MODIFY. This file was compiled Tue, 29 Mar 2011 17:25:15 GMT from
 * /home/szinin/git/inform/app/coffeescripts/layout_editor.coffee
 */

(function() {
  (function($) {
    $.fn.initEditor = function(options) {
      if (options == null) {
        options = {};
      }
      options.layout || (options.layout = 'form_layout');
      $(this).initLayout(options);
      $(this).find('.container').each(function() {
        return $(this).initContainer({
          collection: 'characteristic_containers',
          layout: options.layout
        });
      });
      return $(this).find('.characteristic').each(function() {
        return $(this).initItem({
          layout: options.layout
        });
      });
    };
    $.fn.initLayout = function(options) {
      if (options == null) {
        options = {};
      }
      options.resizable || (options.resizable = true);
      options.grid || (options.grid = [2, 2]);
      return $(this).initCanvasItem(options);
    };
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
    $.fn.initItem = function(options) {
      if (options == null) {
        options = {};
      }
      options.resizable || (options.resizable = true);
      options.draggable || (options.draggable = true);
      options.paddable || (options.paddable = true);
      options.collection || (options.collection = 'characteristics');
      return $(this).initCanvasItem(options);
    };
    return $.fn.initCanvasItem = function(options) {
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
