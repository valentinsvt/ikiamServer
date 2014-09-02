
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