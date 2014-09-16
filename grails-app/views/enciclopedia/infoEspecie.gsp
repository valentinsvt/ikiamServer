<%@ page import="ikiam.Foto; ikiam.Entry; ikiam.Especie; ikiam.Genero" %>

<div class="descripcion especie">

    <g:link controller="especie" action="show" params="[nombre: especie.nombre]" class="btn btn-success pull-right">Ver más</g:link>

    <h3>Especie</h3>

    <div class="row">
        <div class="col-md-4">
            <strong>Nombre científico</strong>
        </div>

        <div class="col-md-8">
            <em>${especie.genero.nombre} ${especie.nombre?.toString()?.decodeURL()}</em>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <strong>Nombre común</strong>
        </div>

        <div class="col-md-8">
            ${especie.nombreComun?.toString()?.decodeURL()}
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <strong>Descripción</strong>
        </div>

        <div class="col-md-8">
            ${especie.descripcion?.toString()?.decodeURL()}
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <g:each in="${Entry.findAllByEspecie(especie)}" var="entry">
                <g:each in="${Foto.findAllByEntry(entry)}" var="foto">
                    <a href="${resource(dir: 'uploaded', file: foto.path)}" class="thumbnail image-popup-vertical-fit">
                        <img src="${resource(dir: 'uploaded', file: foto.path)}" width="150"/>
                    </a>
                </g:each>
            </g:each>
            <g:each in="${Foto.findAllByEspecieAndEntryIsNull(especie)}" var="foto">
                <a href="${resource(dir: 'uploaded', file: foto.path)}" class="thumbnail image-popup-vertical-fit">
                    <img src="${resource(dir: 'uploaded', file: foto.path)}" width="150"/>
                </a>
            </g:each>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('.image-popup-vertical-fit').magnificPopup({
        type                : 'image',
        closeOnContentClick : true,
        mainClass           : 'mfp-img-mobile',
        image               : {
            verticalFit : true
        }
    });
</script>


