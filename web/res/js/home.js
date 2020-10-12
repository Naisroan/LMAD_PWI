$(function () {
    $(window).scroll(function (e) {
        if ($(this).scrollTop() > 0) {
            $('.encabezado').addClass('fix');
        } else {
            $('.encabezado').removeClass('fix');
        }
    });
});


