/* DO NOT MODIFY. This file was compiled Thu, 21 Apr 2011 09:50:35 GMT from
 * /home/szinin/git/inform/app/coffeescripts/form.coffee
 */

(function() {
  (function($) {
    var validate_operations;
    $.fn.initForm = function() {
      $(this).initNumeric();
      $(this).initValidation();
      return $(this).initCheckboxes();
    };
    $.fn.initCheckboxes = function() {
      return $(this).find(':checkbox.tristate').tristate();
    };
    $.fn.initNumeric = function() {
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
    validate_operations = function() {
      if (!$('.operations :checked').length) {
        $('.operations .error').show();
        return $('.operations').addClass('invalid');
      } else {
        $('.operations .error').hide();
        return $('.operations').removeClass('invalid');
      }
    };
    return $.fn.initValidation = function() {
      if ($.tools) {
        $.tools.validator.localize('ru', {
          '[required]': 'This field is required'
        });
        $(this).validator({
          lang: 'ru'
        });
        if ($('.operations :checkbox').length) {
          $('.operations :checkbox').change(validate_operations);
          $(this).bind("onBeforeValidate", validate_operations);
        }
        return $(this).bind("onFail", function(e, errors) {
          if (e.originalEvent && e.originalEvent.type === 'submit') {
            return $.each(errors, function() {
              var input;
              input = this.input;
              return input.css({
                borderColor: 'red'
              }).focus(function() {
                return input.css({
                  borderColor: '#444'
                });
              });
            });
          }
        });
      }
    };
  })(jQuery);
}).call(this);
