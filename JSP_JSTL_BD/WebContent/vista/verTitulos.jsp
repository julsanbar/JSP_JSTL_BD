<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Titulos</title>
</head>
<body>

	<a href="${pageContext.request.contextPath}/vista/verTitulosSesion.jsp">Ver títulos en Sesión</a><br>

	<a href="${pageContext.request.contextPath}/vista/verTitulosBD.jsp">Ver títulos en la Base de datos</a><br>

	<a href="${pageContext.request.contextPath}/index.html">Volver al menú</a>

</body>
</html>