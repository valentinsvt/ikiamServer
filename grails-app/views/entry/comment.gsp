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
        .my-media {
            box-shadow  : 1px 1px 1px #888888;
            /*background : #fff;*/
            padding     : 10px;
            border-top  : solid 1px #ffffff;
            border-left : solid 1px #ffffff;
        }

        .thumbnail {
            margin-bottom : 0;
        }
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
                <div class="col-md-6 col-md-offset-3 col-xs-12">
                    <g:each in="${entryInstance.fotos}" var="foto" status="i">
                        <div class="thumbnail">

                            <a href="${resource(dir: 'uploaded', file: foto.path)}" class="image-popup-vertical-fit">
                                <img class="img-rounded" src="${resource(dir: 'uploaded', file: foto.path)}"/>
                            </a>

                            <div class="caption text-center">
                                <span class="label label-info" style="margin-right: 15px;">
                                    <i class="fa fa-thumbs-o-up"></i> <span id="spanLike${i}">${foto.likes}</span>
                                </span>
                                <g:if test="${usuario}">
                                    <a href="#" class="btn btn-primary" id="btnLike" role="button">
                                        <i class="fa fa-thumbs-o-up"></i> Me gusta
                                    </a>

                                    <a href="#" class="btn btn-danger" id="btnReport" role="button">
                                        <i class="fa fa-warning"></i> Reportar
                                    </a>
                                </g:if>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>

            <div class="row" style="margin-bottom: 25px;">
                <div class="col-md-6 col-md-offset-3 col-xs-12">
                    <div class="thumbnail">
                        <g:if test="${usuario}">
                            <a href="#" class="btn btn-success pull-right" id="btnComentario" title="Nuevo comentario">
                                <i class="fa fa-plus"></i>
                            </a>
                        </g:if>

                        <h3 class="text-center">Comentarios</h3>

                        <div id="divComentarios">
                            <util:renderHTML html="${comentarios}"/>
                        </div>
                    </div>
                </div>
            </div>

            <script type="text/javascript">

                function dialogComentario(idPadre) {
                    var $div = $("<div>");
                    var $i = $("<i class='fa fa-comment-o fa-flip-horizontal fa-3x pull-left text-success text-shadow'></i>");
                    var $txa = $("<textarea class='form-control' maxlength='250' id='txaComentario' cols='5' rows='5'></textarea>");
                    var titulo = "Comentar";
                    var btnGuardar = "<i class='fa fa-comment fa-flip-horizontal'></i> Guardar";
                    if (idPadre) {
                        titulo = "Contestar comentario";
                        $i = $("<i class='fa fa-comments-o fa-flip-horizontal fa-3x pull-left text-success text-shadow'></i>");
                        btnGuardar = "<i class='fa fa-comments fa-flip-horizontal'></i> Guardar";
                    }
                    $txa.maxlength({
                        alwaysShow        : true,
                        warningClass      : "label label-success",
                        limitReachedClass : "label label-danger"
                    });
                    $div.append($i).append($txa);
                    bootbox.dialog({
                        title   : titulo,
                        message : $div,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            aceptar  : {
                                label     : btnGuardar,
                                className : "btn-success",
                                callback  : function () {
                                    var comment = $("#txaComentario").val();
                                    var id = "${entryInstance.id}";
                                    var data = {
                                        id  : id,
                                        com : comment,
                                        usu : "${usuario?.id}"
                                    };
                                    if (idPadre) {
                                        data.padre = idPadre;
                                    }
                                    $.ajax({
                                        type    : "POST",
                                        url     : '${createLink(action:'comentar_ajax')}',
                                        data    : data,
                                        success : function (msg) {
                                            $("#divComentarios").html(msg);
                                        }
                                    });
                                }
                            }
                        }
                    });
                }

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
                                        $("#spanLike" + i).text(parts[i]);
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
                                      "<p>Ingrese la razón por la cual está reportando esta foto:</p>" +
                                      "<p><textarea id='txaRazon' class='form-control' cols='5' rows='5'></textarea></p>" +
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
                                                id    : "${entryInstance.id}",
                                                razon : $.trim($("#txaRazon").val()),
                                                usu   : "${usuario?.id}"
                                            },
                                            success : function (msg) {
                                                var parts = msg.split("*");
                                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                            }
                                        });
                                    }
                                }
                            }
                        });
                        return false;
                    });

                    $(".btnContestar").click(function () {
                        dialogComentario($(this).attr("id"));
                        return false;
                    });

                    $("#btnComentario").click(function () {
                        dialogComentario();
                        return false;
                    });
                });
            </script>
        </g:if>
    </body>
</html>