<%@ page import="ikiam.Color" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            <g:if test="${especie}">
                ${especie.genero.nombre} ${especie.nombre}
            </g:if>
            <g:else>
                Especie no encontrada
            </g:else>
        </title>

        <link href="${resource(dir: 'css', file: 'CustomSvt.css')}" rel="stylesheet"/>

        <script src="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.js')}"></script>
        <link href="${resource(dir: 'js/plugins/MagnificPopup', file: 'MagnificPopup.css')}" rel="stylesheet">

        <style>
        .bloque {
            width      : 100%;
            margin-top : 10px;
        }

        .descripcion {
            width       : 400px;
            height      : 240px;
            margin-left : 30px;
            font-size   : 16px;
            display     : inline-block;
        }

        .bold {
            font-weight : bold;
        }

        .descripcion_larga {
            width     : 100%;
            font-size : 13px;
        }
        </style>
    </head>

    <body>

        <g:if test="${especie}">
            <h1 style="margin-top: 10px">${especie.genero.nombre} ${especie.nombre}</h1>

            <div class="row">
                <div class="col-md-4">
                    <img src="${g.resource(dir: 'uploaded/', file: entrys[0]?.fotos[0]?.path)}" style="width: 300px;margin-top: 10px;display: inline"/>
                </div>

                <div class="col-md-6" style="margin-left: 20px">
                    <div class="row" style="margin-top: 10px">
                        <div class="labelSvt">Familia:</div>

                        <div class="fieldSvt">${especie.genero.familia.nombre}</div>
                    </div>

                    <div class="row">
                        <div class="labelSvt">Género:</div>

                        <div class="fieldSvt">${especie.genero.nombre}</div>
                    </div>

                    <div class="row">
                        <div class="labelSvt">Especie:</div>

                        <div class="fieldSvt">${especie.nombre}</div>
                    </div>

                    <div class="row">
                        <div class="labelSvt">N. común:</div>

                        <div class="fieldSvt">${especie.nombreComun}</div>
                    </div>

                    <div class="row">
                        <div class="labelSvt">Estado:</div>

                        <div class="col-md-6">
                            ${especie.estado?.descripcion}
                            <div class="ui-corner-all bold" style="width: 30px;height: 30px;line-height:30px;padding-left:6px;background: #${especie.estado?.color};display: inline-block;${(especie.estado?.color == '000000') ? 'color:red;' : ''};margin-left: 10px">${especie.estado?.codigo}</div>
                        </div>
                    </div>
                </div>
            </div>

            <h2 style="margin-top: 10px">Descripción</h2>

            <div class="bloque">
                <div class="descripcion_larga">
                    <g:if test="${especie.descripcion}">
                        ${especie.descripcion}
                    </g:if>
                    <g:else>
                        No hay datos
                    </g:else>
                </div>
            </div>

            <h2 style="margin-top: 10px">Distribución</h2>

            <div class="bloque">
                <div class="descripcion_larga">
                    <g:if test="${especie.distribucion}">
                        ${especie.distribucion}
                    </g:if>
                    <g:else>
                        No hay datos
                    </g:else>
                </div>
            </div>

            <h2 style="margin-top: 10px">Etimología</h2>

            <div class="bloque">
                <div class="descripcion_larga">
                    <g:if test="${especie.etimologia}">
                        ${especie.etimologia}
                    </g:if>
                    <g:else>
                        No hay datos
                    </g:else>
                </div>
            </div>

            <h2 style="margin-top: 10px">Datos adicionales</h2>

            <div class="bloque">
                <div class="descripcion_larga">
                    ${especie.texto}
                </div>
            </div>

            <div class="row" style="margin-left: 0px">
                <g:link action="showFicha" id="${especie.id}" class="btn btn-azul">Ficha técnica</g:link>
                <g:link action="showPapers" id="${especie.id}" class="btn btn-azul">Papers</g:link>
            </div>

            <h2 style="margin-top: 10px">Entradas</h2>

            <div class="row" style="margin-bottom: 20px">
                <g:each in="${entrys}" var="entry">
                    <div class="col-md-2 col-xs-5 ui-corner-all" style="border: 1px solid #0088CC;padding: 3px;margin-left: 10px;margin-top: 10px">
                        <a href="${g.resource(dir: 'uploaded/', file: entry?.fotos[0]?.path)}" class="thumbnail image-popup-vertical-fit">
                            <img src="${g.resource(dir: 'uploaded/', file: entry?.fotos[0]?.path)}" style="width: 100%" class="ui-corner-all">
                        </a>

                        <div style="margin-top: 3px;width: 100%;text-align: center;font-weight: bold">
                            ${entry.fecha.format("dd-MM-yyyy")}
                            <g:link controller="entry" action="show" id="${entry.id}" class="btn btn-success btn-sm pull-right">
                                <i class="fa fa-link"></i> Ver más
                            </g:link>
                        </div>
                    </div>
                </g:each>
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
                });
            </script>
        </g:if>
        <g:else>
            <div class="alert alert-info">
                <i class="fa icon-ghost fa-3x text-shadow pull-left"></i>

                <p>
                    Especie no encontrada!
                </p>
            </div>
        </g:else>
    </body>
</html>