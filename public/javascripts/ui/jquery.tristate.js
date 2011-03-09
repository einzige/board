(function($) {
    $.fn.tristate = function() {
        var states = { intermediate : { value : '',  css : 'does_not_matters' },
                            checked : { value : 'true', css : 'yes' },
                          unchecked : { value : 'false', css : 'no' }}

        var getNextState = function(state) {
            switch (state) {
            case states.intermediate:
                return states.checked;
            case states.unchecked:
                return states.intermediate;
            case states.checked:
                return states.unchecked;
            }
        }
        var getStateByValue = function(value) {
            for (state in states) 
            {
               var s = states[state];
               if (s.value == value)
                 return s;
            }

            return states.unchecked;
        }

        var toNextState = function(cbox) {
            var nextState = getNextState(getStateByValue(cbox.attr('value')));
            cbox.setState(nextState);
        }

        this.each(function() {
            var box = $(this);
            var cid = box.attr('id');
            var sid = cid + '_presentor';

            box.attr('checked', 'checked');

            box.hide();
            var istate = getStateByValue(box.attr('value'));

            box.wrap('<div class="'+istate.css+'" id="'+sid+'" />');
            var presentor = $('#'+sid);

            box.unbind('click');
            presentor.click(function() { toNextState(box); });

            // Allows labels for this checkbox to update state
            box.parents('form').find('label[for='+cid+']').first().click( function() { toNextState(box); });

            // ang this should not be passed into rails auto-generated hidden field
            var name = box.attr('name');
            $('input[type="hidden"][name="'+name+'"]').remove();
        });
        
        $.fn.setState = function(newState) {
            var cbox = $(this);
            var span = cbox.parent();

            cbox.val(newState.value);
            span.attr('class', newState.css)

            // so we dont need to pass it to POST if its in intermediate state
            if (newState == states.intermediate)
            {
              cbox.attr('name_storage', cbox.attr('name'));
              cbox.removeAttr('name');
              cbox.removeAttr('checked');
            } else {
              cbox.attr('name', cbox.attr('name_storage'));
              cbox.removeAttr('name_storage');
              cbox.attr('checked', 'checked');
            }
        }
    };
})(jQuery);
