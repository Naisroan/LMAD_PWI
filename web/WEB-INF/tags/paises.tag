<%-- 
    Document   : paises
    Created on : Nov 18, 2020, 2:40:54 AM
    Author     : ianso
--%>

<%@tag description="Lista de paises" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>

<%@tag import="java.util.List"%>
<%@tag import="java.util.ArrayList"%>

<c:set var="getPaises">
    <%
        List<String> paises = new ArrayList();
        paises.add("México");
        paises.add("EUA");
        paises.add("Canada");
        paises.add("Japón");
        request.setAttribute("paises", paises);
    %>
</c:set>

<select class="form-select">
    <c:forEach items="${paises}" var="pais">
        <option>${pais}</option>
    </c:forEach>
</select>