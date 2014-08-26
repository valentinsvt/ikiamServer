<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de ${className}</title>
    </head>
    <body>

        <elm:message tipo="\${flash.tipo}" clase="\${flash.clase}">\${flash.message}</elm:message>

    <!-- botones -->
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:link action="form" class="btn btn-default btnCrear">
                    <i class="fa fa-file-o"></i> Crear
                </g:link>
            </div>
            <div class="btn-group pull-right col-md-3">
                <div class="input-group">
                    <input type="text" id="txtSearch" class="form-control" placeholder="Buscar" value="\${params.search}">
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
                    <%
                    int cant = 0
                    excludedProps = Event.allEvents.toList() << 'id' << 'version'
                    allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                    props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
                    cant = props.size()
                    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                    props.eachWithIndex { p, i ->
//                        cant = (int)cant+1
                        if (i < 6) {
                            if(!p.name.contains('pass')) {
                            if (p.isAssociation()) { %>
                    <th>${p.naturalName}</th>
                    <%      } else { %>
                    <g:sortableColumn property="${p.name}" title="${p.naturalName}" />
                    <%  }   }   }  } %>
                </tr>
            </thead>
            <tbody>
                <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                    <tr data-id="\${${propertyName}.id}">
                        <%  props.eachWithIndex { p, i ->
                        if (i < 6) {
                            if(!p.name.contains('pass')) {
                            if (p.type == Boolean || p.type == boolean) { %>
                        <td>
                            <g:formatBoolean boolean="\${${propertyName}.${p.name}}" false="No" true="Sí" />
                        </td>
                        <%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                        <td>
                            <g:formatDate date="\${${propertyName}.${p.name}}" format="dd-MM-yyyy" />
                        </td>
                        <%          } else { %>
                        <td><% if(p.type == String) { %>
                            <elm:textoBusqueda busca="\${params.search}">
                                \${${propertyName}.${p.name}?.toString()?.decodeURL()}
                            </elm:textoBusqueda><% } else { %>
                            \${${propertyName}.${p.name}}<% } %>
                        </td>
                        <%  }   }   }   } %>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <elm:pagination total="\${${domainClass.propertyName}InstanceCount}" params="\${params}"/>

        <script type="text/javascript">
            var id = null;
            function submitForm() {
                var \$form = \$("#frm${className}");
                var \$btn = \$("#dlgCreateEdit").find("#btnSave");
                if (\$form.valid()) {
                \$btn.replaceWith(spinner);
                    \$.ajax({
                        type    : "POST",
                        url     : \$form.attr("action"),
                        data    : \$form.serialize(),
                            success : function (msg) {
                        var parts = msg.split("*");
                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                        if (parts[0] == "SUCCESS") {
                            location.reload(true);
                        } else {
                            spinner.replaceWith(\$btn);
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
                              "¿Está seguro que desea eliminar el ${className} seleccionado? Esta acción no se puede deshacer.</p>",
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
                                \$.ajax({
                                    type    : "POST",
                                    url     : '\${createLink(action:'delete_ajax')}',
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
                var data = id ? { id: id } : {};
                \$.ajax({
                    type    : "POST",
                    url     : "\${createLink(action:'form_ajax')}",
                    data    : data,
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgCreateEdit",
                            title   : title + " ${className}",
                            <% if(cant >= 10) { %>
                            class   : "modal-lg",
                            <% } %>
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
                var search = \$.trim(\$("#txtSearch").val());
                location.href = "\${createLink(controller: '${domainClass.propertyName}', action:'list')}?search=" + search;
            }

            \$(function () {

                \$(".btn-search").click(function () {
                    buscar();
                    return false;
                });
                \$("#txtSearch").keyup(function (ev) {
                    if (ev.keyCode == 13) {
                        buscar();
                    }
                });

                \$(".btnCrear").click(function() {
                    createEditRow();
                    return false;
                });

                \$("tbody tr").contextMenu({
                    items  : {
                        header   : {
                            label  : "Acciones",
                            header : true
                        },
                        ver      : {
                            label  : "Ver",
                            icon   : "fa fa-search",
                            action : function (\$element) {
                                var id = \$element.data("id");
                                \$.ajax({
                                    type    : "POST",
                                    url     : "\${createLink(action:'show_ajax')}",
                                    data    : {
                                        id : id
                                    },
                                    success : function (msg) {
                                        bootbox.dialog({
                                            title   : "Ver ${className}",
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
                            action : function (\$element) {
                                var id = \$element.data("id");
                                createEditRow(id);
                            }
                        },
                        eliminar : {
                            label            : "Eliminar",
                            icon             : "fa fa-trash-o",
                            separator_before : true,
                            action           : function (\$element) {
                                var id = \$element.data("id");
                                deleteRow(id);
                            }
                        }
                    },
                    onShow : function (\$element) {
                        \$element.addClass("trHighlight");
                    },
                    onHide : function (\$element) {
                        \$(".trHighlight").removeClass("trHighlight");
                    }
                });
            });
        </script>

    </body>
</html>
