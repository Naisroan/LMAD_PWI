<%-- 
    Document   : login
    Created on : Sep 2, 2020, 3:23:51 PM
    Author     : ianso
--%>

<%@page import="DAO.UsuarioDAO"%>
<%@page import="Model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    Object usuarioLogeado = request.getSession(true).getAttribute("usuario_logeado");
    
    if (usuarioLogeado != null)
    {
        response.sendRedirect(request.getContextPath() + "/app/home.jsp");
    }
    
    Cookie[] cookies = null;
    cookies = request.getCookies();

    if(cookies != null) {
        
        for (int i = 0; i < cookies.length; i++) {
            
            Cookie cookie = cookies[i];

            if(cookie.getName() == "mantener_sesion") {
                
                Usuario usuario = UsuarioDAO.ReadByNick(String.valueOf(cookie.getValue()));

                if (usuario != null) {
                    
                    request.getSession(true).setAttribute("usuario_logeado", usuario);
                    response.sendRedirect(request.getContextPath() + "/app/home.jsp");
                }
                
                break;
            }
         }
    }
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login - NotiApp!</title>

        <!-- font -->
        <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@300;400;500&display=swap" rel="stylesheet">
        
        <!-- fontawesome -->
        <link rel="stylesheet" href="res/lib/fontawesome/css/all.min.css">
        
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css" integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">
        
        <!-- first party -->
        <link rel="stylesheet" href="res/lib/bootstrap/mods.css">
        <link rel="stylesheet" href="res/css/site.css">
        <link rel="stylesheet" href="res/css/login.css">

    </head>
    <body class="d-flex flex-column h-100">
        
        <div class="wrapper flex-shrink-0">

            <div class="container">
                <div class="row m-0 mt-lg-5">
                    <div class="d-none d-lg-inline-block offset-lg-1 col-lg-6">
                        <!-- <img src="../../res/images/login_account_credentials.svg" alt="" width="400" srcset=""> -->
                        <h1 class="font-weight-bolder display-1 mt-5 mb-4 mask" style="color: #0ddcfd">
                            NotiApp!
                        </h1>
                        <h2 class="text-dark">Descubre las noticias mas relevantes de los videojuegos del momento</h2>
                    </div>
                    <div class="col-12 col-lg-4">
                        <div class="box shadow">
                            <form id="frm_login" method="post" class="row g3">
                                <div class="col-12 mb-4">
                                    <label class="lead text-white">
                                        Ingresa tus credenciales
                                    </label>
                                </div>
                                <div class="col-12 mb-4">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-user fa-fw"></i>
                                        </span>
                                        <input 
                                        id="nick" 
                                        name="nick" 
                                        type="text" 
                                        class="form-control form-control-lg"
                                        placeholder="Usuario" />
                                    </div>
                                   
                                </div>
                                <div class="col-12 mb-4">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-key fa-fw"></i>
                                        </span>
                                        <input 
                                        id="password" 
                                        name="password" 
                                        type="password" 
                                        class="form-control form-control-lg"
                                        placeholder="Contraseña" />
                                    </div>
                                </div>
                                <div class="col-12 mb-4">
                                    <div class="form-check">
                                        <input id="chkMantenerSesion" name="chkMantenerSesion" class="form-check-input" type="checkbox" value="">
                                        <label class="form-check-label text-white" for="chkMantenerSesion">
                                          Mantener Sesión
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12 mb-4">
                                    <button id="btnIniciarSesion" name="btnIniciarSesion" class="btn btn-primary btn-block btn-lg">
                                        Iniciar Sesión
                                    </button>
                                </div>
                                <div class="col-12 mb-4">
                                    <button id="btnAnonimo" name="btnAnonimo" type="button" class="btn btn-dark btn-block btn-lg" onclick="modoAnonimo();">
                                        Modo Anónimo
                                    </button>
                                </div>
                                <div class="col-12 text-center">
                                    <a href="#!" name="btnRegistrar" class="btn btn-outline-light btn-lg" data-toggle="modal" data-target="#modalRegistrarse">
                                        Crearse una cuenta
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer mt-auto py-4 bg-dark text-light">
            <%-- <div class="container">
                <div class="d-flex justify-content-between">
                    <img src="../../res/images/uanl_alpha_white.png" class="mr-2" width="150" />
                    <div class="fcfm">
                        <img src="../../res/images/lmad.png" class="mr-3" width="70" style="vertical-align: bottom;" />
                        <img src="../../res/images/fcfm_alpha_white.png" width="150" />
                    </div>
                </div>
            </div> --%>
        </footer>

        <div id="modalRegistrarse" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="registroModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="registroModalLabel">
                            Registrate                        
                            <small class="text-muted d-block">Ingresa los datos que se te piden</small>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="frm_registro" class="row g-3" method="post">
                            <div class="col-12 col-lg-6 mb-3">
                                <input id="registro_correo" name="registro_correo" type="email" placeholder="Correo" class="form-control form-control-lg">
                                <small class="text-muted d-block">Ingresa tu correo electrónico</small>
                                <span class="badge rounded-pill bg-secondary">30 letras máximo</span>
                            </div>
                            <div class="col-12 col-lg-6 mb-3">
                                <input id="registro_nick" name="registro_nick" type="text" placeholder="Usuario" class="form-control form-control-lg">
                                <small class="text-muted d-block">Ingresa tu nombre de usuario</small>
                                <span class="badge rounded-pill bg-secondary">3 letras mínimo</span>
                                <span class="badge rounded-pill bg-secondary">25 letras máximo</span>
                            </div>
                            <div class="col-12 mb-3">
                                <input id="registro_password" name="registro_password" type="password" placeholder="Contraseña" class="form-control form-control-lg">
                                <small class="text-muted d-block">Ingresa tu contraseña</small>
                                <span class="badge rounded-pill bg-secondary">8 letras mínimo</span>
                                <span class="badge rounded-pill bg-secondary">25 letras máximo</span>
                                <span class="badge rounded-pill bg-secondary">Un número</span>
                                <span class="badge rounded-pill bg-secondary">Una mayúscula</span>
                                <span class="badge rounded-pill bg-secondary">Una minúscula</span>
                            </div>
                            <div class="col-12 mb-4">
                                <input id="registro_confirmar_password" name="registro_confirmar_password" type="password" placeholder="Confirmar contraseña" class="form-control form-control-lg">
                                <small class="text-muted">Ingresa de nuevo tu contraseña</small>
                            </div>
                            <div class="col-12 text-center mb-3">
                                <button id="btnRegistrar" type="submit" class="btn btn-primary btn-lg">Registrarse</button>
                            </div>
                        </form>
                    </div>
                    <!--
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Volver</button>
                    </div>
                    -->
                </div>
            </div>
        </div>
        
        <!-- jquery (para ajax) -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        
        <!-- sweetalert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        
        <!-- bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js" integrity="sha384-oesi62hOLfzrys4LxRF63OJCXdXDipiYWBnvTl9Y9/TRlw5xlKIEHpNyvvDShgf/" crossorigin="anonymous"></script>
        
        <!-- first party -->
        <script src="res/js/site.js"></script>
        <script src="res/js/login.js"></script>

    </body>
</html>
