<%@ page import="ikiam.Coordenada" %>



<div class="fieldcontain ${hasErrors(bean: coordenadaInstance, field: 'ruta', 'error')} ">
	<label for="ruta">
		<g:message code="coordenada.ruta.label" default="Ruta" />
		
	</label>
	<g:select id="ruta" name="ruta.id" from="${ikiam.Ruta.list()}" optionKey="id" value="${coordenadaInstance?.ruta?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: coordenadaInstance, field: 'latitud', 'error')} required">
	<label for="latitud">
		<g:message code="coordenada.latitud.label" default="Latitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitud" value="${fieldValue(bean: coordenadaInstance, field: 'latitud')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: coordenadaInstance, field: 'longitud', 'error')} required">
	<label for="longitud">
		<g:message code="coordenada.longitud.label" default="Longitud" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitud" value="${fieldValue(bean: coordenadaInstance, field: 'longitud')}" required=""/>
</div>

