<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 15/09/2014
  Time: 21:21
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">

        <script src="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.js')}"></script>
        <link href="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.css')}" rel="stylesheet">

        <title>Enciclopedia</title>
    </head>

    <body>

        <ul class="ulFamilias">
            <g:each in="${ikiam.Familia.list([sort: 'nombre'])}" var="familia">
                <li class="familia">
                    ${familia.nombre}
                    <ul class="ulGeneros">
                    %{--<g:each in="${Genero.fab}"--}%
                    </ul>
                </li>
            </g:each>
        </ul>
    </body>
</html>