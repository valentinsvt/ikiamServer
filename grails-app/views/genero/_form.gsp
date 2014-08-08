<%@ page import="ikiam.Genero" %>



<div class="fieldcontain ${hasErrors(bean: generoInstance, field: 'nombre', 'error')} ">
	<label for="nombre">
		<g:message code="genero.nombre.label" default="Nombre" />
		
	</label>
	<g:textField name="nombre" maxlength="75" value="${generoInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: generoInstance, field: 'familia', 'error')} required">
	<label for="familia">
		<g:message code="genero.familia.label" default="Familia" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="familia" name="familia.id" from="${ikiam.Familia.list()}" optionKey="id" required="" value="${generoInstance?.familia?.id}" class="many-to-one"/>
</div>

