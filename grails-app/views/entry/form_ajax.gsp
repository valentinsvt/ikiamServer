<%@ page import="ikiam.Entry" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!entryInstance}">
    <elm:notFound elem="Entry" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmEntry" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${entryInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: entryInstance, field: 'observaciones', 'error')} required">
            <span class="grupo">
                <label for="observaciones" class="col-md-2 control-label text-info">
                    Observaciones
                </label>
                <div class="col-md-6">
                    <g:textArea name="observaciones" cols="40" rows="5" maxlength="255" required="" class="form-control required" value="${entryInstance?.observaciones}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: entryInstance, field: 'usuario', 'error')} ">
            <span class="grupo">
                <label for="usuario" class="col-md-2 control-label text-info">
                    Usuario
                </label>
                <div class="col-md-6">
                    <g:select id="usuario" name="usuario.id" from="${ikiam.Usuario.list()}" optionKey="id" value="${entryInstance?.usuario?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: entryInstance, field: 'especie', 'error')} ">
            <span class="grupo">
                <label for="especie" class="col-md-2 control-label text-info">
                    Especie
                </label>
                <div class="col-md-6">
                    <g:select id="especie" name="especie.id" from="${ikiam.Especie.list()}" optionKey="id" value="${entryInstance?.especie?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: entryInstance, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label for="fecha" class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fecha"  class="datepicker form-control required" value="${entryInstance?.fecha}"  />
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmEntry").validate({
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