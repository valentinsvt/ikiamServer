<%@ page import="ikiam.Familia" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!familiaInstance}">
    <elm:notFound elem="Familia" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmFamilia" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${familiaInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: familiaInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="75" required="" class="form-control required" value="${familiaInstance?.nombre}"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmFamilia").validate({
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