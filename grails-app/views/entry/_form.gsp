<%@ page import="ikiam.Entry" %>



<div class="fieldcontain ${hasErrors(bean: entryInstance, field: 'observaciones', 'error')} ">
	<label for="observaciones">
		<g:message code="entry.observaciones.label" default="Observaciones" />
		
	</label>
	<g:textArea name="observaciones" cols="40" rows="5" maxlength="255" value="${entryInstance?.observaciones}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: entryInstance, field: 'usuario', 'error')} ">
	<label for="usuario">
		<g:message code="entry.usuario.label" default="Usuario" />
		
	</label>
	<g:select id="usuario" name="usuario.id" from="${ikiam.Usuario.list()}" optionKey="id" value="${entryInstance?.usuario?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: entryInstance, field: 'especie', 'error')} required">
	<label for="especie">
		<g:message code="entry.especie.label" default="Especie" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="especie" name="especie.id" from="${ikiam.Especie.list()}" optionKey="id" required="" value="${entryInstance?.especie?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: entryInstance, field: 'fecha', 'error')} required">
	<label for="fecha">
		<g:message code="entry.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fecha" precision="day"  value="${entryInstance?.fecha}"  />
</div>

