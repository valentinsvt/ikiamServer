<%@ page import="ikiam.Foto" %>



<div class="fieldcontain ${hasErrors(bean: fotoInstance, field: 'path', 'error')} ">
	<label for="path">
		<g:message code="foto.path.label" default="Path" />
		
	</label>
	<g:textArea name="path" cols="40" rows="5" maxlength="255" value="${fotoInstance?.path}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fotoInstance, field: 'usuario', 'error')} ">
	<label for="usuario">
		<g:message code="foto.usuario.label" default="Usuario" />
		
	</label>
	<g:select id="usuario" name="usuario.id" from="${ikiam.Usuario.list()}" optionKey="id" value="${fotoInstance?.usuario?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fotoInstance, field: 'coordenada', 'error')} ">
	<label for="coordenada">
		<g:message code="foto.coordenada.label" default="Coordenada" />
		
	</label>
	<g:select id="coordenada" name="coordenada.id" from="${ikiam.Coordenada.list()}" optionKey="id" value="${fotoInstance?.coordenada?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fotoInstance, field: 'keyWords', 'error')} ">
	<label for="keyWords">
		<g:message code="foto.keyWords.label" default="Key Words" />
		
	</label>
	<g:textField name="keyWords" maxlength="100" value="${fotoInstance?.keyWords}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fotoInstance, field: 'atraccion', 'error')} ">
	<label for="atraccion">
		<g:message code="foto.atraccion.label" default="Atraccion" />
		
	</label>
	<g:select id="atraccion" name="atraccion.id" from="${ikiam.AtraccionTuristica.list()}" optionKey="id" value="${fotoInstance?.atraccion?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fotoInstance, field: 'entry', 'error')} ">
	<label for="entry">
		<g:message code="foto.entry.label" default="Entry" />
		
	</label>
	<g:select id="entry" name="entry.id" from="${ikiam.Entry.list()}" optionKey="id" value="${fotoInstance?.entry?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fotoInstance, field: 'especie', 'error')} ">
	<label for="especie">
		<g:message code="foto.especie.label" default="Especie" />
		
	</label>
	<g:select id="especie" name="especie.id" from="${ikiam.Especie.list()}" optionKey="id" value="${fotoInstance?.especie?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fotoInstance, field: 'likes', 'error')} required">
	<label for="likes">
		<g:message code="foto.likes.label" default="Likes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="likes" type="number" value="${fotoInstance.likes}" required=""/>
</div>

