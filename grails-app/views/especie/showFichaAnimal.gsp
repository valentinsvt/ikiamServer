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
</body>
</html>