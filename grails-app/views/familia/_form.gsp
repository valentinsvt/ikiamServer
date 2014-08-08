<%@ page import="ikiam.Familia" %>



<div class="fieldcontain ${hasErrors(bean: familiaInstance, field: 'nombre', 'error')} ">
	<label for="nombre">
		<g:message code="familia.nombre.label" default="Nombre" />
		
	</label>
	<g:textField name="nombre" maxlength="75" value="${familiaInstance?.nombre}"/>
</div>

