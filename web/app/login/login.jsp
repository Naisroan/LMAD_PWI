<%-- 
    Document   : login
    Created on : Sep 2, 2020, 3:23:51 PM
    Author     : ianso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - NotiApp!</title>

        <!-- font -->
        <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@300;400;500&display=swap" rel="stylesheet">
        
        <!-- fontawesome -->
        <link rel="stylesheet" href="../../res/lib/fontawesome/css/all.min.css">
        
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css" integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">
        
        <!-- first party -->
        <link rel="stylesheet" href="../../res/lib/bootstrap/mods.css">
        <link rel="stylesheet" href="../../res/css/site.css">
        <link rel="stylesheet" href="login.css">

    </head>
    <body class="d-flex flex-column h-100">
        
        <div class="wrapper flex-shrink-0">

            <div class="container">
                <div class="row m-0 mt-lg-5">
                    <div class="d-none d-lg-inline-block offset-lg-1 col-lg-6">
                        <!-- <img src="../../res/images/login_account_credentials.svg" alt="" width="400" srcset=""> -->
                        <h1 class="font-weight-bolder display-5 mt-5 mb-4" style="color: #e69e7b">
                            NotiApp!
                        </h1>
                        <h2 class="text-white">Descubre las noticias mas relevantes del momento</h2>
                    </div>
                    <div class="col-12 col-lg-4">
                        <div class="box shadow">
                            <div class="row g3">
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
                                        id="usuario" 
                                        name="usuario" 
                                        type="text" 
                                        class="form-control form-control-lg"
                                        placeholder="Usuario" />
                                    </div>
                                   
                                </div>
                                <div class="col-12 mb-5">
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
                                    <button id="btnIniciarSesion" name="btnIniciarSesion" class="btn btn-primary btn-block btn-lg">
                                        Iniciar Sesión
                                    </button>
                                </div>
                                <div class="col-12 text-center">
                                    <button id="btnRegistrar" name="btnRegistrar" class="btn btn-outline-light btn-lg" data-toggle="modal" data-target="#modalRegistrarse">
                                        Registrarse
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer mt-auto py-4 bg-dark text-light">
            <div class="container">
                LMAD
            </div>
        </footer>

        <div id="modalRegistrarse" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="registroModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="registroModalLabel">Registrate</h5>
                        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button> -->
                    </div>
                    <div class="modal-body">
                        <form class="row g-3" method="post">
                            <div class="col-12 mb-3">
                                <label for="" class="lead">
                                    Ingresa los siguientes datos:
                                </label>
                            </div>
                            <div class="col-12 mb-3">
                                <input name="registro_confirmar_password" type="email" placeholder="Correo" class="form-control form-control-lg">
                                <small class="text-muted">Ingresa tu correo electrónico</small>
                            </div>
                            <div class="col-12 mb-3">
                                <input name="registro_usuario" type="text" placeholder="Usuario" class="form-control form-control-lg">
                                <small class="text-muted">Ingresa tu nombre de usuario</small>
                            </div>
                            <div class="col-12 mb-3">
                                <input name="registro_password" type="password" placeholder="Contraseña" class="form-control form-control-lg">
                                <small class="text-muted">Ingresa tu contraseña</small>
                            </div>
                            <div class="col-12 mb-4">
                                <input name="registro_confirmar_password" type="password" placeholder="Confirmar contrseña" class="form-control form-control-lg">
                                <small class="text-muted">Ingresa de nuevo tu contraseña</small>
                            </div>
                            <div class="col-12 text-right mb-3">
                                <button type="button" class="btn btn-primary">Registrarse</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Volver</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js" integrity="sha384-oesi62hOLfzrys4LxRF63OJCXdXDipiYWBnvTl9Y9/TRlw5xlKIEHpNyvvDShgf/" crossorigin="anonymous"></script>
        
        <!-- first party -->
        <script src="../../res/js/site.js"></script>
        <script src="login.js"></script>

    </body>
</html>
