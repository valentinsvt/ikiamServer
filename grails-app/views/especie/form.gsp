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
       Especie
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

<g:uploadForm class="form-horizontal especieForm" role="form" name="frmSave" action="saveTextos">
<input type="hidden" name="id" value="${especie?.id}">
    <div class="row">
        <g:link action="fichaAnimal" class="btn btn-success " id="${especie.id}" >Ficha técnica animal</g:link>
        <g:link action="fichaPlanta" class="btn btn-success" id="${especie.id}" >Ficha técnica planta</g:link>
    </div>
    <div class="row">
        <div class="col-xs-12 col-md-3">
            Estado de conservación:
        </div>
        <div class="col-xs-12 col-md-3">
            <g:select name="estado.id" from="${ikiam.EstadoDeConservacion.list([sort: 'id'])}" optionKey="id" optionValue="descripcion" id="estado"></g:select>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12 col-md-3">
            Descripción:
        </div>
    </div>
    <div class="row">
            <textarea name="descripcion" id="descripcion" style="height: 300px;width: 800px">
                ${especie?.descripcion}
            </textarea>
    </div>
    <div class="row">
        <div class="col-xs-12 col-md-3">
            Distribución:
        </div>
    </div>
    <div class="row">
        <textarea name="distribucion" id="dist" style="height: 300px;width: 800px">
            ${especie?.distribucion}
        </textarea>
    </div>
    <div class="row">
        <div class="col-xs-12 col-md-3">
            Etimología:
        </div>
    </div>
    <div class="row">
        <textarea name="etimologia" id="eti" style="height: 300px;width: 800px">
            ${especie?.etimologia}
        </textarea>
    </div>
    <div class="row">
        <div class="col-xs-12 col-md-3">
            Texto:
        </div>
    </div>
    <div class="row">
        <textarea name="texto" id="texto" style="height: 300px;width: 800px">
            ${especie?.texto}
        </textarea>
    </div>

    <div class="row text-center">
        <a href="#" class="btn btn-success" id="btnSave" style="float: left">
            <i class="fa fa-save"></i> Guardar
        </a>
    </div>
</g:uploadForm>
<script>
    $("#btnSave").click(function(){
        $(".especieForm").submit()
    })
</script>

</body>
</html>