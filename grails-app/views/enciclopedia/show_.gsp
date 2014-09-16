<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 15/09/2014
  Time: 21:21
--%>

<%@ page import="ikiam.Especie; ikiam.Familia; ikiam.Genero" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">

        <script src="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.js')}"></script>
        <link href="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.css')}" rel="stylesheet">

        <link rel="stylesheet" href="${resource(dir: 'js/plugins/vakata-jstree-aa240c1/dist/themes/default', file: 'style.min.css')}"/>
        <script src="${resource(dir: 'js/plugins/vakata-jstree-aa240c1/dist', file: 'jstree.min.js')}"></script>

        <title>Enciclopedia</title>

        <style type="text/css">
        .side {
            border   : solid 3px #9ECD66;
            height   : 500px;
            overflow : auto;
        }

        .left {
            border-right-width : 1px;
        }

        .right {
            border-left-width : 1px;
        }
        </style>

    </head>

    <body>
        <div class="row">
            <div class="col-md-4 left side ui-corner-left" id="jstree">
                <ul class="ulFamilias list-group">
                    <g:each in="${Familia.list([sort: 'nombre'])}" var="familia">
                        <li class="familia jstree-open list-group-item" data-jstree='{"type":"familia"}'>
                            ${familia.nombre}
                            <ul class="ulGeneros ">
                                <g:each in="${Genero.findAllByFamilia(familia, [sort: 'nombre'])}" var="genero">
                                    <li class="genero jstree-open list-group-item" data-jstree='{"type":"genero"}'>
                                        ${genero.nombre}
                                        <ul class="ulEspecies ">
                                            <g:each in="${Especie.findAllByGenero(genero, [sort: 'nombre'])}" var="especie">
                                                <li class="especie list-group-item" data-jstree='{"type":"especie"}'>
                                                    ${especie.nombre}
                                                </li>
                                            </g:each>
                                        </ul>
                                    </li>
                                </g:each>
                            </ul>
                        </li>
                    </g:each>
                </ul>
            </div>

            <div class="col-md-6 right side ui-corner-right">
                DESCRIPCION
            </div>
        </div>

        <script type="text/javascript">
            $(function () {

            });
        </script>

    </body>
</html>