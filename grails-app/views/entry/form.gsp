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
            <g:if test="${entry.id}">
                Modificar especie
            </g:if>
            <g:else>
                Crear especie
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
            <g:if test="${entry.fotos?.size() > 0}">
            lat = ${entry.fotos.first().coordenada?.latitud?: -0.15398006977473166};
            lon = ${entry.fotos.first().coordenada?.longitud?: -78.47628593444824};
            alt = ${entry.fotos.first().coordenada?.altitud?: 0};
            </g:if>
            var map;
            var myMarker = null;

            var imagePin = '${resource(dir:"images/markers", file:"map_marker_photo_48.png")}';

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

                // Try HTML5 geolocation
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function (position) {
                        var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                        lat = position.coords.latitude;
                        lon = position.coords.longitude;
                        setMarker();
                        map.setCenter(pos);
                    }, function () {
                        handleNoGeolocation(true);
                        setMarker();
                    });
                } else {
                    // Browser doesn't support Geolocation
                    handleNoGeolocation(false);
                    setMarker();
                }

                google.maps.event.addListener(map, 'click', function (event) {
                    lat = event.latLng.lat();
                    lon = event.latLng.lng();
                    setMarker();
                });

            }
            google.maps.event.addDomListener(window, 'load', initialize);


        </script>

        <g:uploadForm class="form-horizontal" role="form" name="frmSave" id="${entry.id}" action="save">
            <g:hiddenField name="animal" value="${entry.fotos?.first()?.keyWords?.contains('animal') ? 'on' : 'off'}"/>
            <g:hiddenField name="arbol" value="${entry.fotos?.first()?.keyWords?.contains('arbol') ? 'on' : 'off'}"/>
            <g:hiddenField name="corteza" value="${entry.fotos?.first()?.keyWords?.contains('corteza') ? 'on' : 'off'}"/>
            <g:hiddenField name="hoja" value="${entry.fotos?.first()?.keyWords?.contains('hoja') ? 'on' : 'off'}"/>
            <g:hiddenField name="flor" value="${entry.fotos?.first()?.keyWords?.contains('flor') ? 'on' : 'off'}"/>
            <g:hiddenField name="fruta" value="${entry.fotos?.first()?.keyWords?.contains('fruta') ? 'on' : 'off'}"/>

            <g:hiddenField name="latitud" value="${entry.fotos?.first()?.coordenada?.latitud ?: 0}"/>
            <g:hiddenField name="longitud" value="${entry.fotos?.first()?.coordenada?.longitud ?: 0}"/>
            <g:hiddenField name="altitud" value="${entry.fotos?.first()?.coordenada?.altitud ?: 0}"/>

            <div class="row">
                <div class="col-xs-12 col-md-3">
                    <a href="#" class="thumbnail">
                        <g:set var="src" value="${resource(dir: 'images', file: 'default-placeholder.png')}"/>
                        <g:if test="${entry.fotos?.size() > 0}">
                            <g:set var="src" value="${resource(dir: 'uploaded', file: entry.fotos.first().path)}"/>
                        </g:if>
                        <img id="preview" src="${src}" alt="">
                    </a>
                    <input type="file" name="file" id="file"/>
                </div>

                <div class="col-xs-12 col-md-3">
                    <div class="form-group">
                        <label for="observaciones" class="col-xs-12 col-md-12 control-label marginTop text-left">
                            Observaciones
                        </label>

                        <div class="col-xs-12 col-md-12 marginTop">
                            <g:textArea name="observaciones" class="form-control" style="height:180px;"
                                        value="${entry.observaciones}"/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12 col-md-3">
                    <div class="row">
                        <div class="col-xs-4 col-md-4 text-center">
                            <img class="toggle animal" data-key="animal" data-status="${entry.fotos?.first()?.keyWords?.contains('animal') ? 'on' : 'off'}"
                                 src="${resource(dir: 'images', file: 'ic_menu_animal.png')}" alt="">
                        </div>

                        <div class="col-xs-4 col-md-4 text-center">
                            <img class="toggle" data-key="arbol" data-status="${entry.fotos?.first()?.keyWords?.contains('arbol') ? 'on' : 'off'}"
                                 src="${resource(dir: 'images', file: 'ic_menu_tree.png')}" alt="">
                        </div>

                        <div class="col-xs-4 col-md-4 text-center">
                            <img class="toggle" data-key="corteza" data-status="${entry.fotos?.first()?.keyWords?.contains('corteza') ? 'on' : 'off'}"
                                 src="${resource(dir: 'images', file: 'ic_menu_bark.png')}" alt="">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-4 col-md-4 text-center">
                            <img class="toggle" data-key="hoja" data-status="${entry.fotos?.first()?.keyWords?.contains('hoja') ? 'on' : 'off'}"
                                 src="${resource(dir: 'images', file: 'ic_menu_leaf.png')}" alt="">
                        </div>

                        <div class="col-xs-4 col-md-4 text-center">
                            <img class="toggle" data-key="flor" data-status="${entry.fotos?.first()?.keyWords?.contains('flor') ? 'on' : 'off'}"
                                 src="${resource(dir: 'images', file: 'ic_menu_flower.png')}" alt="">
                        </div>

                        <div class="col-xs-4 col-md-4 text-center">
                            <img class="toggle" data-key="fruta" data-status="${entry.fotos?.first()?.keyWords?.contains('fruta') ? 'on' : 'off'}"
                                 src="${resource(dir: 'images', file: 'ic_menu_apple.png')}" alt="">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group">
                            <label for="color1" class="col-xs-5 col-md-6 control-label">Color principal</label>

                            <div class="col-xs-7 col-md-6">
                                <g:select class="form-control" name="color1" from="${Color.list()}"
                                          optionKey="id" value="${entry?.especie?.color1Id}"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group">
                            <label for="color2" class="col-xs-5 col-md-6 control-label">Color secundario</label>

                            <div class="col-xs-7 col-md-6">
                                <g:select class="form-control" name="color2" from="${Color.list()}" optionKey="id"
                                          noSelection="['': '- Ninguno -']" value="${entry?.especie?.color2Id}"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <div class="grupo">
                        <label for="nombreComun" class="col-xs-5 col-md-2 control-label marginTop">Nombre común</label>

                        <div class="col-xs-7 col-md-3 marginTop">
                            <g:textField name="nombreComun" class="form-control required"
                                         value="${entry?.especie?.nombreComun}"/>
                        </div>
                    </div>

                    <div class="grupo">
                        <label for="familia" class="col-xs-5 col-md-2 control-label marginTop">Familia</label>

                        <div class="col-xs-7 col-md-3 marginTop">
                            <g:textField name="familia" class="form-control required"
                                         value="${entry?.especie?.genero?.familia?.nombre}"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <div class="grupo">
                        <label for="genero" class="col-xs-5 col-md-2 control-label marginTop">Género</label>

                        <div class="col-xs-7 col-md-3 marginTop">
                            <g:textField name="genero" class="form-control required"
                                         value="${entry?.especie?.genero?.nombre}"/>
                        </div>
                    </div>

                    <div class="grupo">
                        <label for="especie" class="col-xs-5 col-md-2 control-label marginTop">Especie</label>

                        <div class="col-xs-7 col-md-3 marginTop">
                            <g:textField name="especie" class="form-control required"
                                         value="${entry?.especie?.nombre}"/>
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
                <a href="#" class="btn btn-success" id="btnSave">
                    <i class="fa fa-save"></i> Guardar
                </a>
            </div>
        </g:uploadForm>

        <script type="text/javascript">

            function setStatus($toggle) {
                var $parent = $toggle.parent();
                var status = $toggle.data("status");
                var str = "Sí";
                if (status == "off") {
                    str = "No";
                }
                var $span = $("<span>" + str + "</span>");
                $toggle.after($span);

                var pWidth = $parent.innerWidth();
                var pHeight = $parent.innerHeight();

                $parent.css({
                    position : "relative"
                });
                $span.css({
                    cursor   : "pointer",
                    position : "absolute",
                    top      : (pHeight / 2) - ($span.innerHeight / 2)

                });
                $span.click(function () {
                    toggleStatus($toggle);
                });
                var id = $toggle.data("key");
                $("#" + id).val(status);
            }
            function toggleStatus($toggle) {
                var status = $toggle.data("status");
                var id = $toggle.data("key");

//                console.log(id, status);
                if (id == "animal") {
                    if (status == "off") { //se va a activar el de animal: se desactivan todos los otros
                        $(".toggle").not($toggle).each(function () {
                            updateStatus($(this), false);
                        });
                    }
                } else {
                    if (status == "off") { //se va a activar uno de planta: se desactiva el de animal
                        updateStatus($(".toggle.animal"), false);
                    }
                }

                var str = "Sí";
                if (status == "off") {
                    $toggle.data("status", "on");
                    str = "Sí";
                } else {
                    $toggle.data("status", "off");
                    str = "No";
                }
                var $span = $toggle.siblings("span");
                $span.text(str);
                $("#" + id).val(status);
            }

            function updateStatus($toggle, isOn) {
                var id = $toggle.data("key");
                var status;
                var str = "Sí";
                if (isOn) {
                    str = "Sí";
                    status = "on";
                } else {
                    str = "No";
                    status = "off";
                }
                $toggle.data("status", status);
                var $span = $toggle.siblings("span");
                $span.text(str);
                $("#" + id).val(status);
            }

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
                $(".toggle").each(function () {
                    setStatus($(this));
                }).click(function () {
                    toggleStatus($(this));
                });

                $("#btnSave").click(function () {
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