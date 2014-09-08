<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 08/09/14
  Time: 05:22 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">

        <link href="${resource(dir: 'css', file: 'CustomSvt.css')}" rel="stylesheet"/>
        <title>Entrada de ${entryInstance.especie.genero.nombre} ${entryInstance.especie.nombre}</title>
    </head>

    <body>

        <h1 style="margin-top: 10px">${entryInstance.especie.genero.nombre} ${entryInstance.especie.nombre}</h1>

        <div class="row">
            <div class="col-md-6 col-md-offset-3 col-xs-12">
                <g:each in="${entryInstance.fotos}" var="foto" status="i">
                    <div class="thumbnail">

                        <a href="${resource(dir: 'uploaded', file: foto.path)}" class="image-popup-vertical-fit">
                            <img class="img-rounded" src="${resource(dir: 'uploaded', file: foto.path)}"/>
                        </a>

                    </div>
                </g:each>
            </div>
        </div>
    </body>
</html>