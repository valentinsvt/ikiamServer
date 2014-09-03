
<%@ page import="ikiam.Paper" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Estudios</title>
    <style>
    th{
        color: #0088CC;
        font-weight: bold;
    }
    </style>
    <link href="${resource(dir: 'css', file: 'CustomSvt.css')}" rel="stylesheet"/>
</head>
<body>

<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

<h1 style="margin-top: 10px"> ${especie.genero.nombre} ${especie.nombre}</h1>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th>Título</th>
        <th>Autor</th>
        <th>Fecha</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${papers}" status="i" var="paperInstance">
        <tr data-id="${paperInstance.id}">
            <td>
                <elm:textoBusqueda busca="${params.search}">
                    ${paperInstance.titulo?.toString()?.decodeURL()}
                </elm:textoBusqueda>
            </td>
            <td>
                <elm:textoBusqueda busca="${params.search}">
                    ${paperInstance.autor?.toString()?.decodeURL()}
                </elm:textoBusqueda>
            </td>

            <td>
                <g:formatDate date="${paperInstance.fecha}" format="dd-MM-yyyy" />
            </td>
            <td>
                <a href="${g.resource(dir: 'papers',file: paperInstance.path)}" class="btn btn-azul">Descargar</a>
            </td>

        </tr>
    </g:each>
    </tbody>
</table>



<script type="text/javascript">

</script>

</body>
</html>
