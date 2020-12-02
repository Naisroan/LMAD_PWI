<%-- 
    Document   : categorias
    Created on : Nov 28, 2020, 11:27:27 PM
    Author     : ianso
--%>

<%@tag import="DAO.CategoriasDAO"%>
<%@tag description="Lista de categorias" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>

<%@tag import="java.util.List"%>
<%@tag import="java.util.ArrayList"%>

<%@attribute name="categoria_seleccionada" %>

<c:set var="getCategorias">
    <%
        List<String> nodos = CategoriasDAO.ReadAll();
        request.setAttribute("categorias", nodos);
    %>
</c:set>

<select class="form-select form-select-lg" name="nodo_categoria">
    <c:forEach items="${categorias}" var="categoria">
        <option
            value="${categoria.id_categoria}"
            <c:if test="${categoria_seleccionada == categoria.id_categoria}">
                selected
            </c:if>
        >
            ${categoria.nombre}
        </option>
    </c:forEach>
</select>