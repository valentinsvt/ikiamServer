
<%@ page import="ikiam.Usuario" %>

<g:if test="${!usuarioInstance}">
    <elm:notFound elem="Usuario" genero="o" />
</g:if>
<g:else>

    <g:if test="${usuarioInstance?.email}">
        <div class="row">
            <div class="col-md-2 text-info">
                Email
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${usuarioInstance}" field="email"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${usuarioInstance?.esAdmin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Es Admin
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${usuarioInstance}" field="esAdmin"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${usuarioInstance?.esCientifico}">
        <div class="row">
            <div class="col-md-2 text-info">
                Es Cientifico
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${usuarioInstance}" field="esCientifico"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${usuarioInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${usuarioInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${usuarioInstance?.apellido}">
        <div class="row">
            <div class="col-md-2 text-info">
                Apellido
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${usuarioInstance}" field="apellido"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${usuarioInstance?.facebookId}">
        <div class="row">
            <div class="col-md-2 text-info">
                Facebook Id
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${usuarioInstance}" field="facebookId"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${usuarioInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${usuarioInstance}" field="tipo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>