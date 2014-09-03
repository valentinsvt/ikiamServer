<%@ page import="ikiam.Color" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Ficha técnica: ${ficha.especie.genero.nombre} ${ficha.especie.nombre}
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
<div class="row">
    <div class="col-md-6" style="margin-left: 20px">
        <div class="row" style="margin-top: 10px">
            <div class="labelSvt">Familia:</div>
            <div class="fieldSvt">${especie.genero.familia.nombre}</div>
        </div>
        <div class="row" >
            <div class="labelSvt">Género:</div>
            <div class="fieldSvt">${especie.genero.nombre}</div>
        </div>
        <div class="row" >
            <div class="labelSvt">Especie:</div>
            <div class="fieldSvt">${especie.nombre}</div>
        </div>
        <div class="row" >
            <div class="labelSvt">N. común:</div>
            <div class="fieldSvt">${especie.nombreComun}</div>
        </div>
        <div class="row" >
            <div class="labelSvt">Estado:</div>
            <div class="fieldSvt">${especie.estado?.descripcion}</div>
            <div style="width: 30px;height: 30px;line-height:30px;padding-left:5px;background: #${especie.estado?.color};display: inline-block;${(especie.estado?.color=='000000')?'color:red;':''}">${especie.estado?.codigo}</div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" style="margin-left: 20px">
        Tronco:
    </div>
    <div class="col-md-5">
        ${ficha.tronco}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" style="margin-left: 20px">
        Hoja:
    </div>
    <div class="col-md-5">
        ${ficha.hojas}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" style="margin-left: 20px">
        Flor:
    </div>
    <div class="col-md-5">
        ${ficha.flor}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" style="margin-left: 20px">
        Fruto:
    </div>
    <div class="col-md-5">
        ${ficha.fruto}
    </div>
</div>
<div class="row">
    <div class="col-md-2 bold" style="margin-left: 20px">
        Semilla:
    </div>
    <div class="col-md-5">
        ${ficha.semilla}
    </div>
</div>
<div class="row"></div>
<div class="row"></div>
<div class="row"></div>
<div class="row"></div>
</body>
</html>