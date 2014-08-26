
<%@ page import="ikiam.Entry" %>

<g:if test="${!entryInstance}">
    <elm:notFound elem="Entry" genero="o" />
</g:if>
<g:else>

    <g:if test="${entryInstance?.observaciones}">
        <div class="row">
            <div class="col-md-2 text-info">
                Observaciones
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entryInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entryInstance?.usuario}">
        <div class="row">
            <div class="col-md-2 text-info">
                Usuario
            </div>
            
            <div class="col-md-3">
                ${entryInstance?.usuario?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entryInstance?.especie}">
        <div class="row">
            <div class="col-md-2 text-info">
                Especie
            </div>
            
            <div class="col-md-3">
                ${entryInstance?.especie?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entryInstance?.fecha}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${entryInstance?.fecha}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
</g:else>