<%@ page import="ikiam.FichaTecnicaAnimal" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!fichaTecnicaAnimalInstance}">
    <elm:notFound elem="FichaTecnicaAnimal" genero="o" />
</g:if>
<g:else>
    
    <div class="col2">
    
    <g:form class="form-horizontal" name="frmFichaTecnicaAnimal" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${fichaTecnicaAnimalInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'alimentacion', 'error')} ">
            <span class="grupo">
                <label for="alimentacion" class="col-md-2 control-label text-info">
                    Alimentacion
                </label>
                <div class="col-md-7">
                    <g:textField name="alimentacion" class="form-control" value="${fichaTecnicaAnimalInstance?.alimentacion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'social', 'error')} ">
            <span class="grupo">
                <label for="social" class="col-md-2 control-label text-info">
                    Social
                </label>
                <div class="col-md-7">
                    <g:textField name="social" class="form-control" value="${fichaTecnicaAnimalInstance?.social}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'comportamiento', 'error')} ">
            <span class="grupo">
                <label for="comportamiento" class="col-md-2 control-label text-info">
                    Comportamiento
                </label>
                <div class="col-md-7">
                    <g:textField name="comportamiento" class="form-control" value="${fichaTecnicaAnimalInstance?.comportamiento}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'etimologia', 'error')} ">
            <span class="grupo">
                <label for="etimologia" class="col-md-2 control-label text-info">
                    Etimologia
                </label>
                <div class="col-md-7">
                    <g:textField name="etimologia" class="form-control" value="${fichaTecnicaAnimalInstance?.etimologia}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'conservacion', 'error')} ">
            <span class="grupo">
                <label for="conservacion" class="col-md-2 control-label text-info">
                    Conservacion
                </label>
                <div class="col-md-7">
                    <g:textField name="conservacion" class="form-control" value="${fichaTecnicaAnimalInstance?.conservacion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'habitat', 'error')} ">
            <span class="grupo">
                <label for="habitat" class="col-md-2 control-label text-info">
                    Habitat
                </label>
                <div class="col-md-7">
                    <g:textField name="habitat" class="form-control" value="${fichaTecnicaAnimalInstance?.habitat}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'taxonomia', 'error')} ">
            <span class="grupo">
                <label for="taxonomia" class="col-md-2 control-label text-info">
                    Taxonomia
                </label>
                <div class="col-md-7">
                    <g:textField name="taxonomia" class="form-control" value="${fichaTecnicaAnimalInstance?.taxonomia}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'alturaMin', 'error')} required">
            <span class="grupo">
                <label for="alturaMin" class="col-md-2 control-label text-info">
                    Altura Min
                </label>
                <div class="col-md-3">
                    <g:field name="alturaMin" type="number" value="${fieldValue(bean: fichaTecnicaAnimalInstance, field: 'alturaMin')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'alturaMax', 'error')} required">
            <span class="grupo">
                <label for="alturaMax" class="col-md-2 control-label text-info">
                    Altura Max
                </label>
                <div class="col-md-3">
                    <g:field name="alturaMax" type="number" value="${fieldValue(bean: fichaTecnicaAnimalInstance, field: 'alturaMax')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'temperaturaMax', 'error')} required">
            <span class="grupo">
                <label for="temperaturaMax" class="col-md-2 control-label text-info">
                    Temperatura Max
                </label>
                <div class="col-md-3">
                    <g:field name="temperaturaMax" type="number" value="${fieldValue(bean: fichaTecnicaAnimalInstance, field: 'temperaturaMax')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'temperaturaMin', 'error')} required">
            <span class="grupo">
                <label for="temperaturaMin" class="col-md-2 control-label text-info">
                    Temperatura Min
                </label>
                <div class="col-md-3">
                    <g:field name="temperaturaMin" type="number" value="${fieldValue(bean: fichaTecnicaAnimalInstance, field: 'temperaturaMin')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'especie', 'error')} required">
            <span class="grupo">
                <label for="especie" class="col-md-2 control-label text-info">
                    Especie
                </label>
                <div class="col-md-7">
                    <g:select id="especie" name="especie.id" from="${ikiam.Especie.list()}" optionKey="id" required="" value="${fichaTecnicaAnimalInstance?.especie?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'longevidad', 'error')} required">
            <span class="grupo">
                <label for="longevidad" class="col-md-2 control-label text-info">
                    Longevidad
                </label>
                <div class="col-md-3">
                    <g:field name="longevidad" type="number" value="${fichaTecnicaAnimalInstance.longevidad}" class="digits form-control required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'longevidadCautiverio', 'error')} required">
            <span class="grupo">
                <label for="longevidadCautiverio" class="col-md-2 control-label text-info">
                    Longevidad Cautiverio
                </label>
                <div class="col-md-3">
                    <g:field name="longevidadCautiverio" type="number" value="${fichaTecnicaAnimalInstance.longevidadCautiverio}" class="digits form-control required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'pesoMax', 'error')} required">
            <span class="grupo">
                <label for="pesoMax" class="col-md-2 control-label text-info">
                    Peso Max
                </label>
                <div class="col-md-3">
                    <g:field name="pesoMax" type="number" value="${fieldValue(bean: fichaTecnicaAnimalInstance, field: 'pesoMax')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'pesoMin', 'error')} required">
            <span class="grupo">
                <label for="pesoMin" class="col-md-2 control-label text-info">
                    Peso Min
                </label>
                <div class="col-md-3">
                    <g:field name="pesoMin" type="number" value="${fieldValue(bean: fichaTecnicaAnimalInstance, field: 'pesoMin')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'tallaMax', 'error')} required">
            <span class="grupo">
                <label for="tallaMax" class="col-md-2 control-label text-info">
                    Talla Max
                </label>
                <div class="col-md-3">
                    <g:field name="tallaMax" type="number" value="${fieldValue(bean: fichaTecnicaAnimalInstance, field: 'tallaMax')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: fichaTecnicaAnimalInstance, field: 'tallaMin', 'error')} required">
            <span class="grupo">
                <label for="tallaMin" class="col-md-2 control-label text-info">
                    Talla Min
                </label>
                <div class="col-md-3">
                    <g:field name="tallaMin" type="number" value="${fieldValue(bean: fichaTecnicaAnimalInstance, field: 'tallaMin')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    
        </div>
    

    <script type="text/javascript">
        var validator = $("#frmFichaTecnicaAnimal").validate({
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