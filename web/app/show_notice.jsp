<%-- 
    Document   : notice
    Created on : Oct 12, 2020, 9:05:41 PM
    Author     : ianso
--%>

<%@page import="DAO.ValoracionDAO"%>
<%@page import="Model.Comentario"%>
<%@page import="DAO.ComentarioDAO"%>
<%@page import="DAO.MultimediaDAO"%>
<%@page import="Model.Multimedia"%>
<%@page import="java.util.List"%>
<%@page import="DAO.RolDAO"%>
<%@page import="Model.Rol"%>
<%@page import="Model.Categorias"%>
<%@page import="DAO.CategoriasDAO"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="Model.Usuario"%>
<%@page import="DAO.NoticiaDAO"%>
<%@page import="DAO.NoticiaDAO"%>
<%@page import="Model.Noticia"%>
<%@page import="Class.App"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ndev" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

    String strId = request.getParameter("id");

    if (!App.isNumber(strId)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    Usuario usuarioAuth = App.AuthUser(request);
    
    if (usuarioAuth == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    Noticia noticia = NoticiaDAO.Read(strId);

    if (noticia == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
        
    String strIdNoticia = String.valueOf(noticia.getId_noticia());
    String strIdCategoria = String.valueOf(noticia.getId_categoria());
    String strIdUsuarioAutenticado = String.valueOf(usuarioAuth.getId_usuario());
    String strIdUsuarioAutor = String.valueOf(noticia.getId_usuario());
    
    Categorias categoria = CategoriasDAO.Read(strIdCategoria);
    Usuario usuarioAutor = UsuarioDAO.Read(strIdUsuarioAutor);
    Rol rol = RolDAO.ReadByUsuario(strIdUsuarioAutenticado);
    Boolean canSave = App.canSaveNoticia(request);
    
    List<Multimedia> multimedias = MultimediaDAO.ReadByIdNoticia(strIdNoticia);
    List<Comentario> comentarios = ComentarioDAO.ReadByNoticia(strIdNoticia);
    
    for (Comentario com : comentarios){
        
        String strIdComentario = String.valueOf(com.getId_comentario());
        String strIdComentarioPadre = String.valueOf(com.getId_comentario());
        
        com.setComentarios(ComentarioDAO.ReadByComentarioPadre(strIdComentarioPadre));
        com.setValoracion(ValoracionDAO.ReadByIdUsuarioIdComentario(strIdUsuarioAutenticado, strIdComentario));
    }
    
    request.setAttribute("usuario", usuarioAuth);
    request.setAttribute("noticia", noticia);
    request.setAttribute("usuarioAutor", usuarioAutor);
    request.setAttribute("rol", rol);
    request.setAttribute("categoria", categoria);
    request.setAttribute("multimedias", multimedias);
    request.setAttribute("comentarios", comentarios);
    request.setAttribute("canSave", canSave);
%>

<ndev:layout>
    
    <jsp:attribute name="titulo">
        <c:out value="${noticia.titulo}"></c:out>
    </jsp:attribute>
    
    <jsp:attribute name="styles">
        <link href="<c:url value='/res/css/notice.css'/>" type="text/css" rel="stylesheet" />
    </jsp:attribute>
    
    <jsp:attribute name="scripts">
        <script type="text/javascript" src="<c:url value='/res/js/noticia.js'/>"></script>
    </jsp:attribute>
    
    <jsp:body>
        
        <!-- <i class="fas fa-heart fa-fw"></i> -->
        <div class="container px-0">
            <div class="row mt-5">
                <div class="col-12 text-center">
                    <h1 class="text-primary">
                        <c:out value="${noticia.titulo}"></c:out>
                    </h1>
                </div>
                
                <div class="col-12 text-center mb-4">
                    <h3 class="">
                        <c:out value="${noticia.desc_corta}"></c:out>
                    </h3>
                    <div class="categorias">
                        <span class="badge rounded-pill bg-secondary"><c:out value="${categoria.nombre}"></c:out></span>
                    </div>
                </div>
                                
                <div class="col-12 mb-4">
                    
                    <c:choose>
                        <c:when test="${multimedias != null && multimedias.size() > 0}">
                            <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                                <ol class="carousel-indicators">
                                    <c:forEach items="${multimedias}" var="multimedia" varStatus="loop">
                                        <li data-target="#carouselExampleIndicators" data-slide-to="${loop.index}" class='${loop.index == 0 ? "active" : ""}'></li>
                                    </c:forEach>
                                </ol>
                                <div class="carousel-inner">
                                    <c:forEach items="${multimedias}" var="multimedia" varStatus="loop">
                                        <div class='carousel-item ${loop.index == 0 ? "active" : ""}'>
                                            <c:choose>
                                                <c:when test='${multimedia.tipo_contenido == "image/jpeg" || multimedia.tipo_contenido == "image/png"}'>
                                                    <img src="<c:url value="${multimedia.ruta}"></c:url>" class="img-fluid d-block w-100" alt="">
                                                </c:when>
                                                <c:when test='${multimedia.tipo_contenido == "video/mp4"}'>
                                                    <div class="ratio ratio-16x9">
                                                        <video controls>
                                                            <source src="<c:url value="${multimedia.ruta}"></c:url>" type="video/mp4">
                                                        </video>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:forEach>
                                </div>
                                <!--
                                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden"></span>
                                </a>
                                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden"></span>
                                </a>
                                -->
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-secondary" role="alert">
                                ¡No hay imágenes o vídeos adjuntados!
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                </div>
                    
                <div class="d-flex flex-row justify-content-between align-items-center mb-4">
                    <div class="usuario">
                        <div class="d-flex align-items-center">
                            <img src="<c:url value='${ usuarioAutor.ruta_imagen != null && !usuarioAutor.ruta_imagen.equals("") ? usuarioAutor.ruta_imagen : "https://picsum.photos/30/30"}'></c:url>" height="30" width="30" class="rounded-circle mr-3" />
                            <div class="">
                                <h5 class="mb-1">
                                    <c:out value="${usuarioAutor.nick}"></c:out>
                                    <small class="text-muted">Autor</small>
                                </h5>
                            </div>
                        </div>
                    </div>
                </div>
                                
                <c:if test="${rol.id_rol == 1 || rol.id_rol == 4 || rol.id_rol == 5 || rol.id_rol == 6 || usuario.id_usuario == noticia.id_usuario}">
                    <form method="post" action="${pageContext.request.contextPath}/noticia/aprobar" class="row g-3 mb-4">
                        <input type="hidden" name="id" value="<c:out value="${noticia.id_noticia}"></c:out>" class="invisible" />
                        <div class="h5 col-12">
                            <label>Panel de Aministración</label>
                        </div>
                        <c:if test="${MSG_SUCCESS != null}">
                            <div class="col-12">
                                <div class="alert alert-success alert-dismissible fade show text-left" role="alert">
                                    <strong>¡Éxito!</strong> <c:out value="${MSG_SUCCESS}"></c:out>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${MSG_ERROR != null}">
                            <div class="col-12">
                                <div class="alert alert-warning alert-dismissible fade show text-left" role="alert">
                                    <strong>¡Espera!</strong> <c:out value="${MSG_ERROR}"></c:out>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${rol.id_rol == 1 || usuario.id_usuario == noticia.id_usuario}">
                            <div class="col-12 col-lg-12">
                                <label class="form-label">Opciones principales</label>
                            </div>
                            <div class="col-12">
                                <a href="<c:url value="/app/notice_detail.jsp?id=${noticia.id_noticia}"></c:url>" class="btn btn-sm btn-primary mb-3">Editar noticia</a>
                            </div>
                        </c:if>
                        <c:if test="${rol.id_rol == 1 || rol.id_rol == 6 || usuario.id_usuario == noticia.id_usuario}">
                            <div class="col-12 col-lg-12">
                                <label class="form-label">Aprobar o Rechazar la noticia</label>
                            </div>
                            <c:choose>
                                <c:when test="${App.esNoticiaPendienteAprobar(noticia)}">
                                    <div class="col-12 col-lg-12">
                                        <span class="badge bg-warning text-dark">Aún no ha sido aprobada ni rechazada</span>
                                    </div>
                                </c:when>
                                <c:when test="${App.esNoticiaRechazada(noticia)}">
                                    <div class="col-12 col-lg-12">
                                        <span class="badge bg-danger">
                                           La noticia fue rechazada
                                        </span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-12 col-lg-12">
                                        <span class="badge bg-success">
                                           La noticia fue aprobada
                                        </span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="col-12 col-lg-12">
                                <textarea class="form-control" name="comentario_aprobacion" rows="3" placeholder="Comentarios del administrador o editor" <c:out value='${rol.id_rol == 1 || rol.id_rol == 6 ? "" : "readonly"}'></c:out>><c:out value="${noticia.comentario_aprobacion}"></c:out></textarea>
                            </div>
                            <c:if test="${rol.id_rol == 1 || rol.id_rol == 6}">
                                <div class="col-12 col-lg-12">
                                    <c:if test='${!App.esNoticiaAceptada(noticia)}'>
                                        <button name="btnAprobar" class="btn btn-sm btn-success">
                                            Aprobar noticia
                                        </button>
                                    </c:if>
                                    <c:if test='${App.esNoticiaAceptada(noticia) || App.esNoticiaPendienteAprobar(noticia)}'>
                                        <button name="btnRechazar" class="btn btn-sm btn-danger">
                                            Rechazar noticia
                                        </button>
                                    </c:if>
                                </div>
                            </c:if>
                        </c:if>
                    </form>
                </c:if>
                    
                <div class="col-12 mb-4">
                    <p class="lead">
                        <c:out value="${noticia.noticia}"></c:out>
                    </p>
                </div>
                <div class="col-12 mb-4">
                    <hr />
                </div>
                <c:if test="${usuario.id_rol != 2}">
                    <div class="col-12 mb-4">
                        <!--
                        <h3 class="text-center">¿Qué te pareció la noticia?</h3>
                        <div class="stars text-center mb-4">
                            <span class="fas fa-star fa-2x checked"></span>
                            <span class="fas fa-star fa-2x checked"></span>
                            <span class="fas fa-star fa-2x checked"></span>
                            <span class="fas fa-star fa-2x"></span>
                            <span class="fas fa-star fa-2x"></span>
                        </div>
                        -->
                        <h3 class="text-center">
                            ${App.esNoticiaFavorita(noticia, usuario) ? "Noticia favorita" : "Marcar como favorita"}
                        </h3>
                        <div class="favorita text-center mb-3">
                            <a  class='fas fa-heart fa-2x ${App.esNoticiaFavorita(noticia, usuario) ? "active" : ""}'
                                onclick='marcarNoticiaFavorita("${pageContext.request.contextPath}/noticia/favorito?id=${noticia.id_noticia}", ${!App.esNoticiaFavorita(noticia, usuario)});'
                            ></a>
                        </div>
                    </div>
                    <div class="col-12 mb-4">
                        <hr />
                    </div>
                </c:if>
                <div class="col-12 mb-4">
                    <form method="post" action="${pageContext.request.contextPath}/noticia/comentario">
                        <input type="hidden" name="id" value="<c:out value="${noticia.id_noticia}"></c:out>" class="invisible" />
                        <div class="mb-3">
                            <label class="lead">Comentarios</label>
                        </div>
                        <c:if test="${MSG_SUCCESS_COMENTARIO != null}">
                            <div class="alert alert-success alert-dismissible fade show text-left mb-3 mr-2" role="alert">
                                <strong>¡Éxito!</strong> <c:out value="${MSG_SUCCESS_COMENTARIO}"></c:out>
                            </div>
                        </c:if>
                        <c:if test="${MSG_ERROR_COMENTARIO != null}">
                            <div class="alert alert-warning alert-dismissible fade show text-left mb-3 mr-2" role="alert">
                                <strong>¡Espera!</strong> <c:out value="${MSG_ERROR_COMENTARIO}"></c:out>
                            </div>
                        </c:if>
                        <div class="comentarios">
                            <c:forEach items="${comentarios}" var="comentario">
                                <div class="comentario mb-3 p-2">
                                    <div class="d-flex">
                                        <img src="<c:url value='${ comentario.avatar != null && !comentario.avatar.equals("") ? comentario.avatar : "https://picsum.photos/40/40"}'></c:url>" height="40" width="40" class="rounded-circle mr-3" />
                                        <div class="contenido w-100">
                                            <div class="usuario d-flex justify-content-between align-items-center">
                                                <h6>${comentario.nick}</h6>
                                                <!--<i class="fas fa-trash"></i>-->
                                            </div>
                                            <p class="mb-2">${comentario.descripcion}</p>
                                        </div>
                                    </div>
                                    <div class="footer ml-5 pl-2 mb-2">
                                        
                                        <a  class='fas fa-thumbs-up mr-3 ${comentario.valoracion != null && comentario.valoracion.valoracion_comentario != null && comentario.valoracion.valoracion_comentario ? "active" : ""}'
                                            onclick='enviarLikeComentario("${pageContext.request.contextPath}/noticia/comentario/like?id=${noticia.id_noticia}&idComentario=${comentario.id_comentario}", true);'></a>
                                            
                                        <a  class='fas fa-thumbs-down mr-3 ${comentario.valoracion != null && comentario.valoracion.valoracion_comentario != null && !comentario.valoracion.valoracion_comentario ? "active" : ""}'
                                            onclick='enviarLikeComentario("${pageContext.request.contextPath}/noticia/comentario/like?id=${noticia.id_noticia}&idComentario=${comentario.id_comentario}", false);'></a>
                                    </div>
                                    <c:if test="${comentario.comentarios != null && comentario.comentarios.size() > 0}">
                                        <c:forEach items="${comentario.comentarios}" var="subcomentario">
                                            <div class="comentario mb-3 p-2">
                                                <div class="d-flex">
                                                    <img src="<c:url value='${ subcomentario.avatar != null && !subcomentario.avatar.equals("") ? subcomentario.avatar : "https://picsum.photos/40/40"}'></c:url>" height="40" width="40" class="rounded-circle mr-3" />
                                                    <div class="contenido w-100">
                                                        <div class="usuario d-flex justify-content-between align-items-center">
                                                            <h6>${subcomentario.nick}</h6>
                                                            <!--<i class="fas fa-trash"></i>-->
                                                        </div>
                                                        <p class="mb-2">
                                                            <strong class="text-primary">@${comentario.nick}</strong> ${subcomentario.descripcion}
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <div class="nuevo_sub_comentario">
                                        <div class="row g-3">
                                            <div class="input-group mb-3">
                                                <input id="nuevo_sub_comentario_${comentario.id_comentario}" type="text" class="form-control" name="nuevo_sub_comentario" placeholder="Responder a ${comentario.nick}">
                                                <button type="button" class="btn btn-secondary" 
                                                        onclick='enviarSubComentario("${pageContext.request.contextPath}/noticia/comentario?id=${noticia.id_noticia}&idComentarioPadre=${comentario.id_comentario}", ${comentario.id_comentario}, false);'>
                                                    <i class="fas fa-paper-plane fa-fw"></i>
                                                </button>
                                                <!--
                                                <a href="${pageContext.request.contextPath}/noticia/comentario?id=${noticia.id_noticia}&idComentarioPadre=${comentario.id_comentario}" class="btn btn-secondary" type="submit">
                                                    Responder
                                                </a>
                                                -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="nuevo_comentario">
                            <div class="row g-3">
                                <div class="col-12 d-flex align-items-center">
                                    <img src="<c:url value='${ usuario.ruta_imagen != null && !usuario.ruta_imagen.equals("") ? usuario.ruta_imagen : "https://picsum.photos/60/60"}'></c:url>" height="60" width="60" class="rounded-circle mr-3" />
                                    <textarea id="nuevo_comentario" class="form-control" rows="2" name="nuevo_comentario" cols="1" placeholder="Ingresa tu comentario"></textarea>
                                </div>
                                <div class="col-12 text-right">
                                    <button name="btnComentar" class="btn btn-primary" type="button"
                                        onclick='enviarSubComentario("${pageContext.request.contextPath}/noticia/comentario?id=${noticia.id_noticia}&idComentarioPadre=0", 0, true);'>
                                        Comentar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-12 mb-5">
                </div>
            </div>
        </div>
    </jsp:body>
        
</ndev:layout>