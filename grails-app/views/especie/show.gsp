<%@ page import="ikiam.Color" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        ${especie.genero.nombre} ${especie.nombre}
    </title>

    <link href="${resource(dir: 'css', file: 'CustomSvt.css')}" rel="stylesheet"/>
    <style>
    .bloque{
        width: 100%;
        margin-top: 10px;
    }
    .descripcion{
        width: 400px;
        height: 240px;
        margin-left: 30px;
        font-size: 16px;
        display: inline-block;
    }
    .descripcion_larga{
        width: 100%;
        font-size: 13px;
    }
    </style>
</head>
<body>

<h1 style="margin-top: 10px"> ${especie.genero.nombre} ${especie.nombre}</h1>
<div class="row">
    <div class="col-md-4">
        <img src="${g.resource(dir: 'uploaded/',file: entrys[0]?.fotos[0]?.path)}" style="width: 300px;margin-top: 10px;display: inline" />
    </div>
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
    </div>
</div>
<h2 style="margin-top: 10px">Descripción</h2>
<div class="bloque">
    <div class="descripcion_larga">
        <g:if test="${especie.descripcion}">
            ${especie.descripcion}
        </g:if>
        <g:else>
            No hay datos
        </g:else>
    </div>
</div>
<h2 style="margin-top: 10px">Distribucion</h2>
<div class="bloque">
    <div class="descripcion_larga">
        <g:if test="${especie.distribucion}">
            ${especie.distribucion}
        </g:if>
        <g:else>
            No hay datos
        </g:else>
    </div>
</div>
<h2 style="margin-top: 10px">Etimología</h2>
<div class="bloque">
    <div class="descripcion_larga">
        <g:if test="${especie.etimologia}">
            ${especie.etimologia}
        </g:if>
        <g:else>
            No hay datos
        </g:else>
    </div>
</div>
<h2 style="margin-top: 10px">Datos adicionales</h2>
<div class="bloque">
    <div class="descripcion_larga">
        ${especie.texto}
    </div>
</div>
<h2 style="margin-top: 10px">Entradas</h2>
<div class="row">
<g:each in="${entrys}" var="entry">
    <div class="col-md-2 col-xs-5">
        <img src="${g.resource(dir: 'uploaded/',file: entry?.fotos[0]?.path)}" style="width: 100%">
        ${entry.fecha.format("dd-MM-yyyy")}
    </div>
</g:each>
</div>
</body>
</html>