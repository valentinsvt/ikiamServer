
<%@ page import="ikiam.AtraccionTuristica" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'atraccionTuristica.label', default: 'AtraccionTuristica')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-atraccionTuristica" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-atraccionTuristica" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list atraccionTuristica">
			
				<g:if test="${atraccionTuristicaInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="atraccionTuristica.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${atraccionTuristicaInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${atraccionTuristicaInstance?.url}">
				<li class="fieldcontain">
					<span id="url-label" class="property-label"><g:message code="atraccionTuristica.url.label" default="Url" /></span>
					
						<span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${atraccionTuristicaInstance}" field="url"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${atraccionTuristicaInstance?.coordenada}">
				<li class="fieldcontain">
					<span id="coordenada-label" class="property-label"><g:message code="atraccionTuristica.coordenada.label" default="Coordenada" /></span>
					
						<span class="property-value" aria-labelledby="coordenada-label"><g:link controller="coordenada" action="show" id="${atraccionTuristicaInstance?.coordenada?.id}">${atraccionTuristicaInstance?.coordenada?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${atraccionTuristicaInstance?.fecha}">
				<li class="fieldcontain">
					<span id="fecha-label" class="property-label"><g:message code="atraccionTuristica.fecha.label" default="Fecha" /></span>
					
						<span class="property-value" aria-labelledby="fecha-label"><g:formatDate date="${atraccionTuristicaInstance?.fecha}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${atraccionTuristicaInstance?.likes}">
				<li class="fieldcontain">
					<span id="likes-label" class="property-label"><g:message code="atraccionTuristica.likes.label" default="Likes" /></span>
					
						<span class="property-value" aria-labelledby="likes-label"><g:fieldValue bean="${atraccionTuristicaInstance}" field="likes"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:atraccionTuristicaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${atraccionTuristicaInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
