<%-- 
    Document   : home
    Created on : Sep 6, 2020, 7:03:40 PM
    Author     : ianso
--%>

<%@page import="Model.Usuario"%>
<%@page import="DAO.RolDAO"%>
<%@page import="Model.Rol"%>
<%@page import="Class.App"%>
<%@page import="DAO.NoticiaDAO"%>
<%@page import="Model.Noticia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ndev" tagdir="/WEB-INF/tags" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%
    Usuario usuario = App.AuthUser(request);
    
    if (usuario != null) {
        
        Rol rol = RolDAO.ReadByUsuario(String.valueOf(usuario.getId_usuario()));
        List<Noticia> noticiasRelevantes = NoticiaDAO.ReadAll(2);
        List<Noticia> noticiasFavoritasUsuario = NoticiaDAO.ReadByFavoritasUsuario(usuario.getId_usuario());
        List<Noticia> noticiasUsuario = NoticiaDAO.ReadByIdUsuario(usuario.getId_usuario());
        
        request.setAttribute("usuario", usuario);
        request.setAttribute("rol", rol);
        request.setAttribute("noticiasRelevantes", noticiasRelevantes);
        request.setAttribute("noticiasFavoritasUsuario", noticiasFavoritasUsuario);
        request.setAttribute("noticiasUsuario", noticiasUsuario);
    }
    
    
%>

