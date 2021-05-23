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
<title>Títulos en la Base de datos</title>
</head>
<body>
	
	<sql:setDataSource var="conexion" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/recetario?autoReconnect=true&useSSL=false" user="usuario" password="usuario" scope="session"/>
	
	<sql:query dataSource="${conexion}" var="datosBD">
		
		SELECT * FROM recetas
		
	</sql:query>
		
	<ul>

		<c:forEach var="tituloGBD" items="${datosBD.rows}">
			
			<li><c:out value="${tituloGBD.titulo}"/></li>
		
		</c:forEach>
	
	</ul>
	

	<a href="${pageContext.request.contextPath}/index.html">Volver al menú</a>

</body>
</html>