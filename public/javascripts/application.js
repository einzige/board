/* DO NOT MODIFY. This file was compiled Tue, 08 Mar 2011 06:11:47 GMT from
 * /home/szinin/git/inform/app/coffeescripts/application.coffee
 */

(function() {
  $(function() {
    return $("html").bind("ajaxStart", function() {
      return $(this).addClass('busy');
    }).bind("ajaxStop", function() {
      return $(this).removeClass('busy');
    }).bind("ajaxSend", function(event, request, settings) {
      if (typeof(AUTH_TOKEN) == "undefined") return $(this);
      settings.data = settings.data || "";
      settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
      return $(this);
    });
  });
}).call(this);

