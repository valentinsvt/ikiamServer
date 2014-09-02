
<%@ page import="ikiam.Paper" %>

<g:if test="${!paperInstance}">
    <elm:notFound elem="Paper" genero="o" />
</g:if>
<g:else>

    <g:if test="${paperInstance?.titulo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Titulo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${paperInstance}" field="titulo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${paperInstance?.path}">
        <div class="row">
            <div class="col-md-2 text-info">
                Path
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${paperInstance}" field="path"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${paperInstance?.especie}">
        <div class="row">
            <div class="col-md-2 text-info">
                Especie
            </div>
            
            <div class="col-md-3">
                ${paperInstance?.especie?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${paperInstance?.fecha}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${paperInstance?.fecha}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
</g:else>