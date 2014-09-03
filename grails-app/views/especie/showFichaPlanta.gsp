<%@ page import="ikiam.Color" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Ficha técnica
    </title>

    <link href="${resource(dir: 'css', file: 'CustomSvt.css')}" rel="stylesheet"/>
    <style>
    .bold{
        font-weight: bold;
    }
    </style>
</head>

<body>

<h1 style="margin-top: 10px"> ${especie.genero.nombre} ${especie.nombre}</h1>

<div class="row" style="margin-top: 30px">
    <div class="col-md-2 col-xs-4  bold">Familia:</div>
    <div class="col-md-5 col-xs-8">${especie.genero.familia.nombre}</div>
</div>
<div class="row" >
    <div class="col-md-2  col-xs-4 bold">Género:</div>
    <div class="col-md-5 col-xs-8">${especie.genero.nombre}</div>
</div>
<div class="row" >
    <div class="col-md-2 col-xs-4 bold">Especie:</div>
    <div class="col-md-5 col-xs-8">${especie.nombre}</div>
</div>

<div class="row" >
    <div class="col-md-2 col-xs-4 bold">N. común:</div>
    <div class="col-md-5 col-xs-8">${especie.nombreComun}</div>
</div>
<div class="row" >
    <div class="col-md-2 col-xs-4 bold">Estado:</div>
    <div class="col-md-3 col-xs-8">
        ${especie.estado?.descripcion}
        <div style="width: 30px;height: 30px;line-height:30px;padding-left:6px;background: #${especie.estado?.color};display: inline-block;${(especie.estado?.color=='000000')?'color:red;':''};margin-left: 10px" class="ui-corner-all">${especie.estado?.codigo}</div>
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold col-xs-4" >
        Forma de vida:
    </div>
    <div class="col-md-5 col-xs-8">
        ${ficha.forma1?.descripcion}
    </div>
</div>
<g:if test="${ficha.forma2}">
    <div class="row">
        <div class="col-md-2 bold col-xs-4" >
            Forma de vida 2:
        </div>
        <div class="col-md-5 col-xs-8">
            ${ficha.forma2?.descripcion}
        </div>
    </div>
</g:if>
<h2 style="margin-top: 20px" >Características</h2>
<div class="row">
    <div class="col-md-2 bold" >
        Tronco:
    </div>
    <div class="col-md-5">
        ${ficha.tronco}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Hoja:
    </div>
    <div class="col-md-5">
        ${ficha.hojas}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Flor:
    </div>
    <div class="col-md-5">
        ${ficha.flor}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Fruto:
    </div>
    <div class="col-md-5">
        ${ficha.fruto}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Semilla:
    </div>
    <div class="col-md-5">
        ${ficha.semilla}
    </div>
</div>
<h2 style="margin-top: 20px" >Hábitat</h2>
<div class="row">
    <div class="col-md-2 bold" >
        Altitud :
    </div>
    <div class="col-md-5">
        ${ficha.alturaMin.round(2)} - ${ficha.alturaMax.round(2)} Metros
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Temperatura :
    </div>
    <div class="col-md-5">
        ${ficha.temperaturaMin.round(2)} - ${ficha.temperaturaMax.round(2)} Grados centigrados
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Precpitación :
    </div>
    <div class="col-md-5">
        ${ficha.precipitacionMin.round(2)} - ${ficha.precipitacionMax.round(2)} Centímetros cúbicos
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Factores limitantes de crecimiento :
    </div>
    <div class="col-md-5">
        ${ficha.factoresLimitantesCrecimiento}
    </div>
</div>
<h2 style="margin-top: 20px" >Fenología</h2>
<div class="row" style="margin-left: 0px">
    ${ficha.fenologia}
</div>
<h2 style="margin-top: 20px" >Requerimientos edáficos</h2>
<div class="row" style="margin-left: 0px;margin-bottom: 20px">
    ${ficha.edaficos}
</div>
</body>
</html>