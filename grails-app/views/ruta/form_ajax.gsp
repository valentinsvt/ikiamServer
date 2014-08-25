<%@ page import="ikiam.Ruta" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!rutaInstance}">
    <elm:notFound elem="Ruta" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmRuta" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${rutaInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: rutaInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="50" required="" class="form-control required" value="${rutaInstance?.descripcion}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: rutaInstance, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label for="fecha" class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fecha"  class="datepicker form-control required" value="${rutaInstance?.fecha}"  />
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: rutaInstance, field: 'usuario', 'error')} required">
            <span class="grupo">
                <label for="usuario" class="col-md-2 control-label text-info">
                    Usuario
                </label>
                <div class="col-md-6">
                    <g:select id="usuario" name="usuario.id" from="${ikiam.Usuario.list()}" optionKey="id" required="" value="${rutaInstance?.usuario?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmRuta").validate({
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