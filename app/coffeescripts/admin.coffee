$(document).ready ->
    $('#admin_toggler').click ->
        menu = $('.admin-menu')

        if parseInt(menu.css('right')) > -1
            menu.animate({ right: -(menu.width() - 14) }, 2000)
        else
            menu.animate({ right: 0}, 2000)

