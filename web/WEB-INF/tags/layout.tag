<%@tag description="NotiApp General Tag" pageEncoding="UTF-8"%>

<%@attribute name="titulo" fragment="true" %>
<%@attribute name="styles" fragment="true" %>
<%@attribute name="scripts" fragment="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <title>
            <jsp:invoke fragment="titulo" /> - Notiapp!
        </title>

        <!-- font -->
        <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@300;400;500&display=swap" rel="stylesheet">
        
        <!-- fontawesome -->
        <link rel="stylesheet" href="../res/lib/fontawesome/css/all.min.css">
        
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css" integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">
        
        <!-- first party -->
        <link rel="stylesheet" href="../res/css/menu.css">
        <link rel="stylesheet" href="../res/lib/bootstrap/mods.css">
        <link rel="stylesheet" href="../res/css/site.css">
        
        <!-- styles pages -->
        <jsp:invoke fragment="styles" />
        
    </head>
    <body>
        
        <div class="wrapper">
            
            <div class="notiapp bg-dark py-2">
                <div class="container d-flex justify-content-between">
                    <div class="logo">
                        <h1 class="text-white">Notiapp!</h1>
                    </div>
                    <div class="busqueda text-white ml-4">
                        <form method="post">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-search text-white fa-fw"></i>
                                </span>
                                <input type="text" class="form-control  text-white" placeholder="Ingresa tu búsqueda" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <nav class="navegacion bg-dark sticky-top">
                <div class="container">
                    <ul class="list-unstyled d-flex justify-content-between mb-0">
                        <li class="d-flex">
                            <a href="#!" class="text-white p-3">
                                <i class="fas fa-user fa-fw"></i>
                            </a>
                        </li>
                        <li class="d-flex">
                            <a href="#!" class="text-white p-3">
                                <i class="fas fa-home fa-fw"></i>
                            </a>
                        </li>
                        <li class="d-flex">
                            <a href="#!" class="text-white p-3">
                                <i class="fas fa-bars fa-fw"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
            
            <div class="container-fluid">
                <jsp:doBody />
            </div>
            
        </div>
        
        <!-- sweetalert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        
        <!-- jquery (para ajax) -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        
        <!-- bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js" integrity="sha384-oesi62hOLfzrys4LxRF63OJCXdXDipiYWBnvTl9Y9/TRlw5xlKIEHpNyvvDShgf/" crossorigin="anonymous"></script>
        
        <!-- first party -->
        <script src="../res/js/site.js"></script>
        
        <!-- scripts pages -->
        <jsp:invoke fragment="scripts" />

    </body>
</html>