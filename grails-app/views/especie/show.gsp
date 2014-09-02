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
        <div class="row" >
            <div class="labelSvt">Estado:</div>
            <div class="fieldSvt">${especie.estado}</div>
            <div style="width: 30px;height: 30px;background: ${especie.estado?.color}">${especie.estado?.codigo}</div>
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
<h2 style="margin-top: 10px">Distribución</h2>
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
<div class="row" style="margin-bottom: 10px">
    <g:each in="${entrys}" var="entry">
        <div class="col-md-2 col-xs-5 ui-corner-all" style="border: 1px solid #0088CC;padding: 3px;cursor: pointer;margin-left: 10px;margin-top: 10px">
            <img src="${g.resource(dir: 'uploaded/',file: entry?.fotos[0]?.path)}" style="width: 100%" class="ui-corner-all">
            <div style="margin-top: 3px;width: 100%;text-align: center;font-weight: bold">
                ${entry.fecha.format("dd-MM-yyyy")}
            </div>
        </div>
    </g:each>
</div>
</body>
</html>