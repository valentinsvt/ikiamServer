<%@ page import="ikiam.Coordenada" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!coordenadaInstance}">
    <elm:notFound elem="Coordenada" genero="o"/>
</g:if>
<g:else>

    <g:form class="form-horizontal" name="frmCoordenada" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${coordenadaInstance?.id}"/>


        <div class="form-group keeptogether ${hasErrors(bean: coordenadaInstance, field: 'ruta', 'error')} ">
            <span class="grupo">
                <label for="ruta" class="col-md-2 control-label text-info">
                    Ruta
                </label>

                <div class="col-md-6">
                    <g:select id="ruta" name="ruta.id" from="${ikiam.Ruta.list()}" optionKey="id" value="${coordenadaInstance?.ruta?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: coordenadaInstance, field: 'altitud', 'error')} required">
            <span class="grupo">
                <label for="altitud" class="col-md-2 control-label text-info">
                    Altitud
                </label>

                <div class="col-md-6">
                    <g:textField name="altitud" value="${fieldValue(bean: coordenadaInstance, field: 'altitud')}"
                                 class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: coordenadaInstance, field: 'latitud', 'error')} required">
            <span class="grupo">
                <label for="latitud" class="col-md-2 control-label text-info">
                    Latitud
                </label>

                <div class="col-md-6">
                    <g:textField name="latitud" type="number" value="${fieldValue(bean: coordenadaInstance, field: 'latitud')}"
                                 class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: coordenadaInstance, field: 'longitud', 'error')} required">
            <span class="grupo">
                <label for="longitud" class="col-md-2 control-label text-info">
                    Longitud
                </label>

                <div class="col-md-6">
                    <g:textField name="longitud" type="number" value="${fieldValue(bean: coordenadaInstance, field: 'longitud')}"
                                 class="number form-control  required" required=""/>
                </div>
                *
            </span>
        </div>

    </g:form>


    <script type="text/javascript">
        var validator = $("#frmCoordenada").validate({
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