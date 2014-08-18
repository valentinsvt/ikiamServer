<%--
  Created by IntelliJ IDEA.
  User: svt
  Date: 8/18/2014
  Time: 12:57 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Publish</title>
</head>

<body>
<h1>${ruta.descripcion} </h1>
<g:each in="${cords}" var="c">
    <p>Coord: ${c.latitud} - ${c.longitud} a ${c.altitud}</p>
</g:each>
<g:each in="${fotos}" var="f">
    <img src="${g.resource(dir: 'uploaded',file: fotos.path)}">
</g:each>


</body>
</html>