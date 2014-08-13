
<%@ page import="ikiam.Coordenada" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'coordenada.label', default: 'Coordenada')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-coordenada" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-coordenada" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list coordenada">
			
				<g:if test="${coordenadaInstance?.ruta}">
				<li class="fieldcontain">
					<span id="ruta-label" class="property-label"><g:message code="coordenada.ruta.label" default="Ruta" /></span>
					
						<span class="property-value" aria-labelledby="ruta-label"><g:link controller="ruta" action="show" id="${coordenadaInstance?.ruta?.id}">${coordenadaInstance?.ruta?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${coordenadaInstance?.latitud}">
				<li class="fieldcontain">
					<span id="latitud-label" class="property-label"><g:message code="coordenada.latitud.label" default="Latitud" /></span>
					
						<span class="property-value" aria-labelledby="latitud-label"><g:fieldValue bean="${coordenadaInstance}" field="latitud"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${coordenadaInstance?.longitud}">
				<li class="fieldcontain">
					<span id="longitud-label" class="property-label"><g:message code="coordenada.longitud.label" default="Longitud" /></span>
					
						<span class="property-value" aria-labelledby="longitud-label"><g:fieldValue bean="${coordenadaInstance}" field="longitud"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:coordenadaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${coordenadaInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
