<%@ page import="ikiam.EstadoDeConservacion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!estadoDeConservacionInstance}">
    <elm:notFound elem="EstadoDeConservacion" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmEstadoDeConservacion" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${estadoDeConservacionInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: estadoDeConservacionInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="100" required="" class="form-control required" value="${estadoDeConservacionInstance?.descripcion}"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmEstadoDeConservacion").validate({
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