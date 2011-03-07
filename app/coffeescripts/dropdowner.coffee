(($) ->
    $.fn.dropdowner = (options = {}) ->
        options.controller       or= 'categories'
        options.action           or= 'children'
        options.collection       or= 'lots'
        options.finisher_class   or= 'finisher'
        options.finisher_caption or= 'Продолжить'

        selecbox  = $ "##{$(this).attr 'id'}[rel]"
        selector  = $ selecbox.attr('rel')
        finishers = $ ".#{options.finisher_class}"

        selecbox.overlay()

        finishers.live 'click', ->
            li = selector.find 'li.leaf.selected:last'
            if li.length
                window.location = "/#{options.controller}/#{li.attr('rel')}/#{options.collection}/new"

        selector.find('li').live 'click',->
            li = $(this)
            ul = li.parents('ul').first()

            ul.find('li').removeClass 'selected'
            ul.find("li.#{options.finisher_class}").remove()

            li.addClass 'selected'

            if li.hasClass 'leaf'
                finisher = $('<li>').addClass("#{options.finisher_class}").append options.finisher_caption
                ul.append finisher

                $(".#{options.finisher_class}").show()
            else
                $(".#{options.finisher_class}").hide()

                $.post("/#{options.controller}/#{$(this).attr('id')}/#{options.action}",
                    (categories) ->
                        ul.parent().append(buildUl categories)
                    , 'json'
                )

            # remove right positioned uls
            e.remove() while (e = ul.next('ul')).length

        buildUl = (categories) ->
            ul = $ '<ul>'
            for i, c of categories
                li = $('<li>').attr('id', c.id).attr('rel', c.slug).append c.name
                li.addClass(if c.branch then 'branch' else 'leaf')
                ul.append li
            ul
)(jQuery)
