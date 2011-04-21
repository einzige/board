/* DO NOT MODIFY. This file was compiled Thu, 21 Apr 2011 09:50:35 GMT from
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
