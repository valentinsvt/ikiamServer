<%@ page import="ikiam.Especie; ikiam.Genero" %>
<div class="descripcion genero">
    <h3>Género</h3>

    <div class="row">
        <div class="col-md-2">
            <strong>Nombre</strong>
        </div>

        <div class="col-md-10">
            ${genero.nombre?.toString()?.decodeURL()}
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <strong>Especies</strong>
        </div>

        <div class="col-md-10">
            <g:each in="${Especie.findAllByGenero(genero, [sort: 'nombre'])}" var="especie">
                ${especie.nombre?.toString()?.decodeURL()}<br/>
            </g:each>
        </div>
    </div>
</div>