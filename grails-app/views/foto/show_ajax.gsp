
<%@ page import="ikiam.Foto" %>

<g:if test="${!fotoInstance}">
    <elm:notFound elem="Foto" genero="o" />
</g:if>
<g:else>

    <g:if test="${fotoInstance?.path}">
        <div class="row">
            <div class="col-md-2 text-info">
                Path
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fotoInstance}" field="path"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fotoInstance?.usuario}">
        <div class="row">
            <div class="col-md-2 text-info">
                Usuario
            </div>
            
            <div class="col-md-3">
                ${fotoInstance?.usuario?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fotoInstance?.coordenada}">
        <div class="row">
            <div class="col-md-2 text-info">
                Coordenada
            </div>
            
            <div class="col-md-3">
                ${fotoInstance?.coordenada?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fotoInstance?.keyWords}">
        <div class="row">
            <div class="col-md-2 text-info">
                Key Words
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fotoInstance}" field="keyWords"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fotoInstance?.atraccion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Atraccion
            </div>
            
            <div class="col-md-3">
                ${fotoInstance?.atraccion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fotoInstance?.entry}">
        <div class="row">
            <div class="col-md-2 text-info">
                Entry
            </div>
            
            <div class="col-md-3">
                ${fotoInstance?.entry?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fotoInstance?.especie}">
        <div class="row">
            <div class="col-md-2 text-info">
                Especie
            </div>
            
            <div class="col-md-3">
                ${fotoInstance?.especie?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fotoInstance?.ruta}">
        <div class="row">
            <div class="col-md-2 text-info">
                Ruta
            </div>
            
            <div class="col-md-3">
                ${fotoInstance?.ruta?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fotoInstance?.likes}">
        <div class="row">
            <div class="col-md-2 text-info">
                Likes
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fotoInstance}" field="likes"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>