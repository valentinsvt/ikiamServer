<%@ page import="ikiam.Color" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Ficha técnica
    </title>

    %{--<link href="${resource(dir: 'css', file: 'debug.css')}" rel="stylesheet"/>--}%

    <style type="text/css">
    .thumbnail {
        max-width  : 200px;
        max-height : 200px;
    }

    .toggle {
        width  : 30px;
        cursor : pointer;
    }

    body {
        padding-right  : 5px;
        padding-bottom : 5px;
        padding-left   : 5px;
    }

    .marginTop {
        margin-top : 10px;
    }

    .map {
        height : 400px;
    }

    form {
        margin-bottom : 15px;
    }
    </style>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
</head>


<body>

<g:form class="form-horizontal form" name="frmFichaTecnicaPlanta" role="form" controller="fichaTecnicaPlanta" action="save_ajax" method="POST">
<g:hiddenField name="id" value="${fichaTecnicaPlantaInstance?.id}" />

<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'fruto', 'error')} required">
    <span class="grupo">
        <label for="fruto" class="col-md-2 control-label text-info">
            Fruto
        </label>
        <div class="col-md-7">
            <textarea name="fruto" required="" class="form-control required">
                ${fichaTecnicaPlantaInstance?.fruto}
            </textarea>
        </div>
        *
    </span>
</div>

<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'hojas', 'error')} required">
    <span class="grupo">
        <label for="hojas" class="col-md-2 control-label text-info">
            Hojas
        </label>
        <div class="col-md-7">
            <textarea name="hojas" required="" class="form-control required" >
                ${fichaTecnicaPlantaInstance?.hojas}
            </textarea>
        </div>
        *
    </span>
</div>
<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'flor', 'error')} required">
    <span class="grupo">
        <label for="flor" class="col-md-2 control-label text-info">
            Flor
        </label>
        <div class="col-md-7">
            <textarea name="flor" required="" class="form-control " >
                ${fichaTecnicaPlantaInstance?.flor}
            </textarea>
        </div>
        *
    </span>
</div>

<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'tronco', 'error')} required">
    <span class="grupo">
        <label for="tronco" class="col-md-2 control-label text-info">
            Tronco
        </label>
        <div class="col-md-7">
            <textarea name="tronco" required="" class="form-control " >
                ${fichaTecnicaPlantaInstance?.tronco}
            </textarea>
        </div>
        *
    </span>
</div>
<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'semilla', 'error')} required">
    <span class="grupo">
        <label for="semilla" class="col-md-2 control-label text-info">
            Semilla
        </label>
        <div class="col-md-7">
            <textarea name="semilla" required="" class="form-control " >
                ${fichaTecnicaPlantaInstance?.semilla}
            </textarea>
        </div>
        *
    </span>
</div>
<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'factoresLimitantesCrecimiento', 'error')} required">
    <span class="grupo">
        <label for="factoresLimitantesCrecimiento" class="col-md-2 control-label text-info">
            Factores Limitantes Crecimiento
        </label>
        <div class="col-md-7">
            <textarea name="factoresLimitantesCrecimiento" required="" class="form-control " >
                ${fichaTecnicaPlantaInstance?.factoresLimitantesCrecimiento}
            </textarea>
        </div>
        *
    </span>
</div>



<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'fenologia', 'error')} ">
    <span class="grupo">
        <label for="fenologia" class="col-md-2 control-label text-info">
            Fenologia
        </label>
        <div class="col-md-7">
            <textarea name="fenologia" required="" class="form-control " >
                ${fichaTecnicaPlantaInstance?.fenologia}
            </textarea>
        </div>
        *
    </span>
</div>
<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'edaficos', 'error')} ">
    <span class="grupo">
        <label for="edaficos" class="col-md-2 control-label text-info">
            Requerimientos edáficos
        </label>
        <div class="col-md-7">
            <textarea name="edaficos" required="" class="form-control " >
                ${fichaTecnicaPlantaInstance?.edaficos}
            </textarea>
        </div>
        *
    </span>
</div>



<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'alturaMax', 'error')} ">
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

<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'alturaMin', 'error')} required">
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



<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'especie', 'error')} required">
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





<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'forma1', 'error')} required">
    <span class="grupo">
        <label for="forma1" class="col-md-2 control-label text-info">
            Forma de vida
        </label>
        <div class="col-md-7">
            <g:select id="forma1" name="forma1.id" from="${ikiam.FormaDeVida.list()}" optionKey="id" required="" value="${fichaTecnicaPlantaInstance?.forma1?.id}" optionValue="descripcion"  class="many-to-one form-control"/>
        </div>
        *
    </span>
</div>

<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'forma2', 'error')} required">
    <span class="grupo">
        <label for="forma2" class="col-md-2 control-label text-info">
            Forma de vida 2
        </label>
        <div class="col-md-7">
            <g:select id="forma2" name="forma2.id" from="${ikiam.FormaDeVida.list()}" optionKey="id" required="" value="${fichaTecnicaPlantaInstance?.forma2?.id}"  noSelection="['-1':'Seleccione...']" optionValue="descripcion"  class="many-to-one form-control"/>
        </div>
        *
    </span>
</div>



<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'precipitacionMax', 'error')} required">
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

<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'precipitacionMin', 'error')} required">
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



<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'temperaturaMax', 'error')} required">
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

<div class="row ${hasErrors(bean: fichaTecnicaPlantaInstance, field: 'temperaturaMin', 'error')} required">
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


</g:form>



<div class="row text-center">
    <a href="#" class="btn btn-success" id="btnSave" style="float: left">
        <i class="fa fa-save"></i> Guardar
    </a>
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
    $("#btnSave").click(function(){
        $(".form").submit()
    })
</script>
</body>
</html>