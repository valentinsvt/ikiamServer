<%@ page import="ikiam.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Usuario</title>
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

                    <g:sortableColumn property="email" title="Email"/>

                    <g:sortableColumn property="esAdmin" title="Es Admin"/>

                    <g:sortableColumn property="esCientifico" title="Es Cientifico"/>

                    <g:sortableColumn property="nombre" title="Nombre"/>

                    <g:sortableColumn property="apellido" title="Apellido"/>

                    <g:sortableColumn property="titulo" title="Titulo"/>

                </tr>
            </thead>
            <tbody>
                <g:each in="${usuarioInstanceList}" status="i" var="usuarioInstance">
                    <tr data-id="${usuarioInstance.id}">

                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${usuarioInstance.email?.toString()?.decodeURL()}
                            </elm:textoBusqueda>
                        </td>

                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${usuarioInstance.esAdmin == 'S' ? 'Sí' : 'No'}
                            </elm:textoBusqueda>
                        </td>

                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${usuarioInstance.esCientifico == 'S' ? 'Sí' : 'No'}
                            </elm:textoBusqueda>
                        </td>

                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${usuarioInstance.nombre?.toString()?.decodeURL()}
                            </elm:textoBusqueda>
                        </td>

                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${usuarioInstance.apellido?.toString()?.decodeURL()}
                            </elm:textoBusqueda>
                        </td>

                        <td>
                            <elm:textoBusqueda busca="${params.search}">
                                ${usuarioInstance.titulo?.toString()?.decodeURL()}
                            </elm:textoBusqueda>
                        </td>

                    </tr>
                </g:each>
            </tbody>
        </table>

        <elm:pagination total="${usuarioInstanceCount}" params="${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitForm() {
                var $form = $("#frmUsuario");
                var $btn = $("#dlgCreateEdit").find("#btnSave");
                if ($form.valid()) {
                    $btn.replaceWith(spinner);
                    $.ajax({
                        type    : "POST",
                        url     : $form.attr("action"),
                        data    : $form.serialize(),
                        success : function (msg) {
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                location.reload(true);
                            } else {
                                spinner.replaceWith($btn);
                                return false;
                            }
                        }
                    });
                } else {
                    return false;
                } //else
            }
            function deleteRow(itemId) {
                bootbox.dialog({
                    title   : "Alerta",
                    message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                              "¿Está seguro que desea eliminar el Usuario seleccionado? Esta acción no se puede deshacer.</p>",
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
            function createEditRow(id) {
                var title = id ? "Editar" : "Crear";
                var data = id ? { id : id } : {};
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id    : "dlgCreateEdit",
                            title : title + " Usuario",

                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                guardar  : {
                                    id        : "btnSave",
                                    label     : "<i class='fa fa-save'></i> Guardar",
                                    className : "btn-success",
                                    callback  : function () {
                                        return submitForm();
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            } //createEdit

            function buscar() {
                var search = $.trim($("#txtSearch").val());
                location.href = "${createLink(controller: 'usuario', action:'list')}?search=" + search;
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

                $(".btnCrear").click(function () {
                    createEditRow();
                    return false;
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
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(action:'show_ajax')}",
                                    data    : {
                                        id : id
                                    },
                                    success : function (msg) {
                                        bootbox.dialog({
                                            title   : "Ver Usuario",
                                            message : msg,
                                            buttons : {
                                                ok : {
                                                    label     : "Aceptar",
                                                    className : "btn-primary",
                                                    callback  : function () {
                                                    }
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        editar   : {
                            label  : "Editar",
                            icon   : "fa fa-pencil",
                            action : function ($element) {
                                var id = $element.data("id");
                                createEditRow(id);
                            }
                        },
                        fotos    : {
                            label            : "Fotos",
                            icon             : "fa fa-photo",
                            separator_before : true,
                            action           : function ($element) {
                                var id = $element.data("id");
                                location.href = "${createLink(controller: 'foto', action: 'fotosUsuario')}/" + id;
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