<ndev:layout>
    
    <jsp:attribute name="titulo">
        Inicio
    </jsp:attribute>
    
    <jsp:attribute name="styles">
        <link href="<c:url value='/res/css/home.css'/>" type="text/css" rel="stylesheet" />
        <link href="<c:url value='/res/css/navegacion-home.css'/>" type="text/css" rel="stylesheet" />
    </jsp:attribute>
    
    <jsp:attribute name="scripts">
        <script type="text/javascript" src="<c:url value='/res/js/home.js'/>"></script>
    </jsp:attribute>
    
    <jsp:body>
        <div class="row mt-5">
            <div class="encabezado d-none d-lg-block col-12 col-lg-2 position-fixed">
                <div class="text-white">
                    <div class="d-flex align-items-center mb-5">
                        <img id="cambiar_imagen" src="<c:url value='${ usuario.ruta_imagen != null && !usuario.ruta_imagen.equals("") ? usuario.ruta_imagen : "https://picsum.photos/60/60"}'></c:url>" height="60" width="60" class="cambiar_imagen rounded-circle mr-3" />
                        <div class="">
                            <h5 class="mb-1">
                                <c:out value="${usuario_logeado.nick}" />
                            </h5>
                            <small class="text-muted">
                                <c:choose>
                                    <c:when test="${rol != null}">
                                        <c:out value="${rol.nombre}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="Anónimo" />
                                    </c:otherwise>
                                </c:choose>
                            </small>
                        </div>
                    </div>
                    <div class="acciones text-dark">
                        <form id="frm_change_avatar" class="" method="post" action="${pageContext.request.contextPath}/ChangeAvatar" enctype="multipart/form-data" hidden>
                            <input id="fuAvatar" name="fuAvatar" type="file" class="form-control" accept="image/x-png,image/jpeg" />
                        </form>
                        <div class="mb-3">
                            <small class="text-primary">
                                Acciones
                            </small>
                        </div>
                        <ul class="list-unstyled">
                            <c:if test="${rol.id_rol == 1 || rol.id_rol == 5}">
                                <li class="nav-item">
                                    <a href="<c:url value='/app/notice_detail.jsp?id=0' />" class="nav-link d-flex flex-row align-items-center">
                                        <i class="fas fa-plus fa-fw mr-3"></i>
                                        <h6 class="mb-0">Crear publicación</h6>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="col-12 col-lg-6 offset-lg-3">
                
                <ul class="nav nav-pills mb-5" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">
                            <i class="fas fa-home fa-fw"></i> Ultimas noticias
                        </a>
                    </li>
                    <c:if test="${rol.id_rol != 2}">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="pills-fav-tab" data-toggle="pill" href="#pills-fav" role="tab" aria-controls="pills-fav" aria-selected="false">
                                <i class="fas fa-star fa-fw"></i> Favoritas
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${rol.id_rol == 1 || rol.id_rol == 5}">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="pills-mis-tab" data-toggle="pill" href="#pills-mis" role="tab" aria-controls="pills-mis" aria-selected="false">
                                <i class="fas fa-pencil-alt fa-fw"></i> Mis noticias
                            </a>
                        </li>
                    </c:if>
                </ul>
                <div class="tab-content mb-5" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                        <c:choose>
                            <c:when test="${noticiasRelevantes != null && noticiasRelevantes.size() > 0}">
                                <c:forEach items="${noticiasRelevantes}" var="noticia">
                                    <c:if test="${usuario.id_usuario != noticia.id_usuario && (rol.getId_rol() == 1 || rol.getId_rol() == 6 || noticia.aprobada)}">
                                        <div class="card w-100 mb-5">
                                            <c:choose>
                                                <c:when test='${App.isImage(noticia.thumbnail)}'>
                                                    <img src="<c:url value="${noticia.thumbnail}"></c:url>" class="card-img-top" alt="">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="ratio ratio-16x9">
                                                        <video controls>
                                                            <source src="<c:url value="${noticia.thumbnail}"></c:url>" type="video/mp4">
                                                        </video>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <c:out value="${noticia.titulo}"></c:out>
                                                </h5>
                                                <p class="card-text">
                                                    <c:out value="${noticia.desc_corta}"></c:out>
                                                </p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <a href="<c:url value="/app/show_notice.jsp?id=${noticia.id_noticia}"></c:url>" class="">
                                                        Ver mas
                                                    </a>
                                                    <c:if test="${!noticia.aprobada && (usuario.id_usuario == noticia.id_usuario || rol.getId_rol() == 1 || rol.getId_rol() == 6)}">
                                                        <c:choose>
                                                            <c:when test="${App.esNoticiaPendienteAprobar(noticia)}">
                                                                <span class="badge bg-warning text-dark">Aún no ha sido aprobada ni rechazada</span>
                                                            </c:when>
                                                            <c:when test="${App.esNoticiaRechazada(noticia)}">
                                                                <span class="badge bg-danger">
                                                                   La noticia fue rechazada
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">
                                                                   La noticia fue aprobada
                                                                </span>
                                                            </c:otherwise>
                                                </c:choose>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-light" role="alert">
                                    ¡No hay noticias por ahora!
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="tab-pane fade" id="pills-fav" role="tabpanel" aria-labelledby="pills-fav-tab">
                        <c:choose>
                            <c:when test="${noticiasFavoritasUsuario != null && noticiasFavoritasUsuario.size() > 0}">
                                <c:forEach items="${noticiasFavoritasUsuario}" var="noticia">
                                    <div class="card w-100 mb-5">
                                        <c:choose>
                                            <c:when test='${App.isImage(noticia.thumbnail)}'>
                                                <img src="<c:url value="${noticia.thumbnail}"></c:url>" class="card-img-top" alt="">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="ratio ratio-16x9">
                                                    <video controls>
                                                        <source src="<c:url value="${noticia.thumbnail}"></c:url>" type="video/mp4">
                                                    </video>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <c:out value="${noticia.titulo}"></c:out>
                                            </h5>
                                            <p class="card-text">
                                                <c:out value="${noticia.desc_corta}"></c:out>
                                            </p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <a href="<c:url value="/app/show_notice.jsp?id=${noticia.id_noticia}"></c:url>" class="">
                                                    Ver mas
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-light" role="alert">
                                    ¡No tienes noticias marcadas com favoritas!
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="tab-pane fade" id="pills-mis" role="tabpanel" aria-labelledby="pills-mis-tab">
                        <c:choose>
                            <c:when test="${noticiasUsuario != null && noticiasUsuario.size() > 0}">
                                <c:forEach items="${noticiasUsuario}" var="noticia">
                                    <div class="card w-100 mb-5">
                                        <c:choose>
                                            <c:when test='${App.isImage(noticia.thumbnail)}'>
                                                <img src="<c:url value="${noticia.thumbnail}"></c:url>" class="card-img-top" alt="">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="ratio ratio-16x9">
                                                    <video controls>
                                                        <source src="<c:url value="${noticia.thumbnail}"></c:url>" type="video/mp4">
                                                    </video>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <c:out value="${noticia.titulo}"></c:out>
                                            </h5>
                                            <p class="card-text">
                                                <c:out value="${noticia.desc_corta}"></c:out>
                                            </p>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <a href="<c:url value="/app/show_notice.jsp?id=${noticia.id_noticia}"></c:url>" class="">
                                                    Ver mas
                                                </a>
                                                <c:choose>
                                                    <c:when test="${App.esNoticiaPendienteAprobar(noticia)}">
                                                        <span class="badge bg-warning text-dark">Aún no ha sido aprobada ni rechazada</span>
                                                    </c:when>
                                                    <c:when test="${App.esNoticiaRechazada(noticia)}">
                                                        <span class="badge bg-danger">
                                                           La noticia fue rechazada
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">
                                                           La noticia fue aprobada
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-light" role="alert">
                                    ¡No tienes tienes noticias creadas!
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <!--
                <div class="card w-100 mb-5">
                    <img src="https://picsum.photos/800/600" class="card-img-top" alt="">
                    <div class="card-body">
                        <h5 class="card-title">Lorem</h5>
                        <p class="card-text">"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>
                    </div>
                    <div class="card-footer">
                        <div class="mb-3">
                            <label class="lead">Comentarios</label>
                        </div>
                        <div class="comentarios">
                            <div class="comentario d-flex p-2 mb-2">
                                <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                <div class="contenido">
                                    <h6>Michi49</h6>
                                    <p class="">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                </div>
                            </div>
                            <div class="comentario d-flex p-2 mb-2">
                                <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                <div class="contenido">
                                    <h6>Doggy21</h6>
                                    <p class="">sed do eiusmod tempor incididunt ut labore.</p>
                                </div>
                            </div>
                        </div>
                        <div class="nuevo_comentario">
                            <form method="post">
                                <div class="row g-3">
                                    <div class="col-12 d-flex align-items-center">
                                        <img src="http://picsum.photos/60/60/" height="60" width="60" class="rounded-circle mr-3" />
                                        <textarea class="form-control" rows="2" cols="1" placeholder="Ingresa tu comentario"></textarea>
                                    </div>
                                    <div class="col-12 text-right">
                                        <button class="btn btn-primary">
                                            Comentar
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="card w-100 mb-5">
                    <img src="http://picsum.photos/800/600/" class="card-img-top" alt="">
                    <div class="card-body">
                        <h5 class="card-title">Lorem</h5>
                        <p class="card-text">"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>
                    </div>
                    <div class="card-footer">
                        <div class="mb-3">
                            <label class="lead">Comentarios</label>
                        </div>
                        <div class="comentarios">
                            <div class="comentario d-flex p-2 mb-2">
                                <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                <div class="contenido">
                                    <h6>Michi49</h6>
                                    <p class="">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                </div>
                            </div>
                            <div class="comentario d-flex p-2 mb-2">
                                <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                <div class="contenido">
                                    <h6>Doggy21</h6>
                                    <p class="">sed do eiusmod tempor incididunt ut labore.</p>
                                </div>
                            </div>
                        </div>
                        <div class="nuevo_comentario">
                            <form method="post">
                                <div class="row g-3">
                                    <div class="col-12 d-flex align-items-center">
                                        <img src="http://picsum.photos/60/60/" height="60" width="60" class="rounded-circle mr-3" />
                                        <textarea class="form-control" rows="2" cols="1" placeholder="Ingresa tu comentario"></textarea>
                                    </div>
                                    <div class="col-12 text-right">
                                        <button class="btn btn-primary">
                                            Comentar
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                -->
                
            </div>
            
            <div class="segundo encabezado d-none d-lg-block col-12 col-lg-4 position-fixed">
            </div>
            
        </div>
    </jsp:body>
    
</ndev:layout>