<%@ page import="ikiam.Usuario" %>



<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="usuario.email.label" default="Email" />
		
	</label>
	<g:field type="email" name="email" value="${usuarioInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'password', 'error')} ">
	<label for="password">
		<g:message code="usuario.password.label" default="Password" />
		
	</label>
	<g:textArea name="password" cols="40" rows="5" maxlength="255" value="${usuarioInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'esAdmin', 'error')} ">
	<label for="esAdmin">
		<g:message code="usuario.esAdmin.label" default="Es Admin" />
		
	</label>
	<g:textField name="esAdmin" maxlength="1" value="${usuarioInstance?.esAdmin}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'esCientifico', 'error')} ">
	<label for="esCientifico">
		<g:message code="usuario.esCientifico.label" default="Es Cientifico" />
		
	</label>
	<g:textField name="esCientifico" maxlength="1" value="${usuarioInstance?.esCientifico}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="usuario.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" maxlength="100" required="" value="${usuarioInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'apellido', 'error')} required">
	<label for="apellido">
		<g:message code="usuario.apellido.label" default="Apellido" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellido" maxlength="100" required="" value="${usuarioInstance?.apellido}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'facebookId', 'error')} ">
	<label for="facebookId">
		<g:message code="usuario.facebookId.label" default="Facebook Id" />
		
	</label>
	<g:textField name="facebookId" maxlength="30" value="${usuarioInstance?.facebookId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'tipo', 'error')} ">
	<label for="tipo">
		<g:message code="usuario.tipo.label" default="Tipo" />
		
	</label>
	<g:textField name="tipo" maxlength="10" value="${usuarioInstance?.tipo}"/>
</div>

