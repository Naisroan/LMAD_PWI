<%-- 
    Document   : search
    Created on : Oct 12, 2020, 11:33:01 PM
    Author     : ianso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ndev" tagdir="/WEB-INF/tags" %>

<ndev:layout>
    
    <jsp:attribute name="titulo">
        Buscador
    </jsp:attribute>
    
    <jsp:attribute name="styles">
    </jsp:attribute>
    
    <jsp:attribute name="scripts">
    </jsp:attribute>
    
    <jsp:body>
        <div class="container px-0 mt-5">
            <div class="row">
                <div class="col-12 col-lg-3">
                    <form>
                        <div class="row g-3">
                            <div class="col-12 mb-3">
                                <h5>Filtros</h5>
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Título de la Noticia
                                </h5>
                                <input type="text" class="form-control form-control-lg" placeholder="Ingrese el título de la noticia" />
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Autor
                                </h5>
                                <input type="text" class="form-control form-control-lg" placeholder="Ingrese el autor" />
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Descripción
                                </h5>
                                <textarea class="form-control form-control-lg" placeholder="Ingrese la descripción"></textarea>
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Categoría
                                </h5>
                                <select class="form-select form-select-lg">
                                   <option>Seleccione...</option>
                                   <option>Videojuegos</option>
                                   <option>Consolas</option>
                                   <option>Empresa</option
                                   <option>Desarrolladora</option>
                                   <option>Vacantes</option>
                               </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-12 col-lg-9">
                    <form>
                        <div class="row g-3">
                            <div class="col-12 mb-3">
                                <h5>Resultados...</h5>
                            </div>
                            <div class="resultados col-12 mb-3">
                                <div class="row row-cols-1 row-cols-md-3 g-4">
                                    <div class="col">
                                        <div class="card h-100">
                                            <img src="http://picsum.photos/310/220/" class="card-img-top" alt="...">
                                            <div class="card-body">
                                                <h5 class="card-title">Titulo noticia</h5>
                                                <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                            </div>
                                            <div class="card-footer">
                                                <small class="text-muted">12 de Octubre de 2020</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="card h-100">
                                            <img src="http://picsum.photos/310/220/" class="card-img-top" alt="...">
                                            <div class="card-body">
                                                <h5 class="card-title">Titulo noticia</h5>
                                                <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                            </div>
                                            <div class="card-footer">
                                                <small class="text-muted">12 de Octubre de 2020</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="card h-100">
                                            <img src="http://picsum.photos/310/220/" class="card-img-top" alt="...">
                                            <div class="card-body">
                                                <h5 class="card-title">Titulo noticia</h5>
                                                <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                            </div>
                                            <div class="card-footer">
                                                <small class="text-muted">12 de Octubre de 2020</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="card h-100">
                                            <img src="http://picsum.photos/310/220/" class="card-img-top" alt="...">
                                            <div class="card-body">
                                                <h5 class="card-title">Titulo noticia</h5>
                                                <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                            </div>
                                            <div class="card-footer">
                                                <small class="text-muted">12 de Octubre de 2020</small>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="card h-100">
                                            <img src="http://picsum.photos/310/220/" class="card-img-top" alt="...">
                                            <div class="card-body">
                                                <h5 class="card-title">Titulo noticia</h5>
                                                <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                                            </div>
                                            <div class="card-footer">
                                                <small class="text-muted">12 de Octubre de 2020</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </jsp:body>
        
</ndev:layout>