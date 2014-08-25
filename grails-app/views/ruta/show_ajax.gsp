
<%@ page import="ikiam.Ruta" %>

<g:if test="${!rutaInstance}">
    <elm:notFound elem="Ruta" genero="o" />
</g:if>
<g:else>

    <g:if test="${rutaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${rutaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rutaInstance?.fecha}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${rutaInstance?.fecha}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${rutaInstance?.usuario}">
        <div class="row">
            <div class="col-md-2 text-info">
                Usuario
            </div>
            
            <div class="col-md-3">
                ${rutaInstance?.usuario?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>