$(() -> $("html").bind("ajaxStart", () -> $(this).addClass('busy')) \
                 .bind("ajaxStop",  () -> $(this).removeClass('busy')))
