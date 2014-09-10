<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 30/08/2014
  Time: 19:58
--%>

<%@ page import="ikiam.Color" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            <g:if test="${atraccion.id}">
                Modificar atracción turística
            </g:if>
            <g:else>
                Crear atracción turística
            </g:else>
        </title>

        %{--<link href="${resource(dir: 'css', file: 'debug.css')}" rel="stylesheet"/>--}%

        <style type="text/css">
        .thumbnail {
            max-width  : 200px;
            max-height : 200px;
        }

        .toggle {
            width  : 30px;
            cursor : pointer;
        }

        body {
            padding-right  : 5px;
            padding-bottom : 5px;
            padding-left   : 5px;
        }

        .marginTop {
            margin-top : 10px;
        }

        .map {
            height : 400px;
        }

        form {
            margin-bottom : 15px;
        }
        </style>

    </head>

    <body>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCJGVHKSrM7bH0suD95ii7bhIp-_29BrSk"></script>
        <script type="text/javascript">

            //-0.15398006977473166 -78.47628593444824

            var lat = -0.15398006977473166;
            var lon = -78.47628593444824;
            var alt = 0;
            lat = ${atraccion.coordenada?.latitud?: -0.15398006977473166};
            lon = ${atraccion.coordenada?.longitud?: -78.47628593444824};
            alt = ${atraccion.coordenada?.altitud?: 0};
            var map;
            var myMarker = null;

            var imagePin = '${resource(dir:"images/markers", file:"map_marker_atraccion_48.png")}';

            var elevator = new google.maps.ElevationService();

            function getElevation() {
                var locations = [];

                // Retrieve the clicked location and push it on the array
//                var clickedLocation = event.latLng;
                var clickedLocation = new google.maps.LatLng(lat, lon);
                locations.push(clickedLocation);

                // Create a LocationElevationRequest object using the array's one value
                var positionalRequest = {
                    'locations' : locations
                };
                // Initiate the location request
                elevator.getElevationForLocations(positionalRequest, function (results, status) {
                    if (status == google.maps.ElevationStatus.OK) {
                        // Retrieve the first result
                        if (results[0]) {
                            alt = results[0].elevation;
                            updateAltitude();
//                            $("#divAlt").html("Altitud: " + alt);
                        } else {
//                            alert("No results found");
                            alt = -1;
                            updateAltitude();
//                            $("#divAlt").html("No se encontrar la altitud");
                        }
                    } else {
//                        alert("Elevation service failed due to: " + status);
                        alt = -2;
                        updateAltitude();
//                        $("#divAlt").html("Error al calcular la altitud (" + status + ")");
                    }
                });
                alt = -3;
                updateAltitude();
//                $("#divAlt").html("<i class='fa fa-globe fa-spin'></i> Calculando altitud... ");
            }

            function handleNoGeolocation(errorFlag) {
                var content;
                if (errorFlag) {
                    content = 'Error: The Geolocation service failed.';
                } else {
                    content = 'Error: Your browser doesn\'t support geolocation.';
                }

                var options = {
                    map      : map,
                    position : new google.maps.LatLng(lat, lon),
                    content  : content
                };

                var infowindow = new google.maps.InfoWindow(options);
                map.setCenter(options.position);
            }

            function updateCoords() {
//                var str = "Latitud: " + lat + "<br/>Longitud: " + lon + getElevation(null);
//                $("#coords").html(str);
                $("#divLat").html("Latitud: " + lat);
                $("#divLon").html("Longitud: " + lon);
                $("#latitud").val(lat);
                $("#longitud").val(lon);
                getElevation(null);
//                $("#divAlt").html(getElevation(null));
            }
            function updateAltitude() {
                if (alt >= 0) {
                    $("#divAlt").html("Altitud: " + alt);
                } else if (alt == -1) {
                    $("#divAlt").html("No se encontrar la altitud");
                    alt = 0;
                } else if (alt == -2) {
                    $("#divAlt").html("Error al calcular la altitud (" + status + ")");
                    alt = 0;
                } else if (alt == -3) {
                    $("#divAlt").html("<i class='fa fa-globe fa-spin'></i> Calculando altitud... ");
                    alt = 0;
                }
                $("#altitud").val(alt);
            }

            function setMarker() {
                var position = new google.maps.LatLng(lat, lon);
                if (myMarker == null) {
                    myMarker = new google.maps.Marker({
                        position  : position,
                        draggable : true,
                        icon      : imagePin,
                        animation : google.maps.Animation.DROP,
                        map       : map
                    });

                    google.maps.event.addListener(myMarker, 'dragend', function (evt) {
                        lat = evt.latLng.lat();
                        lon = evt.latLng.lng();
                        updateCoords();
                    });
                } else {
                    if (myMarker != null) {
                        myMarker.setPosition(position);
                    }
                }
                updateCoords();
            }

            function initialize() {

                var mapOptions = {
                    center : new google.maps.LatLng(lat, lon),
                    zoom   : 6
                };
                map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

                setMarker();

//                // Try HTML5 geolocation
//                if (navigator.geolocation) {
//                    navigator.geolocation.getCurrentPosition(function (position) {
//                        var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
//                        lat = position.coords.latitude;
//                        lon = position.coords.longitude;
//                        setMarker();
//                        map.setCenter(pos);
//                    }, function () {
//                        handleNoGeolocation(true);
//                        setMarker();
//                    });
//                } else {
//                    // Browser doesn't support Geolocation
//                    handleNoGeolocation(false);
//                    setMarker();
//                }

                google.maps.event.addListener(map, 'click', function (event) {
                    lat = event.latLng.lat();
                    lon = event.latLng.lng();
                    setMarker();
                });

            }
            google.maps.event.addDomListener(window, 'load', initialize);


        </script>

        <div class="btn-group">
            <g:link action="list" class="btn btn-default"><i class="fa fa-list"></i> Lista</g:link>
            <a href="#" class="btn btn-success btnSave">
                <i class="fa fa-save"></i> Guardar
            </a>
        </div>

        <g:uploadForm class="form-horizontal" role="form" name="frmSave" id="${atraccion.id}" action="save">
            <g:hiddenField name="latitud" value="${atraccion.coordenada?.latitud ?: 0}"/>
            <g:hiddenField name="longitud" value="${atraccion.coordenada?.longitud ?: 0}"/>
            <g:hiddenField name="altitud" value="${atraccion.coordenada?.altitud ?: 0}"/>

            <div class="row">
                <div class="col-xs-10 col-xs-offset-2 col-md-3 col-md-offset-0">
                    <a href="#" class="thumbnail">
                        <g:set var="src" value="${resource(dir: 'images', file: 'default-placeholder.png')}"/>
                        <g:if test="${atraccion.fotos?.size() > 0}">
                            <g:set var="src" value="${resource(file: atraccion.fotos.first().path)}"/>
                        </g:if>
                        <img id="preview" src="${src}" alt="">
                    </a>
                    <input type="file" name="file" id="file"/>
                </div>

                <div class="col-xs-12 col-md-4">
                    <div class="form-group">
                        <label for="descripcion" class="col-xs-12 col-md-12 control-label marginTop text-left">
                            Descripción
                        </label>

                        <div class="col-xs-12 col-md-12 marginTop">
                            <g:textArea name="descripcion" class="form-control" style="height:180px;"
                                        value="${atraccion.descripcion}"/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12 col-md-4">
                    <div class="form-group">
                        <div class="grupo">
                            <label for="nombre" class="col-xs-3 control-label marginTop">Nombre</label>

                            <div class="col-xs-9 marginTop">
                                <g:textField name="nombre" class="form-control required"
                                             value="${atraccion?.nombre}"/>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="grupo">
                            <label for="url" class="col-xs-3 control-label marginTop">URL</label>

                            <div class="col-xs-9 marginTop">
                                <div class="input-group">
                                    <div class="input-group-addon"><i class="fa fa-globe"></i></div>
                                    <g:textField name="url" class="form-control required url"
                                                 value="${atraccion?.url}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="row">
                <div class="col-xs-11 col-md-6 map" id="map-canvas"></div>

                <div class="col-xs-12 col-md-6 marginTop" id="coords">
                    <div id="divLat">
                        <i class="fa fa-compass fa-spin"></i> Calculando coordenadas...
                    </div>

                    <div id="divLon"></div>

                    <div id="divAlt"></div>
                </div>

            </div>

            <div class="row text-center">
                <a href="#" class="btn btn-success btnSave">
                    <i class="fa fa-save"></i> Guardar
                </a>
            </div>
        </g:uploadForm>

        <script type="text/javascript">

            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#preview').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $(function () {

                $(".btnSave").click(function () {
                    $("#frmSave").submit();
                });

                $("#frmSave").validate({
                    errorClass     : "help-block",
                    errorPlacement : function (error, element) {
                        if (element.parent().hasClass("input-group")) {
                            error.insertAfter(element.parent());
                        } else {
                            error.insertAfter(element);
                        }
                        element.parents(".grupo").addClass('has-error');
                    },
                    success        : function (label) {
                        label.parents(".grupo").removeClass('has-error');
                    }
                });

                $("#file").change(function () {
                    readURL(this);
                });

            });
        </script>

    </body>
</html>