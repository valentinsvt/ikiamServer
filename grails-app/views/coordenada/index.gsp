
<%@ page import="ikiam.Coordenada" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'coordenada.label', default: 'Coordenada')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-coordenada" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-coordenada" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="coordenada.ruta.label" default="Ruta" /></th>
					
						<g:sortableColumn property="latitud" title="${message(code: 'coordenada.latitud.label', default: 'Latitud')}" />
					
						<g:sortableColumn property="longitud" title="${message(code: 'coordenada.longitud.label', default: 'Longitud')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${coordenadaInstanceList}" status="i" var="coordenadaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${coordenadaInstance.id}">${fieldValue(bean: coordenadaInstance, field: "ruta")}</g:link></td>
					
						<td>${fieldValue(bean: coordenadaInstance, field: "latitud")}</td>
					
						<td>${fieldValue(bean: coordenadaInstance, field: "longitud")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${coordenadaInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
