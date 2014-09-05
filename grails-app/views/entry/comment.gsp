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
        %{--<link href="${resource(dir: 'css', file: 'debug.css')}" rel="stylesheet"/>--}%
        <title>Comentarios de foto</title>

        <style type="text/css">

        </style>

    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <g:if test="${entryInstance}">
            <g:if test="${entryInstance.usuario}">
                <div class="row">
                    <div class="col-md-3 col-xs-4">
                        Foto por:
                    </div>

                    <div class="col-md-9 col-xs-8">
                        ${entryInstance.usuario?.nombre?.toString()?.decodeURL()} ${entryInstance.usuario?.apellido?.toString()?.decodeURL()}, ${entryInstance.usuario?.titulo}
                    </div>
                </div>
            </g:if>

            <div class="row">
                <div class="col-md-12 col-xs-12">
                    <g:each in="${entryInstance.fotos}" var="foto" status="i">
                        <div class="thumbnail">

                            <a href="${resource(dir: 'uploaded', file: foto.path)}" class="image-popup-vertical-fit">
                                <img src="${resource(dir: 'uploaded', file: foto.path)}"/>
                            </a>

                            <div class="caption text-center">
                                <span class="label label-info" style="margin-right: 15px;">
                                    <i class="fa fa-thumbs-o-up"></i> <span id="spanLike${i}">${foto.likes}</span>
                                </span>

                                <a href="#" class="btn btn-primary" id="btnLike" role="button">
                                    <i class="fa fa-thumbs-o-up"></i> Me gusta
                                </a>

                                <a href="#" class="btn btn-danger" id="btnReport" role="button">
                                    <i class="fa fa-warning"></i> Reportar
                                </a>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>

            <div class="row">

            </div>

            <script type="text/javascript">
                $(function () {

                    $('.image-popup-vertical-fit').magnificPopup({
                        type                : 'image',
                        closeOnContentClick : true,
                        mainClass           : 'mfp-img-mobile',
                        image               : {
                            verticalFit : true
                        }
                    });

                    $("#btnLike").click(function () {
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'like_ajax')}',
                            data    : {
                                id : "${entryInstance.id}"
                            },
                            success : function (msg) {
                                console.log(msg);
                                var parts = msg.split("*");
//                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    parts = parts[1].split("_");
                                    console.log(parts);
                                    for (var i = 0; i < parts.length; i++) {
                                        $("spanLike" + i).text(parts[i]);
                                        console.log("spanLike" + i, $("spanLike" + i));
                                    }
                                } else {
                                    log(parts[1], "error");
                                }
                            }
                        });
                    });

                    $("#btnReport").click(function () {
                        bootbox.dialog({
                            title   : "Alerta",
                            message : "<div class='alert alert-danger' style='padding-bottom: 35px;'>" +
                                      "<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i>" +
                                      "<p>¿Está seguro de querer reportar esta foto como ofensiva?</p>" +
                                      "</div>",
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                aceptar  : {
                                    label     : "<i class='fa fa-warning'></i> Reportar",
                                    className : "btn-danger",
                                    callback  : function () {
                                        $.ajax({
                                            type    : "POST",
                                            url     : '${createLink(action:'reportar_ajax')}',
                                            data    : {
                                                id : "${entryInstance.id}"
                                            },
                                            success : function (msg) {
                                                var parts = msg.split("*");
                                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                                if (parts[0] == "SUCCESS") {

                                                } else {
                                                    log(parts[1], "error");
                                                }
                                            }
                                        });
                                    }
                                }
                            }
                        });
                        return false;
                    });
                });
            </script>
        </g:if>
    </body>
</html>