<%@ page import="ikiam.Paper" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!paperInstance}">
    <elm:notFound elem="Paper" genero="o" />
</g:if>
<g:else>
    
    <g:form class="form-horizontal" name="frmPaper" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${paperInstance?.id}" />

        
        <div class="form-group keeptogether ${hasErrors(bean: paperInstance, field: 'titulo', 'error')} required">
            <span class="grupo">
                <label for="titulo" class="col-md-2 control-label text-info">
                    Titulo
                </label>
                <div class="col-md-6">
                    <g:textArea name="titulo" cols="40" rows="5" maxlength="500" required="" class="form-control required" value="${paperInstance?.titulo}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: paperInstance, field: 'path', 'error')} required">
            <span class="grupo">
                <label for="path" class="col-md-2 control-label text-info">
                    Path
                </label>
                <div class="col-md-6">
                    <g:textArea name="path" cols="40" rows="5" maxlength="500" required="" class="form-control required" value="${paperInstance?.path}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: paperInstance, field: 'autor', 'error')} required">
            <span class="grupo">
                <label for="autor" class="col-md-2 control-label text-info">
                    Autor
                </label>
                <div class="col-md-6">
                    <g:textField name="autor" maxlength="150" required="" class="form-control required" value="${paperInstance?.autor}"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: paperInstance, field: 'especie', 'error')} required">
            <span class="grupo">
                <label for="especie" class="col-md-2 control-label text-info">
                    Especie
                </label>
                <div class="col-md-6">
                    <g:select id="especie" name="especie.id" from="${ikiam.Especie.list()}" optionKey="id" required="" value="${paperInstance?.especie?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: paperInstance, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label for="fecha" class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fecha"  class="datepicker form-control required" value="${paperInstance?.fecha}"  />
                </div>
                 *
            </span>
        </div>
        
    </g:form>
    

    <script type="text/javascript">
        var validator = $("#frmPaper").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
            }
            
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>