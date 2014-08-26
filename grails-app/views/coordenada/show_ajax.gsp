
<%@ page import="ikiam.Coordenada" %>

<g:if test="${!coordenadaInstance}">
    <elm:notFound elem="Coordenada" genero="o" />
</g:if>
<g:else>

    <g:if test="${coordenadaInstance?.ruta}">
        <div class="row">
            <div class="col-md-2 text-info">
                Ruta
            </div>
            
            <div class="col-md-3">
                ${coordenadaInstance?.ruta?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${coordenadaInstance?.altitud}">
        <div class="row">
            <div class="col-md-2 text-info">
                Altitud
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${coordenadaInstance}" field="altitud"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${coordenadaInstance?.latitud}">
        <div class="row">
            <div class="col-md-2 text-info">
                Latitud
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${coordenadaInstance}" field="latitud"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${coordenadaInstance?.longitud}">
        <div class="row">
            <div class="col-md-2 text-info">
                Longitud
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${coordenadaInstance}" field="longitud"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>