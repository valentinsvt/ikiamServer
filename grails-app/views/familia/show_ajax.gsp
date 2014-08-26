
<%@ page import="ikiam.Familia" %>

<g:if test="${!familiaInstance}">
    <elm:notFound elem="Familia" genero="o" />
</g:if>
<g:else>

    <g:if test="${familiaInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${familiaInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>