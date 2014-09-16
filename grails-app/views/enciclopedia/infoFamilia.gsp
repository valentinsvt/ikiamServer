<%@ page import="ikiam.Genero" %>
<div class="descripcion familia">
    <h3>Familia</h3>

    <div class="row">
        <div class="col-md-2">
            <strong>Nombre</strong>
        </div>

        <div class="col-md-10">
            ${familia.nombre?.toString()?.decodeURL()}
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <strong>Géneros</strong>
        </div>

        <div class="col-md-10">
            <g:each in="${Genero.findAllByFamilia(familia, [sort: 'nombre'])}" var="genero">
                ${genero.nombre?.toString()?.decodeURL()}<br/>
            </g:each>
        </div>
    </div>
</div>