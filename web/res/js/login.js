$(document).ready(function() {
    
    $('#frm_login').on('submit', frm_loginOnSubmit);
    $('#frm_registro').on('submit', frm_registroOnSubmit);
});

// --------------------------------------------------
// login
// --------------------------------------------------

function frm_loginOnSubmit(e, esAnonimo) {

    if (e !== null) {
        e.preventDefault();
    }

    setButtonOnLoading('#btnIniciarSesion');
    
    if (!validarCamposLogin(esAnonimo)) {
    
        setButtonOnEnabled('#btnIniciarSesion', 'Iniciar Sesión');
        return;
    }

    $.ajax({
        url: 'GetUsuario',
        data: {
            esAnonimo: esAnonimo,
            nick: $('#nick').val(),
            password: $('#password').val(),
            mantener_sesion: $('#chkMantenerSesion').is(':checked')
        },
        success: function(result) {

            setButtonOnEnabled('#btnIniciarSesion', 'Iniciar Sesión');

            if (verificarUsuarioObtenido(result)) {
                limpiarCamposLogin();
                window.location = "/LMAD_PWI/Home";
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {

            showMessage('Ha ocurrido un error', 
                !isNull(jqXHR.responseText) ? jqXHR.responseText : textStatus, 'error');
            setButtonOnEnabled('#btnIniciarSesion', 'Iniciar Sesión');
        }
    });
}

function validarCamposLogin(esAnonimo) {
    
    var nick = $('#nick').val();
    var password = $('#password').val();
    
    if (isNull(nick)) {
        
        showMessage("¡Espera!", "Ingresa el usuario", "warning");
        return false;
    }
    
    if (!esAnonimo && isNull(password)) {
        
        showMessage("¡Espera!", "Ingresa la contraseña", "warning");
        return false;
    }
    
    return true;
}

function limpiarCamposLogin() {
    
    $('#nick').val('');
    $('#password').val('');
}

function verificarUsuarioObtenido(usuario) {
    
    if (usuario === undefined || usuario === "") {
        
        showMessage("¡Espera!", "Usuario y/o contraseña no coinciden", "warning");
        return false;
        
    } else {
        
        showToast("Sesión iniciada con éxito!", "success");
        return true;
    }
}

// --------------------------------------------------
// registro
// --------------------------------------------------

function frm_registroOnSubmit(e) {
      
    setButtonOnLoading('#btnRegistrar');
    e.preventDefault();

    if (!validarCamposRegistro()) {
        setButtonOnEnabled('#btnRegistrar', 'Registrarse');
        return;
    }

    $.ajax({
        url: 'RegistrarUsuario',
        data: {
            correo: $('#registro_correo').val(),
            nick: $('#registro_nick').val(),
            password: $('#registro_password').val()
        },
        success: function(result) {

            verificarRegistro(result);
            setButtonOnEnabled('#btnRegistrar', 'Registrarse');
            limpiarCamposRegistro();
        },
        error: function(jqXHR, textStatus, errorThrown) {

            showMessage('Ha ocurrido un error', 
                !isNull(jqXHR.responseText) ? jqXHR.responseText : textStatus, 'error');
            setButtonOnEnabled('#btnRegistrar', 'Registrarse');
        }
    });
}

function validarCamposRegistro() {
    
    var correo = $('#registro_correo').val();
    var nick = $('#registro_nick').val();
    var password = $('#registro_password').val();
    var confirmarPassword = $('#registro_confirmar_password').val();
    
    if (isNull(correo)) {
        
        showMessage("¡Espera!", "Ingresa el correo", "warning");
        return false;
        
    } else {
        
        if (correo.length > 30) {
        
            showMessage("¡Espera!", "El correo no puede tener mas de 30 letras", "warning");
            return false;
        }
    }
    
    if (isNull(nick)) {
        
        showMessage("¡Espera!", "Ingresa el usuario", "warning");
        return false;
        
    } else {
        
        if (nick.length < 3) {
        
            showMessage("¡Espera!", "El usuario debe tener mas de 3 letras", "warning");
            return false;
        }
        
        if (nick.length > 25) {
        
            showMessage("¡Espera!", "El usuario no puede tener mas de 25 letras", "warning");
            return false;
        }
    }
    
    if (isNull(password)) {
        
        showMessage("¡Espera!", "Ingresa la contraseña", "warning");
        return false;
        
    } else {
        
        if (!validPassword(password)) {
            
            showMessage("¡Espera!", "La contraseña debe tener al menos 8 letras, \n\
                            una mayuscula, una minuscula, un número, un símbolo y no \n\
                            superar 25 letras", "warning");
            return false;
        }
    }
    
    if (isNull(confirmarPassword)) {
        
        showMessage("¡Espera!", "Confirma la contraseña", "warning");
        return false;
    }
    
    if (password !== confirmarPassword) {
        
        showMessage("¡Espera!", "Las contraseñas no coinciden", "warning");
        return false;
    }
    
    return true;
}

function limpiarCamposRegistro() {
    
    $('#registro_correo').val('');
    $('#registro_nick').val('');
    $('#registro_password').val('');
    $('#registro_confirmar_password').val('');
}

function verificarRegistro(usuario) {
    
    if (isNull(usuario)) {
        
        showMessage('Ha ocurrido un error', 'El usuario no ha sido creado', 'error');
        return;
        
    }
    
    showMessage('¡Exito!', 'El usuario ha sido creado', 'success');
}

// metodos

function modoAnonimo() {
    frm_loginOnSubmit(null, true);
}