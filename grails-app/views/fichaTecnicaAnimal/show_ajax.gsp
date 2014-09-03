
<%@ page import="ikiam.FichaTecnicaAnimal" %>

<g:if test="${!fichaTecnicaAnimalInstance}">
    <elm:notFound elem="FichaTecnicaAnimal" genero="o" />
</g:if>
<g:else>

    <g:if test="${fichaTecnicaAnimalInstance?.alimentacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Alimentacion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="alimentacion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.social}">
        <div class="row">
            <div class="col-md-2 text-info">
                Social
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="social"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.comportamiento}">
        <div class="row">
            <div class="col-md-2 text-info">
                Comportamiento
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="comportamiento"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.etimologia}">
        <div class="row">
            <div class="col-md-2 text-info">
                Etimologia
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="etimologia"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.conservacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Conservacion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="conservacion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.habitat}">
        <div class="row">
            <div class="col-md-2 text-info">
                Habitat
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="habitat"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.taxonomia}">
        <div class="row">
            <div class="col-md-2 text-info">
                Taxonomia
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="taxonomia"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.alturaMin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Altura Min
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="alturaMin"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.alturaMax}">
        <div class="row">
            <div class="col-md-2 text-info">
                Altura Max
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="alturaMax"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.temperaturaMax}">
        <div class="row">
            <div class="col-md-2 text-info">
                Temperatura Max
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="temperaturaMax"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.temperaturaMin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Temperatura Min
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="temperaturaMin"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.especie}">
        <div class="row">
            <div class="col-md-2 text-info">
                Especie
            </div>
            
            <div class="col-md-3">
                ${fichaTecnicaAnimalInstance?.especie?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.longevidad}">
        <div class="row">
            <div class="col-md-2 text-info">
                Longevidad
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="longevidad"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.longevidadCautiverio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Longevidad Cautiverio
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="longevidadCautiverio"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.pesoMax}">
        <div class="row">
            <div class="col-md-2 text-info">
                Peso Max
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="pesoMax"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.pesoMin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Peso Min
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="pesoMin"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.tallaMax}">
        <div class="row">
            <div class="col-md-2 text-info">
                Talla Max
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="tallaMax"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaAnimalInstance?.tallaMin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Talla Min
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaAnimalInstance}" field="tallaMin"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>