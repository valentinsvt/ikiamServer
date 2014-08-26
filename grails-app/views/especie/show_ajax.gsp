
<%@ page import="ikiam.Especie" %>

<g:if test="${!especieInstance}">
    <elm:notFound elem="Especie" genero="o" />
</g:if>
<g:else>

    <g:if test="${especieInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${especieInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${especieInstance?.color2}">
        <div class="row">
            <div class="col-md-2 text-info">
                Color2
            </div>
            
            <div class="col-md-3">
                ${especieInstance?.color2?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${especieInstance?.color1}">
        <div class="row">
            <div class="col-md-2 text-info">
                Color1
            </div>
            
            <div class="col-md-3">
                ${especieInstance?.color1?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${especieInstance?.genero}">
        <div class="row">
            <div class="col-md-2 text-info">
                Genero
            </div>
            
            <div class="col-md-3">
                ${especieInstance?.genero?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${especieInstance?.nombreComun}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre Comun
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${especieInstance}" field="nombreComun"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>