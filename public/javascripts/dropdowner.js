/* DO NOT MODIFY. This file was compiled Tue, 08 Mar 2011 06:49:34 GMT from
 * /home/szinin/git/inform/app/coffeescripts/dropdowner.coffee
 */

(function() {
  (function($) {
    return $.fn.dropdowner = function(options) {
      var buildUl, finishers, selectbox, selector;
      if (options == null) {
        options = {};
      }
      options.controller || (options.controller = 'categories');
      options.action || (options.action = 'children');
      options.collection || (options.collection = 'ads');
      options.finisher_class || (options.finisher_class = 'finisher');
      options.finisher_caption || (options.finisher_caption = 'Continue');
      selectbox = $("#" + ($(this).attr('id')) + "[rel]");
      selector = $(selectbox.attr('rel'));
      finishers = $("." + options.finisher_class);
      selectbox.overlay();
      finishers.live('click', function() {
        var li;
        li = selector.find('li.leaf.selected:last');
        if (li.length) {
          return window.location = "/" + options.controller + "/" + (li.attr('rel')) + "/" + options.collection + "/new";
        }
      });
      selector.find('li').live('click', function() {
        var e, finisher, li, ul, _results;
        li = $(this);
        ul = li.parents('ul').first();
        ul.find('li').removeClass('selected');
        ul.find("li." + options.finisher_class).remove();
        li.addClass('selected');
        if (li.hasClass('leaf')) {
          finisher = $('<li>').addClass("" + options.finisher_class).append(options.finisher_caption);
          ul.append(finisher);
          $("." + options.finisher_class).show();
        } else {
          $("." + options.finisher_class).hide();
          $.post("/" + options.controller + "/" + ($(this).attr('id')) + "/" + options.action, function(categories) {
            return ul.parent().append(buildUl(categories));
          }, 'json');
        }
        _results = [];
        while ((e = ul.next('ul')).length) {
          _results.push(e.remove());
        }
        return _results;
      });
      return buildUl = function(categories) {
        var c, i, li, ul;
        ul = $('<ul>');
        for (i in categories) {
          c = categories[i];
          li = $('<li>').attr('id', c.id).attr('rel', c.slug).append(c.name);
          li.addClass(c.branch ? 'branch' : 'leaf');
          ul.append(li);
        }
        return ul;
      };
    };
  })(jQuery);
}).call(this);
