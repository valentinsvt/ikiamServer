<%@ page import="ikiam.Especie" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!especieInstance}">
    <elm:notFound elem="Especie" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmEspecie" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${especieInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: especieInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="75" required="" class="form-control required" value="${especieInstance?.nombre}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: especieInstance, field: 'color2', 'error')} ">
            <span class="grupo">
                <label for="color2" class="col-md-2 control-label text-info">
                    Color2
                </label>
                <div class="col-md-6">
                    <g:select id="color2" name="color2.id" from="${ikiam.Color.list()}" optionKey="id" value="${especieInstance?.color2?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: especieInstance, field: 'color1', 'error')} required">
            <span class="grupo">
                <label for="color1" class="col-md-2 control-label text-info">
                    Color1
                </label>
                <div class="col-md-6">
                    <g:select id="color1" name="color1.id" from="${ikiam.Color.list()}" optionKey="id" required="" value="${especieInstance?.color1?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: especieInstance, field: 'genero', 'error')} required">
            <span class="grupo">
                <label for="genero" class="col-md-2 control-label text-info">
                    Genero
                </label>
                <div class="col-md-6">
                    <g:select id="genero" name="genero.id" from="${ikiam.Genero.list()}" optionKey="id" required="" value="${especieInstance?.genero?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: especieInstance, field: 'nombreComun', 'error')} required">
            <span class="grupo">
                <label for="nombreComun" class="col-md-2 control-label text-info">
                    Nombre Comun
                </label>
                <div class="col-md-6">
                    <g:textField name="nombreComun" required="" class="form-control required" value="${especieInstance?.nombreComun}"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmEspecie").validate({
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