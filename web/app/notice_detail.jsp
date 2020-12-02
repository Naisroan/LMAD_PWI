<%-- 
    Document   : notice_detail
    Created on : Oct 12, 2020, 10:51:17 PM
    Author     : ianso
--%>

<%@page import="DAO.MultimediaDAO"%>
<%@page import="Model.Multimedia"%>
<%@page import="java.util.List"%>
<%@page import="Model.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Class.App"%>
<%@page import="DAO.NoticiaDAO"%>
<%@page import="Model.Noticia"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="ndev" tagdir="/WEB-INF/tags" %>

<%
    
    String strId = request.getParameter("id");
    Noticia noticia = null;
    List<Multimedia> multimedias = null;
    
    if (!App.canSaveNoticia(request)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    if (App.isNumber(strId)) {
        
        noticia = NoticiaDAO.Read(strId);
        
        if (noticia != null) {
            multimedias = MultimediaDAO.ReadByIdNoticia(String.valueOf(noticia.getId_noticia()));
        }
        
        request.setAttribute("noticia", noticia);
        request.setAttribute("multimedias", multimedias);
    }
    
%>

<c:set var="titulo_noticia">
    <%=
        noticia == null ? "Agregar Noticia" : "Editar [" + noticia.getTitulo() + "]"
    %>
</c:set>

<ndev:layout>
    
    <jsp:attribute name="titulo">
        <c:out value="${titulo_noticia}" />
    </jsp:attribute>
    
    <jsp:attribute name="styles">
    </jsp:attribute>
    
    <jsp:attribute name="scripts">
    </jsp:attribute>
    
    <jsp:body>
        <div class="container px-0 mt-5">
            <form action="${pageContext.request.contextPath}/noticia/save" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-12 col-lg-9">
                        <div class="row g-3">
                            <div class="col-12 mb-3">
                                <h4 class="text-primary">
                                    <c:out value="${titulo_noticia}" />
                                </h4>
                            </div>
                            <input type="hidden" name="id" value="<c:out value="${noticia.id_noticia}"></c:out>" class="invisible" />
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Título de la Noticia
                                </h5>
                                <input type="text" name="nodo_titulo" value="<c:out value="${noticia.titulo}"></c:out>" class="form-control form-control-lg" placeholder="Ingrese el título de la noticia" />
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Categoría
                                </h5>
                                <ndev:categorias>
                                    <jsp:attribute name="categoria_seleccionada">
                                        <c:out value="${noticia.id_categoria}" />
                                    </jsp:attribute>
                                </ndev:categorias>
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Descripción
                                </h5>
                                <textarea name="nodo_descripcion" class="form-control form-control-lg" placeholder="Descripción corta de la noticia"><c:out value="${noticia.desc_corta}"></c:out></textarea>
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Noticia
                                </h5>
                                <textarea name="nodo_noticia" rows="8" class="form-control form-control-lg" placeholder="Describe la noticia"><c:out value="${noticia.noticia}"></c:out></textarea>
                            </div>
                            <c:choose>
                                <c:when test="${noticia != null}">
                                    <div class="col-12 mb-3">
                                        <h5>                            
                                            Adjuntar multimedia
                                        </h5>
                                        <div class="input-group input-group-lg">
                                            <input id="fuMultimedia" name="fuMultimedia" type="file" class="form-control form-control-lg" accept="image/x-png,image/jpeg,video/mp4" />
                                            <button id="btnSubir" name="btnSubir" class="btn btn-secondary btn-lg" type="submit">
                                                Subir
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <label class="form-label">Lista de archivos multimedia</label>
                                        <div class="row multimedias" data-masonry='{"percentPosition": true }'>
                                            <c:choose>
                                                <c:when test="${multimedias != null && multimedias.size() > 0}">
                                                    <c:forEach items="${multimedias}" var="multimedia">
                                                        <div class="col-12 col-lg-6">
                                                            <div class="card">  
                                                                <c:choose>
                                                                    <c:when test='${multimedia.tipo_contenido == "image/jpeg" || multimedia.tipo_contenido == "image/png"}'>
                                                                        <img src="<c:url value="${multimedia.ruta}"></c:url>" class="img-fluid" alt="">
                                                                    </c:when>
                                                                    <c:when test='${multimedia.tipo_contenido == "video/mp4"}'>
                                                                        <div class="ratio ratio-16x9">
                                                                            <video controls>
                                                                                <source src="<c:url value="${multimedia.ruta}"></c:url>" type="video/mp4">
                                                                            </video>
                                                                            <!--<iframe src="" title="NoticiaVideo" autoplay="false" autostart="false"></iframe>-->
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="alert alert-secondary" role="alert">
                                                        ¡No hay imágenes o vídeos adjuntados!
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <small class="text-muted">Agregue imagenes o videos al crear la noticia...</small>
                                </c:otherwise>  
                            </c:choose>
                            <c:if test="${images_videos_visibility}">
                            </c:if>
                        </div>
                    </div>
                    <div class="col-12 col-lg-3">
                        <div class="row g-3">
                            <div class="col-12 mb-3">
                                <h4 class="text-primary">Acciones</h4>
                            </div>
                            <div class="col-12 text-right mb-3">
                                <button id="btnGuardar" name="btnGuardar" class="btn btn-lg btn-primary btn-block mb-3" type="submit">
                                    <i class="fas fa-save fa-fw mr-2"></i>
                                    Guardar
                                </button>
                                <c:if test="${noticia != null}">
                                    <button id="btnEliminar" name="btnEliminar" class="btn btn-lg btn-secondary btn-block mb-3" type="submit" onclick="return confirm('¿Está seguro de borrar?')">
                                        <i class="fas fa-trash fa-fw mr-2"></i>
                                        Eliminar
                                    </button>
                                    <a href="<c:url value="/app/show_notice.jsp?id=${noticia.id_noticia}"></c:url>" class="btn btn-lg btn-secondary btn-block mb-3">
                                        <i class="fas fa-eye fa-fw mr-2"></i>
                                        Ver noticia
                                    </a>
                                </c:if>
                                <c:if test="${MSG_SUCCESS != null}">
                                    <div class="mb-3">
                                        <div class="alert alert-success alert-dismissible fade show text-left" role="alert">
                                            <strong>¡Éxito!</strong> <c:out value="${MSG_SUCCESS}"></c:out>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${MSG_ERROR != null}">
                                    <div class="mb-3">
                                        <div class="alert alert-warning alert-dismissible fade show text-left" role="alert">
                                            <strong>¡Espera!</strong> <c:out value="${MSG_ERROR}"></c:out>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </jsp:body>
        
</ndev:layout>
