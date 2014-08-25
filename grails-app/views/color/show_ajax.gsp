
<%@ page import="ikiam.Color" %>

<g:if test="${!colorInstance}">
    <elm:notFound elem="Color" genero="o" />
</g:if>
<g:else>

    <g:if test="${colorInstance?.color}">
        <div class="row">
            <div class="col-md-2 text-info">
                Color
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${colorInstance}" field="color"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>