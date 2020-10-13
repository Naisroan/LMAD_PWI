<%-- 
    Document   : notice_detail
    Created on : Oct 12, 2020, 10:51:17 PM
    Author     : ianso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="ndev" tagdir="/WEB-INF/tags" %>

<ndev:layout>
    
    <jsp:attribute name="titulo">
        Agregar/Editar Noticia
    </jsp:attribute>
    
    <jsp:attribute name="styles">
    </jsp:attribute>
    
    <jsp:attribute name="scripts">
    </jsp:attribute>
    
    <jsp:body>
        <div class="container px-0 mt-5">
            <form>
                <div class="row">
                    <div class="col-12 col-lg-9">
                        <div class="row g-3">
                            <div class="col-12 mb-3">
                                <h4 class="text-primary">Agregar/Editar Noticia</h4>
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Título de la Noticia
                                </h5>
                                <input type="text" class="form-control form-control-lg" placeholder="Ingrese el título de la noticia" />
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Descripción
                                </h5>
                                <textarea class="form-control form-control-lg" placeholder="Descripción corta de la noticia"></textarea>
                            </div>
                            <div class="col-12 mb-3">
                                <h5>                            
                                    Categoría
                                </h5>
                                <div class="input-group">
                                    <select class="form-select form-select-lg">
                                       <option>Seleccione...</option>
                                       <option>Videojuegos</option>
                                       <option>Consolas</option>
                                       <option>Empresa</option
                                       <option>Desarrolladora</option>
                                       <option>Vacantes</option>
                                   </select>
                                   <button class="btn btn-outline-secondary" type="button">Agregar</button>
                                </div>
                            </div>
                            <div class="col-12 mb-3">
                                <label class="form-label">Categorías seleccionadas</label>
                                <div class="categorias">
                                    <span class="badge rounded-pill bg-secondary font-weight-normal">
                                        Categoría #1
                                        <i class="fas fa-trash fa-fw"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="col-12 col-lg-6 text-center mb-3">
                                <div class="mb-3">
                                    <label class="form-label">Adjunte imagenes...</label>
                                </div>
                                <div class="mb-3">
                                    <i class="fas fa-images fa-3x"></i>
                                </div>
                                <button class="btn btn-lg btn-secondary">Seleccionar Imagenes</button>
                            </div>
                            <div class="col-12 col-lg-6 text-center mb-3">
                                <div class="mb-3">
                                    <label class="form-label">Adjunte videos...</label>
                                </div>
                                <div class="mb-3">
                                    <i class="fas fa-film fa-3x"></i>
                                </div>
                                <button class="btn btn-lg btn-secondary">Seleccionar Vídeos</button>
                            </div>
                            <div class="col-12 col-lg-6 text-center mb-3">
                                <label class="form-label">Imágenes adjuntadas</label>
                                <div class="imagenes">
                                </div>
                            </div>
                            <div class="col-12 col-lg-6 text-center mb-3">
                                <label class="form-label">Vídeos adjuntados</label>
                                <div class="imagenes">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-3">
                        <div class="row g-3">
                            <div class="col-12 mb-3">
                                <h4 class="text-primary">Acciones</h4>
                            </div>
                            <div class="col-12 text-right mb-3">
                                <button class="btn btn-lg btn-primary btn-block">
                                    <i class="fas fa-save fa-fw mr-2"></i>
                                    Guardar
                                </button>
                                <button class="btn btn-lg btn-secondary btn-block">
                                    <i class="fas fa-trash fa-fw mr-2"></i>
                                    Eliminar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </jsp:body>
        
</ndev:layout>
