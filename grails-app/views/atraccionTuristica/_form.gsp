<%@ page import="ikiam.AtraccionTuristica" %>



<div class="fieldcontain ${hasErrors(bean: atraccionTuristicaInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="atraccionTuristica.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" maxlength="200" required="" value="${atraccionTuristicaInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: atraccionTuristicaInstance, field: 'url', 'error')} ">
	<label for="url">
		<g:message code="atraccionTuristica.url.label" default="Url" />
		
	</label>
	<g:textField name="url" maxlength="200" value="${atraccionTuristicaInstance?.url}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: atraccionTuristicaInstance, field: 'coordenada', 'error')} required">
	<label for="coordenada">
		<g:message code="atraccionTuristica.coordenada.label" default="Coordenada" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="coordenada" name="coordenada.id" from="${ikiam.Coordenada.list()}" optionKey="id" required="" value="${atraccionTuristicaInstance?.coordenada?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: atraccionTuristicaInstance, field: 'fecha', 'error')} required">
	<label for="fecha">
		<g:message code="atraccionTuristica.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fecha" precision="day"  value="${atraccionTuristicaInstance?.fecha}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: atraccionTuristicaInstance, field: 'likes', 'error')} required">
	<label for="likes">
		<g:message code="atraccionTuristica.likes.label" default="Likes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="likes" type="number" value="${atraccionTuristicaInstance.likes}" required=""/>
</div>

