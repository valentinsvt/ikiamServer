<%@ page import="ikiam.Color" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!colorInstance}">
    <elm:notFound elem="Color" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmColor" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${colorInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: colorInstance, field: 'color', 'error')} required">
            <span class="grupo">
                <label for="color" class="col-md-2 control-label text-info">
                    Color
                </label>
                <div class="col-md-6">
                    <g:textField name="color" maxlength="20" required="" class="form-control required" value="${colorInstance?.color}"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmColor").validate({
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