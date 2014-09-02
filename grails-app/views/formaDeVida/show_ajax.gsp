
<%@ page import="ikiam.FormaDeVida" %>

<g:if test="${!formaDeVidaInstance}">
    <elm:notFound elem="FormaDeVida" genero="o" />
</g:if>
<g:else>

    <g:if test="${formaDeVidaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${formaDeVidaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>