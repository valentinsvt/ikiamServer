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
        <div style="width: 30px;height: 30px;line-height:30px;padding-left:6px;background: #${especie.estado?.color};display: inline-block;${(especie.estado?.color=='000000')?'color:red;':''};margin-left: 10px" class="ui-corner-all bold">${especie.estado?.codigo}</div>
    </div>
</div>

<h2 style="margin-top: 20px" >Características</h2>
<div class="row">
    <div class="col-md-2 bold" >
        Alimentacion:
    </div>
    <div class="col-md-5">
        ${ficha.alimentacion}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Comportamiento:
    </div>
    <div class="col-md-5">
        ${ficha.comportamiento}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Social:
    </div>
    <div class="col-md-5">
        ${ficha.social}
    </div>
</div>
<h2 style="margin-top: 20px" >Hábitat</h2>
<div class="row">
    <div class="col-md-2 bold" >
        Longevidad :
    </div>
    <div class="col-md-5">
        ${ficha.longevidad} años, en cautiverio: ${ficha.longevidadCautiverio} años
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Peso :
    </div>
    <div class="col-md-5">
        ${ficha.pesoMin.round(2)} - ${ficha.pesoMax.round(2)} Kilos
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" >
        Talla :
    </div>
    <div class="col-md-5">
        ${ficha.tallaMin.round(2)} - ${ficha.tallaMax.round(2)} Centímetros
    </div>
</div>

</body>
</html>