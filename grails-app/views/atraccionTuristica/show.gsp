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
        <title>${atraccionInstance.nombre}</title>

        <style type="text/css">
        .map {
            height : 400px;
        }
        </style>
    </head>

    <body>

        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCJGVHKSrM7bH0suD95ii7bhIp-_29BrSk"></script>
        <script type="text/javascript">

            //-0.15398006977473166 -78.47628593444824

            var lat = -0.15398006977473166;
            var lon = -78.47628593444824;

            var map;
            var myMarker = null;

            function putMarker(position, imagePin) {
                myMarker = new google.maps.Marker({
                    position  : position,
                    draggable : true,
                    icon      : imagePin,
                    animation : google.maps.Animation.DROP,
                    map       : map
                });
            }

            function initialize() {

                var mapOptions = {
                    center : new google.maps.LatLng(lat, lon),
                    zoom   : 10
                };
                map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

                var bounds = new google.maps.LatLngBounds();

                lat = ${atraccionInstance.coordenada.latitud?:0};
                lon = ${atraccionInstance.coordenada.longitud?:0};
                var myLatlng = new google.maps.LatLng(lat, lon);
                bounds.extend(myLatlng);
                var imagePin = "${resource(dir:'atraccion/markers', file:(atraccionInstance.fotos && atraccionInstance.fotos.size()>0)?atraccionInstance.fotos.first().path:'')}";
                putMarker(myLatlng, imagePin);
            }
            google.maps.event.addDomListener(window, 'load', initialize);
        </script>

        <h1 style="margin-top: 10px">${atraccionInstance.nombre}</h1>

        <g:each in="${atraccionInstance.fotos}" var="foto" status="i">
            <div class="row">
                <div class="col-md-6 col-xs-12">
                    <div class="thumbnail">
                        <a href="${resource(file: foto.path)}" class="image-popup-vertical-fit">
                            <img class="img-rounded" src="${resource(file: foto.path)}"/>
                        </a>
                    </div>
                </div>

                <div class="col-md-6 col-xs-12">
                    <div class="row">
                        <div class="col-md-2 col-xs-4">
                            <strong>Nombre</strong>
                        </div>

                        <div class="col-md-6 col-xs-8">
                            ${atraccionInstance.nombre}
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-2 col-xs-4">
                            <strong>URL</strong>
                        </div>

                        <div class="col-md-6 col-xs-8">
                            <a href="${atraccionInstance.url}" target="_blank">
                                ${atraccionInstance.url}
                            </a>
                        </div>
                    </div>

                    <div class="row" style="margin-bottom: 20px;">
                        <div class="col-xs-12">
                            <strong>Descripción</strong>
                        </div>

                        <div class="col-xs-12">
                            ${atraccionInstance.descripcion}
                        </div>
                    </div>
                </div>
            </div>

            <div class="row" style="margin-bottom: 20px;">
                <div class="col-xs-11 col-md-6 map" id="map-canvas"></div>
            </div>
        </g:each>
    </body>
</html>