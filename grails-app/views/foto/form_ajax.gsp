<%@ page import="ikiam.Foto" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!fotoInstance}">
    <elm:notFound elem="Foto" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmFoto" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${fotoInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'path', 'error')} required">
            <span class="grupo">
                <label for="path" class="col-md-2 control-label text-info">
                    Path
                </label>
                <div class="col-md-6">
                    <g:textArea name="path" cols="40" rows="5" maxlength="255" required="" class="form-control required" value="${fotoInstance?.path}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'usuario', 'error')} ">
            <span class="grupo">
                <label for="usuario" class="col-md-2 control-label text-info">
                    Usuario
                </label>
                <div class="col-md-6">
                    <g:select id="usuario" name="usuario.id" from="${ikiam.Usuario.list()}" optionKey="id" value="${fotoInstance?.usuario?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'coordenada', 'error')} ">
            <span class="grupo">
                <label for="coordenada" class="col-md-2 control-label text-info">
                    Coordenada
                </label>
                <div class="col-md-6">
                    <g:select id="coordenada" name="coordenada.id" from="${ikiam.Coordenada.list()}" optionKey="id" value="${fotoInstance?.coordenada?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'keyWords', 'error')} ">
            <span class="grupo">
                <label for="keyWords" class="col-md-2 control-label text-info">
                    Key Words
                </label>
                <div class="col-md-6">
                    <g:textField name="keyWords" maxlength="100" class="form-control" value="${fotoInstance?.keyWords}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'atraccion', 'error')} ">
            <span class="grupo">
                <label for="atraccion" class="col-md-2 control-label text-info">
                    Atraccion
                </label>
                <div class="col-md-6">
                    <g:select id="atraccion" name="atraccion.id" from="${ikiam.AtraccionTuristica.list()}" optionKey="id" value="${fotoInstance?.atraccion?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'entry', 'error')} ">
            <span class="grupo">
                <label for="entry" class="col-md-2 control-label text-info">
                    Entry
                </label>
                <div class="col-md-6">
                    <g:select id="entry" name="entry.id" from="${ikiam.Entry.list()}" optionKey="id" value="${fotoInstance?.entry?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'especie', 'error')} ">
            <span class="grupo">
                <label for="especie" class="col-md-2 control-label text-info">
                    Especie
                </label>
                <div class="col-md-6">
                    <g:select id="especie" name="especie.id" from="${ikiam.Especie.list()}" optionKey="id" value="${fotoInstance?.especie?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'ruta', 'error')} ">
            <span class="grupo">
                <label for="ruta" class="col-md-2 control-label text-info">
                    Ruta
                </label>
                <div class="col-md-6">
                    <g:select id="ruta" name="ruta.id" from="${ikiam.Ruta.list()}" optionKey="id" value="${fotoInstance?.ruta?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fotoInstance, field: 'likes', 'error')} required">
            <span class="grupo">
                <label for="likes" class="col-md-2 control-label text-info">
                    Likes
                </label>
                <div class="col-md-2">
                    <g:field name="likes" type="number" value="${fotoInstance.likes}" class="digits form-control required" required=""/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmFoto").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
            }
            
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>