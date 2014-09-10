<%@ page import="ikiam.AtraccionTuristica" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de AtraccionTuristica</title>
    </head>

    <body>

        <elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

        <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link action="form" class="btn btn-default">
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

                    <g:sortableColumn property="nombre" title="Nombre"/>

                    <g:sortableColumn property="url" title="Url"/>

                    <th>Coordenada</th>

                    <g:sortableColumn property="fecha" title="Fecha"/>

                    <g:sortableColumn property="likes" title="Likes"/>

                </tr>
            </thead>
            <tbody>
                <g:each in="${atraccionTuristicaInstanceList}" status="i" var="atraccionTuristicaInstance">
                    <tr data-id="${atraccionTuristicaInstance.id}">

                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${atraccionTuristicaInstance.nombre?.toString()?.decodeURL()}
                            </elm:textoBusqueda>
                        </td>

                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${atraccionTuristicaInstance.url?.toString()?.decodeURL()}
                            </elm:textoBusqueda>
                        </td>

                        <td>
                            ${atraccionTuristicaInstance.coordenada}
                        </td>

                        <td>
                            <g:formatDate date="${atraccionTuristicaInstance.fecha}" format="dd-MM-yyyy"/>
                        </td>

                        <td>
                            ${atraccionTuristicaInstance.likes}
                        </td>

                    </tr>
                </g:each>
            </tbody>
        </table>

        <elm:pagination total="${atraccionTuristicaInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;

            function deleteRow(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el AtraccionTuristica seleccionado? Esta acción no se puede deshacer.</p>",
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
                location.href = "${createLink(controller: 'atraccionTuristica', action:'list')}?search=" + search;
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
                                location.href = "${createLink(action:'show')}/" + id
                            }
                        },
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(action:'form')}/" + id;
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
