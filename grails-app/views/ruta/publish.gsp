<%--
  Created by IntelliJ IDEA.
  User: svt
  Date: 8/18/2014
  Time: 12:57 PM
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="noMenu">
        <title>Ruta</title>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
        <style type="text/css">

        #map-canvas {
            width                 : 800px;
            height                : 600px;
            border                : solid 4px #9FCF67;
            -webkit-border-radius : 20px;
            -moz-border-radius    : 20px;
            border-radius         : 20px;
        }

        .mapContainer {
            margin-top : 30px;
        }
        </style>
        <g:if test="${cords.size() > 1}">
            <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCJGVHKSrM7bH0suD95ii7bhIp-_29BrSk"></script>
            <script type="text/javascript">
                var lat0 = ${cords.first().latitud?:0};
                var long0 = ${cords.first().longitud?:0};
                var bounds = new google.maps.LatLngBounds();

                var rutaCoords = [];

                var markers = [];

                var imagePin = '${resource(dir:"images/markers", file:"map_marker_photo_32.png")}';

                function initRuta(map) {
                    <g:each in="${cords}" var="coord">
                    var myLatlng = new google.maps.LatLng(${coord.latitud?:0}, ${coord.longitud?:0});
                    rutaCoords.push(myLatlng);
                    bounds.extend(myLatlng);
                    </g:each>

                    var rutaPath = new google.maps.Polyline({
                        path          : rutaCoords,
                        geodesic      : true,
//                    strokeColor   : '#076324',
                        strokeColor   : 'red',
                        strokeOpacity : 1.0,
                        strokeWeight  : 2
                    });

                    rutaPath.setMap(map);
                }

                function initFotos(map) {
                    <g:each in="${fotos}" var="foto">
                    var path = "${resource(dir:'uploaded', file:foto.path)}";
                    var pathThumb = "${resource(dir:'uploaded/markers', file:foto.path)}";
                    var info = "<div id='content'>" +
                               "<img src='" + path + "' width='300' />" +
                               "</div>";
                    %{--setMarker(map, ${foto.coordenada?.latitud?:0}, ${foto.coordenada?.longitud?:0}, "Foto", pathThumb, info);--}%
                    setMarker(map, ${foto.coordenada?.latitud?:0}, ${foto.coordenada?.longitud?:0}, "Foto", pathThumb, info);
                    </g:each>
                }

                function setMarker(map, lat, long, title, icon, infoWindow) {
                    var myLatlng = new google.maps.LatLng(lat, long);

                    var image = {
                        url : icon
                    };

                    // To add the marker to the map, use the 'map' property
                    var marker = new google.maps.Marker({
                        position : myLatlng,
                        icon     : image,
                        title    : title,
                        map      : map
                    });
                    var m = {
                        marker : marker
                    };
                    if (infoWindow) {
                        var infowindow = new google.maps.InfoWindow({
                            content : infoWindow
                        });
                        m.info = infoWindow;

                        google.maps.event.addListener(marker, 'click', function () {
//                        closeAllInfo(marker);
                            infowindow.open(map, marker);
                        });
                    }
                    markers.push(m);
                }

                function closeAllInfo(not) {
                    $.each(markers, function (i, marker) {
                        if (marker.marker != not) {
                            marker.info.close();
                        }
                    });
                }

                function initialize() {
                    var mapOptions = {
                        center : new google.maps.LatLng(lat0, long0),
                        zoom   : 14
                    };
                    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
                    initRuta(map);
                    initFotos(map);
                    map.setOptions({
                        center : bounds.getCenter()
                    });
                    map.fitBounds(bounds);
                }
                google.maps.event.addDomListener(window, 'load', initialize);
            </script>
        </g:if>
    </head>


    <body>
        <g:if test="${cords.size() > 1}">
            <div class="mapContainer" id="map-canvas">
            </div>
        </g:if>
        <g:else>
            <div class="alert alert-danger" style="margin-top: 70px;">
                <p>
                    <i class="fa icon-ghost fa-2x pull-left text-shadow"></i>
                    La ruta seleccionada no tiene información geográfica
                </p>
            </div>
        </g:else>
    </body>
</html>