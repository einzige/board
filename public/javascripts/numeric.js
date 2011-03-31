/* DO NOT MODIFY. This file was compiled Mon, 14 Mar 2011 12:09:27 GMT from
 * /home/szinin/git/inform/app/coffeescripts/numeric.coffee
 */

(function() {
  (function($) {
    return $.fn.numeric = function() {
      return $(this).find('input[type=text]').each(function() {
        var max, min, options, step;
        options = {};
        min = $(this).attr('min');
        max = $(this).attr('max');
        step = $(this).attr('step');
        if (min) {
          $.extend(options, {
            minValue: parseFloat(min)
          });
        }
        if (max) {
          $.extend(options, {
            maxValue: parseFloat(max)
          });
        }
        if (step) {
          $.extend(options, {
            normalStep: parseFloat(step)
          });
        }
        if (min || max) {
          return $(this).jStepper(options);
        }
      });
    };
  })(jQuery);
}).call(this);
