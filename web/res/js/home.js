$(function () {
    $(window).scroll(function (e) {
        if ($(this).scrollTop() > 0) {
            $('.encabezado').addClass('fix');
        } else {
            $('.encabezado').removeClass('fix');
        }
    });
    $('#cambiar_imagen').on('click', function(e) {
        $('#fuAvatar').click();
    });
    $('#fuAvatar').on('change', function(e) {
       let image = $(this)[0];
       if(image.length <= 0){
           return;
       }
       $('#frm_change_avatar').submit();
    });
});


