<%-- 
    Document   : notice
    Created on : Oct 12, 2020, 9:05:41 PM
    Author     : ianso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ndev" tagdir="/WEB-INF/tags" %>

<ndev:layout>
    
    <jsp:attribute name="titulo">
        Noticia
    </jsp:attribute>
    
    <jsp:attribute name="styles">
        <link href="../res/css/notice.css" type="text/css" rel="stylesheet" />
    </jsp:attribute>
    
    <jsp:attribute name="scripts">
    </jsp:attribute>
    
    <jsp:body>
        
        <!-- <i class="fas fa-heart fa-fw"></i> -->
        <div class="container px-0">
            <div class="row mt-5">
                <div class="col-12 text-center">
                    <h1>
                        Título de la Noticia
                    </h1>
                    <div class="categorias">
                        <span class="badge rounded-pill bg-secondary">Categoría #1</span>
                        <span class="badge rounded-pill bg-secondary">Categoría #2</span>
                        <span class="badge rounded-pill bg-secondary">Categoría #3</span>
                    </div>
                </div>
                <div class="d-flex flex-row justify-content-between align-items-center mb-4">
                    <div class="usuario">
                        <div class="d-flex align-items-center">
                            <img src="https://picsum.photos/60/60" height="60" width="60" class="rounded-circle mr-3" />
                            <div class="">
                                <h5 class="mb-1">autor</h5>
                            </div>
                        </div>
                    </div>
                    <div class="fecha">
                        <label class="m-0 text-muted">
                            12 de Octubre de 2020
                        </label>
                    </div>
                </div>
                <div class="col-12 mb-4"> 
                    <div class="text-muted mb-2">
                        <label>Panel Autor (se mostrará dependiendo el rol)</label>
                    </div>
                    <div>
                        <button class="btn btn-sm btn-secondary mr-2">Eliminar</button>
                        <button class="btn btn-sm btn-primary">Editar noticia</button>
                    </div>
                </div>
                <div class="col-12 mb-4"> 
                    <div class="text-muted mb-2">
                        <label>Panel regualador de noticias (se mostrará dependiendo el rol)</label>
                    </div>
                    <div>
                        <button class="btn btn-sm btn-secondary mr-2">Rechazar</button>
                        <button class="btn btn-sm btn-success">Aceptar noticia</button>
                    </div>
                </div>
                <div class="col-12 mb-4">
                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="https://picsum.photos/1920/800" class="d-block w-100" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="https://picsum.photos/1920/800" class="d-block w-100" alt="...">
                            </div>
                            <div class="carousel-item">
                                <img src="https://picsum.photos/1920/800" class="d-block w-100" alt="...">
                            </div>
                            <div class="carousel-item">
                                <div class="ratio ratio-16x9">
                                    <iframe src="https://www.youtube.com/embed/zpOULjyy-n8?rel=0" title="YouTube video" allowfullscreen></iframe>
                                </div>
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden"></span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden"></span>
                        </a>
                    </div>
                </div>
                <div class="col-12 mb-4">
                    <h2 class="">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vitae blandit neque.
                    </h2>
                </div>
                <div class="col-12 mb-4">
                    <p class="lead">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vitae blandit neque. Maecenas interdum fringilla dolor, at eleifend magna sagittis quis. Nulla arcu sapien, faucibus nec nisi non, consectetur elementum est. Vestibulum eget interdum ipsum. Sed dictum auctor nunc, in luctus ipsum tempus quis. Nulla rutrum turpis sed est rutrum feugiat.
                    </p>
                </div>
                <div class="col-12 mb-4">
                    <hr />
                </div>
                <div class="col-12 mb-4">
                    <h3 class="text-center">¿Qué te pareció la noticia?</h3>
                    <div class="stars text-center mb-4">
                        <span class="fas fa-star fa-2x checked"></span>
                        <span class="fas fa-star fa-2x checked"></span>
                        <span class="fas fa-star fa-2x checked"></span>
                        <span class="fas fa-star fa-2x"></span>
                        <span class="fas fa-star fa-2x"></span>
                    </div>
                    <h3 class="text-center">Marcar como favorita</h3>
                    <div class="text-center mb-3">
                        <i class="fas fa-heart fa-2x"></i>
                    </div>
                </div>
                <div class="col-12 mb-4">
                    <hr />
                </div>
                <div class="col-12 mb-4">
                    <div class="mb-3">
                        <label class="lead">Comentarios</label>
                    </div>
                    <div class="comentarios">
                        <div class="comentario mb-3 p-2">
                            <div class="d-flex">
                                <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                <div class="contenido w-100">
                                    <div class="usuario d-flex justify-content-between align-items-center">
                                        <h6>Michi49</h6>
                                        <i class="fas fa-trash"></i>
                                    </div>
                                    <p class="mb-2">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                </div>
                            </div>
                            <div class="footer ml-5 pl-2 mb-2">
                                <i class="fas fa-thumbs-up mr-3"></i>
                                <i class="fas fa-thumbs-down mr-3"></i>
                                <a href="#!">Responder a Michi49</a>
                            </div>
                            <div class="comentario mb-3 p-2">
                                <div class="d-flex">
                                    <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                    <div class="contenido w-100">
                                        <div class="usuario d-flex justify-content-between align-items-center">
                                            <h6>Pez31</h6>
                                            <i class="fas fa-trash"></i>
                                        </div>
                                        <p class="mb-2">@Michi49 consectetur adipiscing elit.</p>
                                    </div>
                                </div>
                                <div class="footer ml-5 pl-2 mb-2">
                                    <i class="fas fa-thumbs-up mr-3"></i>
                                    <i class="fas fa-thumbs-down mr-3"></i>
                                    <a href="#!">Responder a Pez31</a>
                                </div>
                            </div>
                        </div>
                        <div class="comentario mb-3 p-2">
                            <div class="d-flex">
                                <img src="http://picsum.photos/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                <div class="contenido w-100">
                                    <div class="usuario d-flex justify-content-between align-items-center">
                                        <h6>Doggy21</h6>
                                        <i class="fas fa-trash"></i>
                                    </div>
                                    <p class="mb-2">sed do eiusmod tempor incididunt ut labore.</p>
                                </div>
                            </div>
                            <div class="footer ml-5 pl-2 mb-2">
                                <i class="fas fa-thumbs-up mr-3"></i>
                                <i class="fas fa-thumbs-down mr-3"></i>
                                <a href="#!">Responder a Doggy21</a>
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
                <div class="col-12 mb-5">
                </div>
            </div>
        </div>
    </jsp:body>
        
</ndev:layout>