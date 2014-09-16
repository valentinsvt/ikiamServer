<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 15/09/2014
  Time: 21:21
--%>

<%@ page import="ikiam.Especie; ikiam.Familia; ikiam.Genero" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">

        <script src="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.js')}"></script>
        <link href="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.css')}" rel="stylesheet">

        <link rel="stylesheet" href="${resource(dir: 'js/plugins/vakata-jstree-aa240c1/dist/themes/default', file: 'style.min.css')}"/>
        <script src="${resource(dir: 'js/plugins/vakata-jstree-aa240c1/dist', file: 'jstree.min.js')}"></script>

        <script src="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.js')}"></script>
        <link href="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.css')}" rel="stylesheet">

        <script src="${resource(dir: 'js/plugins/highlight', file: 'jquery.highlight.js')}"></script>

        <title>Enciclopedia</title>

        <style type="text/css">
        .side {
            border      : solid 3px #9ECD66;
            height      : 500px;
            overflow    : auto;
            padding-top : 15px;
        }

        .left {
            border-right-width : 1px;
        }

        .right {
            border-left-width : 1px;
        }

        .clickable {
            cursor : pointer;
        }

        .familia, .genero, .especie {
            cursor : zoom-in;
        }

        .familia {
            background : #DDFFDD;
        }

        .genero {
            background : #DDE2FF;
        }

        .especie {
            background : #FFEBDD;
        }

        .descripcion {
            padding : 5px 10px 10px 10px;
        }

        .thumbnail {
            width       : 155px;
            float       : left;
            margin-left : 10px;
        }

        .thumbnail:first-of-type {
            margin-left : 0;
        }


        </style>

    </head>

    <body>

        <div class="row">
            <div class="col-md-4 ">
                <div class="input-group">
                    <input type="text" class="form-control" id="txtBuscar">
                    <span class="input-group-btn" id="btnBuscar">
                        <a href="#" class="btn btn-success">
                            <i class="fa fa-search"></i> Buscar
                        </a>
                    </span>
                </div>
            </div>

            <div class="col-md-6">
                <a href="#" id="btnExpandAll" class="btn btn-default">
                    <i class="fa fa-plus-square"></i> Exapandir todo
                </a>
                <a href="#" id="btnCollapseAll" class="btn btn-default">
                    <i class="fa fa-minus-square"></i> Contraer todo
                </a>
            </div>
        </div>

        <div class="row">
            <div id="divArbol" class="col-md-4 left side ui-corner-left">
                <ul class="ulFamilias list-group">
                    <g:each in="${Familia.list([sort: 'nombre'])}" var="familia">
                        <g:set var="generos" value="${Genero.findAllByFamilia(familia, [sort: 'nombre'])}"/>
                        <g:set var="clase" value="${generos.size() > 0 ? 'fa-plus-square clickable' : 'fa-square'}"/>
                        <li class="familia list-group-item bg-success" id="${familia.id}" data-state="closed">
                            <i class="fa ${clase}"></i>
                            <span class="texto">
                                ${familia.nombre?.toString()?.decodeURL()} <small>(${generos.size()} género${generos.size() == 1 ? '' : 's'})</small>
                            </span>
                        </li>
                        <g:each in="${generos}" var="genero">
                            <g:set var="especies" value="${Especie.findAllByGenero(genero, [sort: 'nombre'])}"/>
                            <g:set var="clase" value="${especies.size() > 0 ? 'fa-plus-square clickable' : 'fa-square'}"/>
                            <li class="genero list-group-item hidden" id="${genero.id}" familia="${familia.id}" data-state="closed">
                                &nbsp;&nbsp;&nbsp;&nbsp;<i class="fa ${clase}"></i>
                                <span class="texto">
                                    ${genero.nombre?.toString()?.decodeURL()} <small>(${especies.size()} especie${especies.size() == 1 ? '' : 's'})</small>
                                </span>
                            </li>
                            <g:each in="${especies}" var="especie">
                                <li class="especie list-group-item hidden" id="${especie.id}" familia="${familia.id}" genero="${genero.id}">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-square"></i>
                                    <span class="texto">
                                        <em>${especie.genero.nombre} ${especie.nombre?.toString()?.decodeURL()}</em>
                                        (${especie.nombreComun})
                                    </span>
                                </li>
                            </g:each>
                        </g:each>
                    </g:each>
                </ul>
            </div>

            <div id="divDescripcion" class="col-md-6 right side ui-corner-right">
            </div>
        </div>

        <script type="text/javascript">

            function showInfo(tipo, id) {
                var url = "";
                switch (tipo) {
                    case "f":
                        url = "${createLink(action: 'infoFamilia')}";
                        break;
                    case "g":
                        url = "${createLink(action: 'infoGenero')}";
                        break;
                    case "e":
                        url = "${createLink(action: 'infoEspecie')}";
                        break;
                }
                if (url != "") {
                    url += "/" + id;
                }
                $.ajax({
                    type    : "POST",
                    url     : url,
                    success : function (msg) {
                        $("#divDescripcion").html(msg);
                    }
                })
            }

            function buscar() {
                var search = $.trim($("#txtBuscar").val());
                $("#divArbol").unhighlight({className : 'found'});
                if (search != "") {
                    $(".familia").each(function () {
//                        console.log($(this).find(".clickable"))
                        hide($(this).find(".clickable"), "f");
                    });
                    $(".familia, .genero, .especie").addClass("hidden");
                    $(".familia:contains('" + search + "')").removeClass("hidden");
                    $(".genero:contains('" + search + "')").each(function () {
                        var familia = $(this).attr("familia");
                        var $familia = $(".familia").find("#" + familia);
                        $familia.removeClass("hidden");
                        show($familia.find(".clickable"), "f");
                    });
                    $(".especie:contains('" + search + "')").each(function () {
                        var familia = $(this).attr("familia");
                        var $familia = $("#" + familia + ".familia");
                        $familia.removeClass("hidden");
                        show($familia.find(".clickable"), "f");
                        var genero = $(this).attr("genero");
                        var $genero = $("#" + genero + ".genero");
                        $genero.removeClass("hidden");
                        show($genero.find(".clickable"), "g");
                        $(this).removeClass("hidden");
                    });
                    $("#divArbol").highlight(search, {className : 'found'});
                } else {
                    $(".familia").each(function () {
                        hide($(this), "f");
                    }).removeClass("hidden");
                }
            }

            function toggle($this, tipo) {
                var $p = $this.parent();
                var id = $p.attr("id");
                var estado = $p.data("state");
                if (estado == "open") { //vamos a cerrar
                    hide($this, tipo);
                } else { //vamos a abrir
                    show($this, tipo);
                }
            }

            function show($this, tipo) {
                var open;
                var $p = $this.parent();
                var id = $p.attr("id");
                switch (tipo) {
                    case "f":
                        open = ".genero[familia=" + id + "]";
                        break;
                    case "g":
                        open = "[genero=" + id + "]";
                        break;
                    case "e":
                        break;
                }
                $(open).removeClass("hidden");
                $p.data("state", "open");
                $this.removeClass("fa-plus-square").addClass("fa-minus-square");
            }

            function hide($this, tipo) {
                var $p = $this.parent();
                var id = $p.attr("id");
                var close;
                switch (tipo) {
                    case "f":
                        close = "[familia=" + id + "]";
                        break;
                    case "g":
                        close = "[genero=" + id + "]";
                        break;
                    case "e":
                        break;
                }

                $(close).addClass("hidden");
                $p.data("state", "closed");
                $this.removeClass("fa-minus-square").addClass("fa-plus-square");
            }

            $(function () {
                $("#divArbol").animate({ scrollTop : 0 }, "slow");
                $(".familia .clickable").click(function () {
                    var $this = $(this);
                    toggle($this, "f");
                });
                $(".genero .clickable").click(function () {
                    var $this = $(this);
                    toggle($this, "g");
                });

                $(".familia").click(function (ev) {
                    if (!$(ev.target).hasClass("clickable")) {
                        showInfo("f", $(this).attr("id"));
                    }
                });
                $(".genero").click(function (ev) {
                    if (!$(ev.target).hasClass("clickable")) {
                        showInfo("g", $(this).attr("id"));
                    }
                });
                $(".especie").click(function () {
                    showInfo("e", $(this).attr("id"));
                });

                $("#txtBuscar").val("").keyup(function (ev) {
                    if (ev.keyCode == 13) {
                        buscar();
                    }
                });

                $("#btnBuscar").click(function () {
                    buscar();
                    return false;
                });

                $("#btnExpandAll").click(function () {
                    $(".familia").each(function () {
                        show($(this).find(".clickable"), "f");
                    });
                    $(".genero").each(function () {
                        show($(this).find(".clickable"), "g");
                    });
                    return false;
                });

                $("#btnCollapseAll").click(function () {
                    $(".familia").each(function () {
                        hide($(this).find(".clickable"), "f");
                    });
                    return false;
                });

            });
        </script>

    </body>
</html>