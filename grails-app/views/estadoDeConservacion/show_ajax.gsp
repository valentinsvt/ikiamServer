
<%@ page import="ikiam.EstadoDeConservacion" %>

<g:if test="${!estadoDeConservacionInstance}">
    <elm:notFound elem="EstadoDeConservacion" genero="o" />
</g:if>
<g:else>

    <g:if test="${estadoDeConservacionInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estadoDeConservacionInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estadoDeConservacionInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estadoDeConservacionInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${estadoDeConservacionInstance?.color}">
        <div class="row">
            <div class="col-md-2 text-info">
                Color
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estadoDeConservacionInstance}" field="color"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>