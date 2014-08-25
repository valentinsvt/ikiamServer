<%--
  Created by IntelliJ IDEA.
  User: svt
  Date: 8/18/2014
  Time: 12:57 PM
--%>

%{--<%@ page contentType="text/html;charset=UTF-8" %>--}%
%{--<html>--}%
%{--<head>--}%
%{--<title>Publish</title>--}%
%{--</head>--}%

%{--<body>--}%
%{--<h1>${ruta.descripcion}</h1>--}%
%{--<g:each in="${cords}" var="c">--}%
%{--<p>Coord: ${c.latitud} - ${c.longitud} a ${c.altitud}</p>--}%
%{--</g:each>--}%
%{--<g:each in="${fotos}" var="f">--}%
%{--<img src="${g.resource(dir: 'uploaded', file: f.path)}">--}%
%{--</g:each>--}%

%{--</body>--}%
%{--</html>--}%

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
        <style type="text/css">
        html {
            height : 100%
        }

        body {
            height  : 100%;
            margin  : 0;
            padding : 0
        }

        #map-canvas {
            height : 100%
        }
        </style>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCJGVHKSrM7bH0suD95ii7bhIp-_29BrSk">
        </script>
        <script type="text/javascript">
            function initialize() {
                var mapOptions = {
                    center : new google.maps.LatLng(-34.397, 150.644),
                    zoom   : 8
                };
                var map = new google.maps.Map(document.getElementById("map-canvas"),
                        mapOptions);
            }
            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
    </head>

    <body>
        <div id="map-canvas"/>
    </body>
</html>