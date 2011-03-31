/* DO NOT MODIFY. This file was compiled Wed, 30 Mar 2011 05:55:51 GMT from
 * /home/szinin/git/inform/app/coffeescripts/admin.coffee
 */

(function() {
  $(document).ready(function() {
    return $('#admin_toggler').click(function() {
      var menu;
      menu = $('.admin-menu');
      if (parseInt(menu.css('right')) > -1) {
        return menu.animate({
          right: -(menu.width() - 14)
        }, 2000);
      } else {
        return menu.animate({
          right: 0
        }, 2000);
      }
    });
  });
}).call(this);
