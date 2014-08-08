<%@ page import="ikiam.Color" %>



<div class="fieldcontain ${hasErrors(bean: colorInstance, field: 'color', 'error')} ">
	<label for="color">
		<g:message code="color.color.label" default="Color" />
		
	</label>
	<g:textField name="color" maxlength="20" value="${colorInstance?.color}"/>
</div>

