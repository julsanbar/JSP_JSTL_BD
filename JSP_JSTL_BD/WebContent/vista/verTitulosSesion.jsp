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
<title>Títulos en Sesión</title>
</head>
<body>

	<ul>
		
		<c:forEach var="titulo" items="${fn:split(listaTituloReceta,'|')}">
		
			<li><c:out value="${titulo}"/></li>
		
		</c:forEach>
	
	</ul><br>

	<a href="${pageContext.request.contextPath}/index.html">Volver al menú</a>

</body>
</html>