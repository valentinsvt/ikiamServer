<%@ page import="ikiam.Genero" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!generoInstance}">
    <elm:notFound elem="Genero" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmGenero" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${generoInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: generoInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="75" required="" class="form-control required" value="${generoInstance?.nombre}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: generoInstance, field: 'familia', 'error')} required">
            <span class="grupo">
                <label for="familia" class="col-md-2 control-label text-info">
                    Familia
                </label>
                <div class="col-md-6">
                    <g:select id="familia" name="familia.id" from="${ikiam.Familia.list()}" optionKey="id" required="" value="${generoInstance?.familia?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmGenero").validate({
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