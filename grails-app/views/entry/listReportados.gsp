<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 08/09/2014
  Time: 23:24
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">

        <title>Lista de entradas reportadas</title>

        <style type="text/css">

        .widget .panel-body {
            padding : 0px;
        }

        .widget .list-group {
            margin-bottom : 0;
        }

        .widget .panel-title {
            display : inline
        }

        .widget .label-info {
            float : right;
        }

        .widget li.list-group-item {
            border-radius : 0;
            border        : 0;
            border-top    : 1px solid #ddd;
        }

        .widget li.list-group-item:hover {
            background-color : rgba(86, 61, 124, .1);
        }

        .widget .mic-info {
            color     : #666666;
            font-size : 11px;
        }

        .widget .action {
            margin-top : 5px;
        }

        .widget .comment-text {
            font-size : 12px;
        }

        .widget .btn-block {
            border-top-left-radius  : 0px;
            border-top-right-radius : 0px;
        }
        </style>
    </head>

    <body>
        <div class="row">
            <div class="panel panel-default widget">
                <div class="panel-heading">
                    <span class="fa fa-comment fa-flip-horizontal"></span>

                    <h3 class="panel-title">
                        Fotos reportadas
                    </h3>
                    <span class="label label-info">
                        ${list.size()}
                    </span>
                </div>

                <div class="panel-body">
                    <g:if test="${list.size() > 0}">
                        <ul class="list-group">
                            <g:each in="${list}" var="entry">
                                <g:each in="${ikiam.ReporteEntry.findAllByEntry(entry, [sort: 'fecha', order: 'desc'])}" var="reporte">
                                    <li class="list-group-item">
                                        <div class="row">
                                            <div class="col-xs-2 col-md-1">
                                                <img src="${resource(dir: 'uploaded', file: entry.fotos.first().path)}" class="img-circle img-responsive"/>
                                            </div>

                                            <div class="col-xs-10 col-md-11">
                                                <div>
                                                    <g:link controller="entry" action="comment" id="${entry.id}">
                                                        ${entry.especie?.nombreComun}
                                                    </g:link>

                                                    <div class="mic-info">
                                                        Reporte de:
                                                        <span class="text-success">${reporte.usuario.nombre} ${reporte.usuario.apellido}, ${reporte.usuario.titulo}</span>
                                                        el ${reporte.fecha.format('dd-MM-yyyy HH:mm')}
                                                    </div>
                                                </div>

                                                <div class="comment-text">
                                                    ${reporte.razon}
                                                </div>

                                                <div class="action">
                                                    <a href="#" id="${entry.id}" class="btn btn-danger btn-sm btnDelete" title="Eliminar esta entrada">
                                                        <span class="fa fa-trash-o"></span>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </g:each>
                            </g:each>
                        </ul>
                    </g:if>
                    <g:else>
                        <div class="alert alert-info">
                            <p>
                                No hay fotos reportadas!!
                            </p>
                        </div>
                    </g:else>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".btnDelete").click(function () {
                    var id = $(this).attr("id");
                    bootbox.dialog({
                        title   : "Alerta",
                        message : "<div class='alert alert-danger' style='padding-bottom: 35px;'>" +
                                  "<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i>" +
                                  "<p>¿Está seguro de querer eliminar esta entrada?</p>" +
                                  "<p>Esta acción no se puede deshacer.</p>" +
                                  "</div>",
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            aceptar  : {
                                label     : "<i class='fa fa-warning'></i> Eliminar",
                                className : "btn-danger",
                                callback  : function () {
                                    openLoader("Eliminando");
                                    $.ajax({
                                        type    : "POST",
                                        url     : '${createLink(action:'delete_ajax')}',
                                        data    : {
                                            id : id
                                        },
                                        success : function (msg) {
                                            var parts = msg.split("*");
                                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                            location.reload(true);
                                        }
                                    });
                                }
                            }
                        }
                    });
                });
            });
        </script>

    </body>
</html>