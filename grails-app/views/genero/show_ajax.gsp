
<%@ page import="ikiam.Genero" %>

<g:if test="${!generoInstance}">
    <elm:notFound elem="Genero" genero="o" />
</g:if>
<g:else>

    <g:if test="${generoInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${generoInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${generoInstance?.familia}">
        <div class="row">
            <div class="col-md-2 text-info">
                Familia
            </div>
            
            <div class="col-md-3">
                ${generoInstance?.familia?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>