(($) ->
    $.fn.initEditor = (options = {}) ->
        options.layout or= 'form_layout'

        $(this).initLayout options

        $(this).find('.container').each ->
            $(this).initContainer({collection: 'characteristic_containers', layout: options.layout})

        $(this).find('.characteristic').each ->
            $(this).initItem({layout: options.layout})

    $.fn.initLayout = (options = {}) ->
        options.resizable or= true
        options.grid      or= [2,2]

        $(this).initCanvasItem options


    $.fn.initContainer = (options = {}) ->
        options.resizable  or= true
        options.draggable  or= true
        options.grid       or= [2,2]
        options.collection or= 'containers'

        $(this).initCanvasItem options


    $.fn.initItem = (options = {}) ->
        options.resizable  or= true
        options.draggable  or= true
        options.paddable   or= true
        options.collection or= 'characteristics'

        $(this).initCanvasItem options


    $.fn.initCanvasItem = (options = {}) ->
        options.w    or= 600
        options.h    or= 100
        options.maxw or= 680
        options.maxh or= 9999
        options.minw or= 20
        options.minh or= 20
        options.grid or= [4,4]

        options.collection  or= false

        options.containment or= 'parent'

        options.draggable   or= false
        options.resizable   or= false
        options.paddable    or= false

        options.layout      or= $(this).attr 'id'


        if options.collection
            name = options.collection+'['+$(this).attr('id')+']'+'['+options.layout+']'
        else
            name = options.layout

        form = $($(this).attr 'rel')

        if options.resizable
            w = parseInt $(this).width()
            h = parseInt $(this).height()

            $('<input type  ="hidden" 
                      name  ="'+name+'[height]" 
                      value ="'+h+'" />').appendTo form
            $('<input type  ="hidden" 
                      name  ="'+name+'[width]" 
                      value ="'+w+'" />').appendTo form

            $(this).resizable(
                {
                grid: options.grid,
                maxWidth: options.maxw,
                minWidth: options.minw,
                stop: (event, ui) ->
                    $('input[name="'+name+'[width]"]' ).val parseInt($(this).width())
                    $('input[name="'+name+'[height]"]').val parseInt($(this).height())
                }
            )

        if options.draggable
            x = parseInt $(this).css('left')
            y = parseInt $(this).css('top')

            $('<input type  ="hidden" 
                      name  ="'+name+'[x]" 
                      value ="'+x+'" />').appendTo form
            $('<input type  ="hidden" 
                      name  ="'+name+'[y]" 
                      value ="'+y+'" />').appendTo form

            $(this).draggable(
                {
                    grid: options.grid,
                    containment: options.containment,
                    stop: (event, ui) ->
                        $('input[name="'+name+'[x]"]').val parseInt($(this).css('left'))
                        $('input[name="'+name+'[y]"]').val parseInt($(this).css('top'))
                }
            )

        if options.paddable
            aim = $(this).find('.value')
            p = parseInt(aim.css 'left')

            $('<input type  ="hidden" 
                      name  ="'+name+'[padding]" 
                      value ="'+p+'" />').appendTo form
            aim.draggable(
                {
                    axis: "x",
                    containment: "parent",
                    stop: (event, ui) ->
                        $('input[name="'+name+'[padding]"]').val parseInt($(this).css('left'))
                }
            )

)(jQuery)
