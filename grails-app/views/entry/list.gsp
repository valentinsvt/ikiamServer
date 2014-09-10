<%@ page import="ikiam.Entry" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">

        <script src="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.js')}"></script>
        <link href="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.css')}" rel="stylesheet">

        <title>Lista de Entry</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link action="form" class="btn btn-default btnCrear">
                    <i class="fa fa-file-o"></i> Crear
                </g:link>
            </div>

            <div class="btn-group pull-right col-md-3">
                <div class="input-group">
                    <input type="text" id="txtSearch" class="form-control" placeholder="Buscar" value="${params.search}">
                    <span class="input-group-btn">
                        <a href="#" class="btn btn-default btn-search" type="button">
                            <i class="fa fa-search"></i>&nbsp;
                        </a>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>

        <table class="table table-condensed table-bordered table-striped">
            <thead>
                <tr>
                    <th style="width: 155px;">Foto</th>
                    <th>Coordenadas</th>
                    <th>Especie</th>
                    <th>Colores</th>
                    <th>Usuario</th>
                    <th>Fecha</th>
                    %{--<g:sortableColumn property="observaciones" title="Observaciones"/>--}%
                </tr>
            </thead>
            <tbody>
                <g:each in="${entryInstanceList}" status="i" var="entryInstance">
                    <tr data-id="${entryInstance.id}">
                        <td>
                            <g:each in="${entryInstance.fotos}" var="foto">
                                <a href="${resource(dir: 'uploaded', file: foto.path)}" class="thumbnail image-popup-vertical-fit">
                                    <img src="${resource(dir: 'uploaded', file: foto.path)}" width="150"/>
                                </a>
                            </g:each>
                        </td>
                        <td>
                            <g:each in="${entryInstance.fotos}" var="foto">
                                <g:if test="${foto.coordenada}">
                                    <strong>Lat.</strong> ${foto.coordenada.latitud}<br/>
                                    <strong>Long.</strong> ${foto.coordenada.longitud}<br/>
                                    <strong>Alt.</strong> ${foto.coordenada.altitud} msnm
                                </g:if>
                            </g:each>
                        </td>
                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                <strong>${entryInstance.especie?.nombreComun?.toString()?.decodeURL()}</strong><br/>
                                <em>${entryInstance.especie?.genero?.nombre?.toString()?.decodeURL()} ${entryInstance.especie?.nombre?.toString()?.decodeURL()}</em><br/>
                                ${entryInstance.especie?.genero?.familia?.nombre?.toString()?.decodeURL()}
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${entryInstance.especie?.color1?.color}<br/>
                                ${entryInstance.especie?.color2?.color}
                            </elm:textoBusqueda>
                        </td>
                        <td>
                            ${entryInstance.usuario?.nombre?.toString()?.decodeURL()} ${entryInstance.usuario?.apellido?.toString()?.decodeURL()}
                        </td>
                        <td>
                            ${entryInstance.fecha.format("dd-MM-yyyy HH:mm")}
                        </td>
                        %{--<td>--}%
                        %{--<elm:textoBusqueda busca="${params.search}">--}%
                        %{--${entryInstance.observaciones?.toString()?.decodeURL()}--}%
                        %{--</elm:textoBusqueda>--}%
                        %{--</td>--}%

                        %{--<td>--}%
                        %{--${entryInstance.usuario}--}%
                        %{--</td>--}%

                        %{--<td>--}%
                        %{--${entryInstance.especie}--}%
                        %{--</td>--}%

                        %{--<td>--}%
                        %{--<g:formatDate date="${entryInstance.fecha}" format="dd-MM-yyyy"/>--}%
                        %{--</td>--}%

                    </tr>
                </g:each>
            </tbody>
        </table>

        <elm:pagination total="${entryInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;

            function deleteRow(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Entry seleccionado? Esta acción no se puede deshacer.</p>",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        eliminar : {
                            label     : "<i class='fa fa-trash-o'></i> Eliminar",
                            className : "btn-danger",
                            callback  : function () {
                                $.ajax({
                                    type    : "POST",
                                    url     : '${createLink(action:'delete_ajax')}',
                                    data    : {
                                        id : itemId
                                    },
                                    success : function (msg) {
                                        var parts = msg.split("*");
                                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                        if (parts[0] == "SUCCESS") {
                                            location.reload(true);
                                        }
                                    }
                                });
                            }
                        }
                    }
                });
            }

            function buscar() {
                var search = $.trim($("#txtSearch").val());
                location.href = "${createLink(controller: 'entry', action:'list')}?search=" + search;
            }

            $(function () {

                $(".btn-search").click(function () {
                    buscar();
                    return false;
                });
                $("#txtSearch").keyup(function (ev) {
                    if (ev.keyCode == 13) {
                        buscar();
                    }
                });

                $('.image-popup-vertical-fit').magnificPopup({
                    type                : 'image',
                    closeOnContentClick : true,
                    mainClass           : 'mfp-img-mobile',
                    image               : {
                        verticalFit : true
                    }
                });

                $("tbody tr").contextMenu({
                    items  : {
                        header   : {
                            label  : "Acciones",
                            header : true
                        },
                        ver      : {
                            label  : "Ver",
                            icon   : "fa fa-search",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(action: 'show')}/" + id;
                            }
                        },
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'entry', action:'form')}/" + id;
//                                createEditRow(id);
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                deleteRow(id);
                            }
                        }
                    },
                    onShow : function ($element) {
                        $element.addClass("trHighlight");
                    },
                    onHide : function ($element) {
                        $(".trHighlight").removeClass("trHighlight");
                    }
                });
            });
        </script>

    </body>
</html>
