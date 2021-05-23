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
<title>Receta</title>
</head>
<body>
	
	<!-- Verificación del encondig -->
	<fmt:requestEncoding value="UTF-8"/>

	<!-- Recogemos los valores de los parámetros del formulario -->
	<!-- Nos creamos una lista de titulos cuyo ámbito es de sesión, para poder trabajar con ella en verTitulosSesion -->
	<c:set var="tituloReceta" value="${param.titulo}"/>
	<c:set var="listaTituloReceta" value="${(empty listaTituloReceta) || (listaTituloReceta == null) ? tituloReceta : listaTituloReceta.concat('|').concat(tituloReceta)}" scope="session"/>
	
	<c:set var="harinaReceta" value="${param.harina}"/>
	<c:set var="cantidadharinaReceta" value="${param.cantidadHarina}"/>
	<c:set var="levaduraReceta" value="${param.levadura}"/>
	<c:set var="azucarReceta" value="${param.azucar}"/>
	<c:set var="salReceta" value="${param.sal}"/>
	<c:set var="preparacionReceta" value="${param.preparacion}"/>
	
	<!-- Debido a que podemos seleccionar más de un checkbox es necesario recogerlo de diferente manera
	que los demás, pues PARAM solo devuelve el primer valor pero por el contrario con PARAMVALUES se recoge
	un array con los valores pasados, exactamente igual que con un scriptler -->
	<!-- Primero concatenamos todos los valores con un token estándar | , dicha concatenación se guardará en la
	BBDD. Ahora bien siempre deberemos de realizar un split si queremos iterarlo. Por el contrario con FORTOKENS
	Se podría recorrer token por token -->
	<c:forEach var="liquidoSeleccionado" items="${paramValues.liquidos}">
		<!-- Variable guardada en la BBDD -->
		<c:set var="liquidosReceta" value="${(empty liquidosReceta) || (liquidosReceta == null) ? liquidoSeleccionado : liquidosReceta.concat('|').concat(liquidoSeleccionado)}"/>
	</c:forEach>
	
	<!-- Verificamos que la cantidad de líquido indicado en ml corresponde con la casilla seleccionada. Si es incorrecto no se guarda dicho valor -->
	<!-- Concatenamos un espacio en blanco entre las cantidades y el tipo de liquido por si en un futuro se necesitara trabajar con ello -->
	<c:forEach var="liquidoCantidad" items="${fn:split(liquidosReceta,'|')}">
		
		<c:if test="${liquidoCantidad == 'agua'}">
			<c:set var="cantidadesLiquidos" value="${(empty cantidadesLiquidos) || (cantidadesLiquidos == null) ? 'Agua'.concat(' ').concat(param.aguaMl) : cantidadesLiquidos.concat('|').concat('Agua').concat(' ').concat(param.aguaMl)}"/>	
		</c:if>

		<c:if test="${liquidoCantidad == 'aceite'}">
			<c:set var="cantidadesLiquidos" value="${(empty cantidadesLiquidos) || (cantidadesLiquidos == null) ? 'Aceite'.concat(' ').concat(param.aceiteMl) : cantidadesLiquidos.concat('|').concat('Aceite').concat(' ').concat(param.aceiteMl)}"/>		
		</c:if>
		
		<c:if test="${liquidoCantidad == 'leche'}">
			<c:set var="cantidadesLiquidos" value="${(empty cantidadesLiquidos) || (cantidadesLiquidos == null) ? 'Leche'.concat(' ').concat(param.lecheMl) : cantidadesLiquidos.concat('|').concat('Leche').concat(' ').concat(param.lecheMl)}"/>
		</c:if>
		
	</c:forEach>
	
	<!-- Con el siguiente bucle podemos saber cuantos líquidos fueron seleccionados -->
	<c:set var="contador" value="${0}"/>
	<c:forTokens items="${liquidosReceta}" delims="|">
		<c:set var="contador" value="${contador+1}" />
	</c:forTokens>
	
	<table border="1">
		
		<tr>
			<th>Título</th>
			<th>Tipo harina</th>
			<th>Cantidad harina (gr)</th>
		<!-- Debido a que el número de líquidos es relativo es mejor indicar cuantos líquidos se han seleccionado -->
			<th colspan="${contador}" >Líquidos (ml)</th>
			<th>Cantidad levadura (gr)</th>
			<th>Cantidad azúcar (gr)</th>
			<th>Cantidad sal (gr)</th>
			<th>Preparación</th>
		</tr>
	
		<tr>
			
			<td><c:out value="${tituloReceta}"/></td>
			<td><c:out value="${harinaReceta}"/></td>
			<td><c:out value="${cantidadharinaReceta}"/>gr</td>
			
			<c:forEach var="cantidadLiquidoMuestra" items="${fn:split(cantidadesLiquidos,'|')}">

				<td><c:out value="${cantidadLiquidoMuestra}"/>ml</td>			
			
			</c:forEach>
			
			<td><c:out value="${levaduraReceta}"/>gr</td>
			<td><c:out value="${azucarReceta}"/>gr</td>
			<td><c:out value="${salReceta}"/>gr</td>
			<td><c:out value="${preparacionReceta}"/></td>			
		
		</tr>
	

	</table><br>

	<a href="${pageContext.request.contextPath}/index.html">Volver al menú</a><br>
	
	<!-- Llevamos los parametros mediante un formulario para insertarlos correctamente en la base de datos -->
	<form action="${pageContext.request.contextPath}/vista/formuIngredientes.jsp" method="post">
		
		<input type="hidden" name="tituloBD" value="${tituloReceta}"/>
		<input type="hidden" name="harinaBD" value="${harinaReceta}"/>
		<input type="hidden" name="cantidadHarinaBD" value="${cantidadharinaReceta}"/>
		<input type="hidden" name="liquidosBD" value="${cantidadesLiquidos}"/>
		<input type="hidden" name="levaduraBD" value="${levaduraReceta}"/>
		<input type="hidden" name="azucarBD" value="${azucarReceta}"/>
		<input type="hidden" name="salBD" value="${salReceta}"/>
		<input type="hidden" name="preparacionBD" value="${preparacionReceta}"/>
		
		<input type="submit" value="Guardar en la base de datos" name="guardarBD"/>
	</form>
	
</body>
</html>