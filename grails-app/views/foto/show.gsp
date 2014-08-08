
<%@ page import="ikiam.Foto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'foto.label', default: 'Foto')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-foto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-foto" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list foto">
			
				<g:if test="${fotoInstance?.path}">
				<li class="fieldcontain">
					<span id="path-label" class="property-label"><g:message code="foto.path.label" default="Path" /></span>
					
						<span class="property-value" aria-labelledby="path-label"><g:fieldValue bean="${fotoInstance}" field="path"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="foto.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:link controller="usuario" action="show" id="${fotoInstance?.usuario?.id}">${fotoInstance?.usuario?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoInstance?.coordenada}">
				<li class="fieldcontain">
					<span id="coordenada-label" class="property-label"><g:message code="foto.coordenada.label" default="Coordenada" /></span>
					
						<span class="property-value" aria-labelledby="coordenada-label"><g:link controller="coordenada" action="show" id="${fotoInstance?.coordenada?.id}">${fotoInstance?.coordenada?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoInstance?.keyWords}">
				<li class="fieldcontain">
					<span id="keyWords-label" class="property-label"><g:message code="foto.keyWords.label" default="Key Words" /></span>
					
						<span class="property-value" aria-labelledby="keyWords-label"><g:fieldValue bean="${fotoInstance}" field="keyWords"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoInstance?.entry}">
				<li class="fieldcontain">
					<span id="entry-label" class="property-label"><g:message code="foto.entry.label" default="Entry" /></span>
					
						<span class="property-value" aria-labelledby="entry-label"><g:link controller="entry" action="show" id="${fotoInstance?.entry?.id}">${fotoInstance?.entry?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoInstance?.especie}">
				<li class="fieldcontain">
					<span id="especie-label" class="property-label"><g:message code="foto.especie.label" default="Especie" /></span>
					
						<span class="property-value" aria-labelledby="especie-label"><g:link controller="especie" action="show" id="${fotoInstance?.especie?.id}">${fotoInstance?.especie?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoInstance?.likes}">
				<li class="fieldcontain">
					<span id="likes-label" class="property-label"><g:message code="foto.likes.label" default="Likes" /></span>
					
						<span class="property-value" aria-labelledby="likes-label"><g:fieldValue bean="${fotoInstance}" field="likes"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:fotoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${fotoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
