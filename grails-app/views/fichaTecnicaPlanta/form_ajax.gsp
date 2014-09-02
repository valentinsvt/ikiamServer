<%@ page import="ikiam.FichaTecnicaPlanta" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!fichaTecnicaPlantaInstance}">
    <elm:notFound elem="FichaTecnicaPlanta" genero="o" />
</g:if>
<g:else>
    
    <div class="col2">
    
    <g:form class="form-horizontal" name="frmFichaTecnicaPlanta" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${fichaTecnicaPlantaInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'alturaMax', 'error')} required">
            <span class="grupo">
                <label for="alturaMax" class="col-md-2 control-label text-info">
                    Altura Max
                </label>
                <div class="col-md-3">
                    <g:field name="alturaMax" type="number" value="${fieldValue(bean: fichaTecnicaPlantaInstance, field: 'alturaMax')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'alturaMin', 'error')} required">
            <span class="grupo">
                <label for="alturaMin" class="col-md-2 control-label text-info">
                    Altura Min
                </label>
                <div class="col-md-3">
                    <g:field name="alturaMin" type="number" value="${fieldValue(bean: fichaTecnicaPlantaInstance, field: 'alturaMin')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'edaficos', 'error')} required">
            <span class="grupo">
                <label for="edaficos" class="col-md-2 control-label text-info">
                    Edaficos
                </label>
                <div class="col-md-7">
                    <g:textField name="edaficos" required="" class="form-control required" value="${fichaTecnicaPlantaInstance?.edaficos}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'especie', 'error')} required">
            <span class="grupo">
                <label for="especie" class="col-md-2 control-label text-info">
                    Especie
                </label>
                <div class="col-md-7">
                    <g:select id="especie" name="especie.id" from="${ikiam.Especie.list()}" optionKey="id" required="" value="${fichaTecnicaPlantaInstance?.especie?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'factoresLimitantesCrecimiento', 'error')} required">
            <span class="grupo">
                <label for="factoresLimitantesCrecimiento" class="col-md-2 control-label text-info">
                    Factores Limitantes Crecimiento
                </label>
                <div class="col-md-7">
                    <g:textField name="factoresLimitantesCrecimiento" required="" class="form-control required" value="${fichaTecnicaPlantaInstance?.factoresLimitantesCrecimiento}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'fenologia', 'error')} required">
            <span class="grupo">
                <label for="fenologia" class="col-md-2 control-label text-info">
                    Fenologia
                </label>
                <div class="col-md-7">
                    <g:textField name="fenologia" required="" class="form-control required" value="${fichaTecnicaPlantaInstance?.fenologia}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'flor', 'error')} required">
            <span class="grupo">
                <label for="flor" class="col-md-2 control-label text-info">
                    Flor
                </label>
                <div class="col-md-7">
                    <g:textField name="flor" required="" class="form-control required" value="${fichaTecnicaPlantaInstance?.flor}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'forma1', 'error')} required">
            <span class="grupo">
                <label for="forma1" class="col-md-2 control-label text-info">
                    Forma1
                </label>
                <div class="col-md-7">
                    <g:select id="forma1" name="forma1.id" from="${ikiam.FormaDeVida.list()}" optionKey="id" required="" value="${fichaTecnicaPlantaInstance?.forma1?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'forma2', 'error')} required">
            <span class="grupo">
                <label for="forma2" class="col-md-2 control-label text-info">
                    Forma2
                </label>
                <div class="col-md-7">
                    <g:select id="forma2" name="forma2.id" from="${ikiam.FormaDeVida.list()}" optionKey="id" required="" value="${fichaTecnicaPlantaInstance?.forma2?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'fruto', 'error')} required">
            <span class="grupo">
                <label for="fruto" class="col-md-2 control-label text-info">
                    Fruto
                </label>
                <div class="col-md-7">
                    <g:textField name="fruto" required="" class="form-control required" value="${fichaTecnicaPlantaInstance?.fruto}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'hojas', 'error')} required">
            <span class="grupo">
                <label for="hojas" class="col-md-2 control-label text-info">
                    Hojas
                </label>
                <div class="col-md-7">
                    <g:textField name="hojas" required="" class="form-control required" value="${fichaTecnicaPlantaInstance?.hojas}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'precipitacionMax', 'error')} required">
            <span class="grupo">
                <label for="precipitacionMax" class="col-md-2 control-label text-info">
                    Precipitacion Max
                </label>
                <div class="col-md-3">
                    <g:field name="precipitacionMax" type="number" value="${fieldValue(bean: fichaTecnicaPlantaInstance, field: 'precipitacionMax')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'precipitacionMin', 'error')} required">
            <span class="grupo">
                <label for="precipitacionMin" class="col-md-2 control-label text-info">
                    Precipitacion Min
                </label>
                <div class="col-md-3">
                    <g:field name="precipitacionMin" type="number" value="${fieldValue(bean: fichaTecnicaPlantaInstance, field: 'precipitacionMin')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'semilla', 'error')} required">
            <span class="grupo">
                <label for="semilla" class="col-md-2 control-label text-info">
                    Semilla
                </label>
                <div class="col-md-7">
                    <g:textField name="semilla" required="" class="form-control required" value="${fichaTecnicaPlantaInstance?.semilla}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'temperaturaMax', 'error')} required">
            <span class="grupo">
                <label for="temperaturaMax" class="col-md-2 control-label text-info">
                    Temperatura Max
                </label>
                <div class="col-md-3">
                    <g:field name="temperaturaMax" type="number" value="${fieldValue(bean: fichaTecnicaPlantaInstance, field: 'temperaturaMax')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'temperaturaMin', 'error')} required">
            <span class="grupo">
                <label for="temperaturaMin" class="col-md-2 control-label text-info">
                    Temperatura Min
                </label>
                <div class="col-md-3">
                    <g:field name="temperaturaMin" type="number" value="${fieldValue(bean: fichaTecnicaPlantaInstance, field: 'temperaturaMin')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'tronco', 'error')} required">
            <span class="grupo">
                <label for="tronco" class="col-md-2 control-label text-info">
                    Tronco
                </label>
                <div class="col-md-7">
                    <g:textField name="tronco" required="" class="form-control required" value="${fichaTecnicaPlantaInstance?.tronco}"/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    
        </div>
    

    <script type="text/javascript">
        var validator = $("#frmFichaTecnicaPlanta").validate({
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