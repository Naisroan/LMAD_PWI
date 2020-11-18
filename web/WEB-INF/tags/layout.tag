<%@tag description="NotiApp General Tag" pageEncoding="UTF-8"%>

<%@attribute name="titulo" fragment="true" %>
<%@attribute name="styles" fragment="true" %>
<%@attribute name="scripts" fragment="true" %>

<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix = "x" uri = "http://java.sun.com/jsp/jstl/xml" %>
<%@taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

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
        <link rel="stylesheet" href="<c:url value='/res/lib/fontawesome/css/all.min.css'/>">
        
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css" integrity="sha384-r4NyP46KrjDleawBgD5tp8Y7UzmLA05oM1iAEQ17CSuDqnUK2+k9luXQOfXJCJ4I" crossorigin="anonymous">
        
        <!-- first party -->
        <link rel="stylesheet" href="<c:url value='/res/css/menu.css'/>">
        <link rel="stylesheet" href="<c:url value='/res/lib/bootstrap/mods.css'/>">
        <link rel="stylesheet" href="<c:url value='/res/css/site.css'/>">
        
        <!-- styles pages -->
        <jsp:invoke fragment="styles" />
        
    </head>
    <body>
        
        <div class="wrapper">
            
            <!--
            <div class="notiapp bg-dark py-2">
                <div class="container d-flex justify-content-between">
                    
                    
                </div>
            </div>
            -->
            
            <nav class="navegacion sticky-top shadow">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-1 col-lg-3">
                            <div class="logo h-100 d-flex flex-column justify-content-center">
                                <h1 class="text-inherit d-none d-lg-inline-block mb-0">Notiapp!</h1>
                                <h1 class="text-inherit d-inline-block d-lg-none mb-0">N!</h1>
                            </div>
                        </div>
                        <div class="col-4 col-lg-6 text-center text-inherit">
                            <ul class="list-unstyled d-flex mb-0">
                                <li class="d-flex">
                                    <a href="#!" class="text-inherit p-3">
                                        <i class="fas fa-user fa-fw"></i>
                                    </a>
                                </li>
                                <li class="d-flex">
                                    <a href="#!" class="text-inherit p-3">
                                        <i class="fas fa-home fa-fw"></i>
                                    </a>
                                </li>
                                <li class="d-flex">
                                    <a href="#!" class="text-inherit p-3">
                                        <i class="fas fa-search fa-fw"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-7 col-lg-3 text-right">
                            <div class="text-inherit h-100 d-flex flex-column justify-content-center align-items-end">
                                <div class="dropdown">
                                    <button class="btn btn-secondary bg-transparent dropdown-toggle d-flex align-items-center" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-expanded="false">
                                        <img src="https://picsum.photos/30/30" height="30" width="30" class="rounded-circle mr-3" />
                                        <div class="">
                                            <h5 class="mb-0">
                                                <c:out value="${usuario_logeado.nick}" />
                                            </h5>
                                        </div>
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/Logout" class="dropdown-item d-flex flex-row align-items-center">
                                                <i class="fas fa-sign-out-alt fa-fw mr-3"></i>
                                                <h6 class="mb-0">Cerrar Sesión</h6>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!--
                            <div class="busqueda text-inherit h-100 d-flex flex-column justify-content-center">
                                <form method="post">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-search text-white fa-fw"></i>
                                        </span>
                                        <input type="text" class="form-control text-inherit" placeholder="Ingresa tu búsqueda" />
                                    </div>
                                </form>
                            </div>
                            -->
                        </div>
                    </div>   
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
        <script src="<c:url value='/res/js/site.js'/>"></script>
        
        <!-- scripts pages -->
        <jsp:invoke fragment="scripts" />

    </body>
</html>