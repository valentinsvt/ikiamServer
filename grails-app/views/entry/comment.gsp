<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 04/09/2014
  Time: 23:41
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">

        <script src="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.js')}"></script>
        <link href="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.css')}" rel="stylesheet">
        <link href="${resource(dir: 'css', file: 'debug.css')}" rel="stylesheet"/>
        <title>Comentarios de foto</title>
    </head>

    <body>

        <div class="row">
            <div class="col-md-3 col-xs-4">
                Foto por:
            </div>

            <div class="col-md-9 col-xs-8">
                ${entryInstance.usuario?.nombre?.toString()?.decodeURL()} ${entryInstance.usuario?.apellido?.toString()?.decodeURL()}, ${entryInstance.usuario?.titulo}
            </div>
        </div>

        <div class="row">
            <div class="col-md-7 col-xs-12">
                <g:each in="${entryInstance.fotos}" var="foto">
                    <a href="${resource(dir: 'uploaded', file: foto.path)}" class="thumbnail image-popup-vertical-fit">
                        <img src="${resource(dir: 'uploaded', file: foto.path)}"/>
                    </a>
                </g:each>
            </div>

            <div class="col-md-5 col-xs-12">
                <div class="row">

                </div>
            </div>
        </div>

        <div class="row">

        </div>

    </body>
</html>