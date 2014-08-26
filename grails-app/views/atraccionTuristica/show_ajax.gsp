
<%@ page import="ikiam.AtraccionTuristica" %>

<g:if test="${!atraccionTuristicaInstance}">
    <elm:notFound elem="AtraccionTuristica" genero="o" />
</g:if>
<g:else>

    <g:if test="${atraccionTuristicaInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${atraccionTuristicaInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${atraccionTuristicaInstance?.url}">
        <div class="row">
            <div class="col-md-2 text-info">
                Url
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${atraccionTuristicaInstance}" field="url"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${atraccionTuristicaInstance?.coordenada}">
        <div class="row">
            <div class="col-md-2 text-info">
                Coordenada
            </div>
            
            <div class="col-md-3">
                ${atraccionTuristicaInstance?.coordenada?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${atraccionTuristicaInstance?.fecha}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${atraccionTuristicaInstance?.fecha}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${atraccionTuristicaInstance?.likes}">
        <div class="row">
            <div class="col-md-2 text-info">
                Likes
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${atraccionTuristicaInstance}" field="likes"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>