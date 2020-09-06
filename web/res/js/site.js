function isNull(value) {
    
    return value === undefined || value === "";
}

function showToast(text, icon) {
    
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3500,
        timerProgressBar: true,
        onOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    /*
     * iconos:
     * success
     * info
     * error
     * warning
     * question
     */

    Toast.fire({
        icon: icon === "" || icon === undefined ? "info" : icon,
        title: text
    });
}

function showMessage(title, text, icon, buttonText) {
    
    Swal.fire({
        icon: icon === "" || icon === undefined ? "info" : icon,
        title: title,
        text: text,
        confirmButtonText: buttonText === "" || buttonText === undefined ? '<i class="fas fa-thumbs-up mr-2"></i>Entendido' : buttonText,
    });
}

function setButtonOnLoading(selector, text) {
    
    var button = $(selector);
    
    if (isNull(button))
        return;
    
    button.prop("disabled", true);
    button.prepend('<span class="spinner-grow spinner-grow-sm mr-2" role="status" aria-hidden="true"></span>');
    
    var htmlSpinner = isNull(text) ? '<span class="spinner-grow spinner-grow-sm mb-1" role="status" aria-hidden="true"></span>'
        : '<span class="spinner-grow spinner-grow-sm mb-1 mr-2" role="status" aria-hidden="true"></span>';
        
    var htmlText = isNull(text) ? '' : '<span>' + text + '</span>';
    
    button.html(htmlSpinner + htmlText);
}

function setButtonOnEnabled(selector, text) {
    
    var button = $(selector);
    
    if (isNull(button))
        return;
    
    button.prop("disabled", false);
    button.html(text);
}

function validPassword(str) {
    
    // se hizo un fix, al parecer se tiene que poner doble barra \\
    // para que no se confunda al analizar la cadena
    var patt = new RegExp('^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,25}$');
    
    return patt.test(str);
}

function hasMayus(str) {
    
    var patt = new RegExp('([A-Z])+');
    
    return patt.test(str);
}

function hasMinus(str) {
    
    var patt = new RegExp('([a-z])+');
    
    return patt.test(str);
}

function hasNumbers(str) {
    
    // solo numeros
    // var patron = '^([0-9])+$';
    
    var patt = new RegExp("([0-9])+");
    
    return patt.test(str);
}