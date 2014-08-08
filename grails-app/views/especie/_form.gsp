<%@ page import="ikiam.Especie" %>



<div class="fieldcontain ${hasErrors(bean: especieInstance, field: 'nombre', 'error')} ">
	<label for="nombre">
		<g:message code="especie.nombre.label" default="Nombre" />
		
	</label>
	<g:textField name="nombre" maxlength="75" value="${especieInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: especieInstance, field: 'color1', 'error')} required">
	<label for="color1">
		<g:message code="especie.color1.label" default="Color1" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="color1" name="color1.id" from="${ikiam.Color.list()}" optionKey="id" required="" value="${especieInstance?.color1?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: especieInstance, field: 'color2', 'error')} required">
	<label for="color2">
		<g:message code="especie.color2.label" default="Color2" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="color2" name="color2.id" from="${ikiam.Color.list()}" optionKey="id" required="" value="${especieInstance?.color2?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: especieInstance, field: 'genero', 'error')} required">
	<label for="genero">
		<g:message code="especie.genero.label" default="Genero" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="genero" name="genero.id" from="${ikiam.Genero.list()}" optionKey="id" required="" value="${especieInstance?.genero?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: especieInstance, field: 'nombreComun', 'error')} ">
	<label for="nombreComun">
		<g:message code="especie.nombreComun.label" default="Nombre Comun" />
		
	</label>
	<g:textField name="nombreComun" value="${especieInstance?.nombreComun}"/>
</div>

