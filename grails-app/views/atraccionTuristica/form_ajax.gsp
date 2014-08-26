<%@ page import="ikiam.AtraccionTuristica" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!atraccionTuristicaInstance}">
    <elm:notFound elem="AtraccionTuristica" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmAtraccionTuristica" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${atraccionTuristicaInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: atraccionTuristicaInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="200" required="" class="form-control required" value="${atraccionTuristicaInstance?.nombre}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: atraccionTuristicaInstance, field: 'url', 'error')} ">
            <span class="grupo">
                <label for="url" class="col-md-2 control-label text-info">
                    Url
                </label>
                <div class="col-md-6">
                    <g:textField name="url" maxlength="200" class="form-control" value="${atraccionTuristicaInstance?.url}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: atraccionTuristicaInstance, field: 'coordenada', 'error')} required">
            <span class="grupo">
                <label for="coordenada" class="col-md-2 control-label text-info">
                    Coordenada
                </label>
                <div class="col-md-6">
                    <g:select id="coordenada" name="coordenada.id" from="${ikiam.Coordenada.list()}" optionKey="id" required="" value="${atraccionTuristicaInstance?.coordenada?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: atraccionTuristicaInstance, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label for="fecha" class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fecha"  class="datepicker form-control required" value="${atraccionTuristicaInstance?.fecha}"  />
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: atraccionTuristicaInstance, field: 'likes', 'error')} required">
            <span class="grupo">
                <label for="likes" class="col-md-2 control-label text-info">
                    Likes
                </label>
                <div class="col-md-2">
                    <g:field name="likes" type="number" value="${atraccionTuristicaInstance.likes}" class="digits form-control required" required=""/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmAtraccionTuristica").validate({
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