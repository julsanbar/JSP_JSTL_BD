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
<title>Ingredientes receta</title>
</head>
<body>
	<!-- Gestionamos la conexión de la base de datos, además de la insercción en la misma -->
	<!-- Capturamos mediante un catch las excepciones que pudieran surgir, y recogemos del formulario verReceta los parametros de este formulario -->
	<c:if test="${(param.guardarBD != null) || (not empty param.guardarBD)}">

		<c:catch var="exception">
		
			<sql:setDataSource var="conexion" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/recetario?autoReconnect=true&useSSL=false" user="usuario" password="usuario" scope="session"/>
		
			<sql:update dataSource="${conexion}" var="insertarReceta">
				
				INSERT INTO recetas (titulo,harina,cantidadHarina,liquidos,cantidadLevadura,cantidadAzucar,cantidadSal,preparacion) VALUES (?,?,?,?,?,?,?,?)
				
				<sql:param value="${param.tituloBD}"/>
				<sql:param value="${param.harinaBD}"/>
				<sql:param value="${param.cantidadHarinaBD}"/>
				<sql:param value="${param.liquidosBD}"/>
				<sql:param value="${param.levaduraBD}"/>
				<sql:param value="${param.azucarBD}"/>
				<sql:param value="${param.salBD}"/>
				<sql:param value="${param.preparacionBD}"/>
				
			</sql:update>
		
		</c:catch>
	
		<c:choose>
			
			<c:when test="${(insertarReceta >= 1) && (exception == null)}">
			
				<p style="color:green">La receta <c:out value="${param.tituloBD}"/> se guardo en la base de datos correctamente.</p>
			
			</c:when>
			<c:otherwise>
				
				<p style="color:red">Hubo un error y no se pudo realizar la insercción en la base de datos.</p>
				
			</c:otherwise>
		
		</c:choose>
	
	</c:if>

	<form action="${pageContext.request.contextPath}/vista/verReceta.jsp" method="post">
	
		<label for="titulo">Título de la receta:</label>
		<input type="text" name="titulo" id="titulo"/><br>

		<label for="harina">Tipos harina:</label>
		<select name="harina" id="harina">
		
			<!-- <option value="null" selected>---</option> -->
			<option value="trigo">trigo</option>
			<option value="trigo de fuerza">trigo de fuerza</option>
			<option value="espelta">espelta</option>
			<option value="espelta integral">espelta integral</option>
			<option value="centeno">centeno</option>
		
		</select>
		
		<input type="text" name="cantidadHarina" id="cantidadHarina" placeholder="Cantidad en gramos"/><br>
	
		<label for="agua">Agua</label>
		<input type="checkbox" name="liquidos" id="agua" value="agua"/>
		<input type="text" name="aguaMl" placeholder="ml"/><br>
		
		<label for="leche">Leche</label>
		<input type="checkbox" name="liquidos" id="leche" value="leche"/>
		<input type="text" name="lecheMl" placeholder="ml"/><br>
		
		<label for="aceite">Aceite</label>
		<input type="checkbox" name="liquidos" id="aceite" value="aceite"/>
		<input type="text" name="aceiteMl" placeholder="ml"/><br>
	
		<label for="levadura">Cantidad levadura</label>
		<input type="text" name="levadura" id="levadura" placeholder="gramos"/><br>

		<label for="azucar">Cantidad azúcar</label>
		<input type="text" name="azucar" id="azucar" placeholder="gramos"/><br>
		
		<label for="sal">Cantidad sal</label>
		<input type="text" name="sal" id="sal" placeholder="gramos"/><br>		
	
		<textarea rows="20" cols="40" name="preparacion" id="preparacion" placeholder="Indique la preparación"></textarea><br>
	
		<input type="submit" name="enviar" value="Enviar"/>
	
	</form><br>

	<a href="${pageContext.request.contextPath}/index.html">Volver al menú</a>

</body>
</html>