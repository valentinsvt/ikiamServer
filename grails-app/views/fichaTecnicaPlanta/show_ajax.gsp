
<%@ page import="ikiam.FichaTecnicaPlanta" %>

<g:if test="${!fichaTecnicaPlantaInstance}">
    <elm:notFound elem="FichaTecnicaPlanta" genero="o" />
</g:if>
<g:else>

    <g:if test="${fichaTecnicaPlantaInstance?.alturaMax}">
        <div class="row">
            <div class="col-md-2 text-info">
                Altura Max
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="alturaMax"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.alturaMin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Altura Min
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="alturaMin"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.edaficos}">
        <div class="row">
            <div class="col-md-2 text-info">
                Edaficos
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="edaficos"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.especie}">
        <div class="row">
            <div class="col-md-2 text-info">
                Especie
            </div>
            
            <div class="col-md-3">
                ${fichaTecnicaPlantaInstance?.especie?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.factoresLimitantesCrecimiento}">
        <div class="row">
            <div class="col-md-2 text-info">
                Factores Limitantes Crecimiento
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="factoresLimitantesCrecimiento"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.fenologia}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fenologia
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="fenologia"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.flor}">
        <div class="row">
            <div class="col-md-2 text-info">
                Flor
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="flor"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.forma1}">
        <div class="row">
            <div class="col-md-2 text-info">
                Forma1
            </div>
            
            <div class="col-md-3">
                ${fichaTecnicaPlantaInstance?.forma1?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.forma2}">
        <div class="row">
            <div class="col-md-2 text-info">
                Forma2
            </div>
            
            <div class="col-md-3">
                ${fichaTecnicaPlantaInstance?.forma2?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.fruto}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fruto
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="fruto"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.hojas}">
        <div class="row">
            <div class="col-md-2 text-info">
                Hojas
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="hojas"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.precipitacionMax}">
        <div class="row">
            <div class="col-md-2 text-info">
                Precipitacion Max
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="precipitacionMax"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.precipitacionMin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Precipitacion Min
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="precipitacionMin"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.semilla}">
        <div class="row">
            <div class="col-md-2 text-info">
                Semilla
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="semilla"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.temperaturaMax}">
        <div class="row">
            <div class="col-md-2 text-info">
                Temperatura Max
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="temperaturaMax"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.temperaturaMin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Temperatura Min
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="temperaturaMin"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fichaTecnicaPlantaInstance?.tronco}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tronco
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fichaTecnicaPlantaInstance}" field="tronco"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>