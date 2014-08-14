
<%@ page import="ikiam.AtraccionTuristica" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'atraccionTuristica.label', default: 'AtraccionTuristica')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-atraccionTuristica" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-atraccionTuristica" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nombre" title="${message(code: 'atraccionTuristica.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="url" title="${message(code: 'atraccionTuristica.url.label', default: 'Url')}" />
					
						<th><g:message code="atraccionTuristica.coordenada.label" default="Coordenada" /></th>
					
						<g:sortableColumn property="fecha" title="${message(code: 'atraccionTuristica.fecha.label', default: 'Fecha')}" />
					
						<g:sortableColumn property="likes" title="${message(code: 'atraccionTuristica.likes.label', default: 'Likes')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${atraccionTuristicaInstanceList}" status="i" var="atraccionTuristicaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${atraccionTuristicaInstance.id}">${fieldValue(bean: atraccionTuristicaInstance, field: "nombre")}</g:link></td>
					
						<td>${fieldValue(bean: atraccionTuristicaInstance, field: "url")}</td>
					
						<td>${fieldValue(bean: atraccionTuristicaInstance, field: "coordenada")}</td>
					
						<td><g:formatDate date="${atraccionTuristicaInstance.fecha}" /></td>
					
						<td>${fieldValue(bean: atraccionTuristicaInstance, field: "likes")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${atraccionTuristicaInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
