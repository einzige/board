/* DO NOT MODIFY. This file was compiled Tue, 29 Mar 2011 17:25:15 GMT from
 * /home/szinin/git/inform/app/coffeescripts/application.coffee
 */

(function() {
  $(function() {
    return $("html").bind("ajaxStart", function() {
      return $(this).addClass('busy');
    }).bind("ajaxStop", function() {
      return $(this).removeClass('busy');
    });
  });
}).call(this);
