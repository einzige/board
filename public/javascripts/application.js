/* DO NOT MODIFY. This file was compiled Wed, 30 Mar 2011 05:55:51 GMT from
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
