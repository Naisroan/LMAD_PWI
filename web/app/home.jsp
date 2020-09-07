<%-- 
    Document   : home
    Created on : Sep 6, 2020, 7:03:40 PM
    Author     : ianso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ndev" tagdir="/WEB-INF/tags" %>

<ndev:layout>
    
    <jsp:attribute name="titulo">
        Inicio
    </jsp:attribute>
    
    <jsp:attribute name="styles">
    </jsp:attribute>
    
    <jsp:attribute name="scripts">
    </jsp:attribute>
    
    <jsp:body>
        <div class="row mt-5">
            
            <div class="d-none d-lg-block col-12 col-lg-4 sticky-top">
                <div class="encabezado">
                    <div class="d-flex align-items-center">
                        <img src="http://lorempixel.com/60/60/" height="60" width="60" class="rounded-circle mr-3" />
                        <div class="">
                            <h5 class="mb-1">naisroan</h5>
                            <small class="text-muted">Creador de contenidos</small>
                        </div>
                    </div>
                    <hr />
                </div>
            </div>
            
            <div class="col-12 col-lg-8">
                
                <div class="post_nuevo mb-5">
                    <form method="post">
                        <div class="row g-3">
                            <div class="col-12 d-flex align-items-center">
                                <img src="http://lorempixel.com/60/60/" height="60" width="60" class="rounded-circle mr-3" />
                                <textarea class="form-control" rows="2" cols="1" placeholder="Crea una nueva noticia"></textarea>
                            </div>
                            <div class="col-12 text-right">
                                <button class="btn btn-secondary">
                                    <i class="fas fa-images fa-fw"></i>
                                </button>
                                <button class="btn btn-primary">
                                    Publicar
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                
                <div class="card w-100 mb-5">
                    <img src="http://lorempixel.com/800/600/" class="card-img-top" alt="">
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
                                <img src="http://lorempixel.com/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                <div class="contenido">
                                    <h6>Michi49</h6>
                                    <p class="">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                </div>
                            </div>
                            <div class="comentario d-flex p-2 mb-2">
                                <img src="http://lorempixel.com/60/60/" height="40" width="40" class="rounded-circle mr-3" />
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
                                        <img src="http://lorempixel.com/60/60/" height="60" width="60" class="rounded-circle mr-3" />
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
                    <img src="http://lorempixel.com/800/600/" class="card-img-top" alt="">
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
                                <img src="http://lorempixel.com/60/60/" height="40" width="40" class="rounded-circle mr-3" />
                                <div class="contenido">
                                    <h6>Michi49</h6>
                                    <p class="">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                </div>
                            </div>
                            <div class="comentario d-flex p-2 mb-2">
                                <img src="http://lorempixel.com/60/60/" height="40" width="40" class="rounded-circle mr-3" />
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
                                        <img src="http://lorempixel.com/60/60/" height="60" width="60" class="rounded-circle mr-3" />
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
                
            </div>
            
        </div>
    </jsp:body>
    
</ndev:layout>