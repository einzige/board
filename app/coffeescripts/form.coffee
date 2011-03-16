(($) ->
    $.fn.initForm = () ->
        $(this).initNumeric()
        $(this).initValidation()
        $(this).initCheckboxes()


    $.fn.initCheckboxes = () ->
        $(this).find(':checkbox.tristate').tristate()


    $.fn.initNumeric = () ->
        $(this).find('input[type=text]').each ->
            options = {}
            min =  $(this).attr 'min'
            max =  $(this).attr 'max'
            step = $(this).attr 'step'

            if min
                $.extend(options, {minValue:   parseFloat(min)})
            if max
                $.extend(options, {maxValue:   parseFloat(max)})
            if step
                $.extend(options, {normalStep: parseFloat(step)})

            $(this).jStepper(options) if (min || max)


    $.fn.initValidation = () ->
        if $.tools
            $.tools.validator.localize('ru', {'[required]': 'This field is required'})
            $(this).validator({lang: 'ru'})

            $(this).bind "onFail", (e, errors) ->
                if e.originalEvent.type == 'submit'
                    $.each errors, ->
                        input = this.input
                        input.css({borderColor: 'red'}).focus ->
                            input.css {borderColor: '#444'}
)(jQuery)
