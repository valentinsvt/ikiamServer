<%@ page import="ikiam.Usuario" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!usuarioInstance}">
    <elm:notFound elem="Usuario" genero="o"/>
</g:if>
<g:else>

    <g:form class="form-horizontal" name="frmUsuario" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${usuarioInstance?.id}"/>


        <div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'email', 'error')} ">
            <span class="grupo">
                <label for="email" class="col-md-2 control-label text-info">
                    Email
                </label>

                <div class="col-md-6">
                    <div class="input-group"><span class="input-group-addon"><i class="fa fa-envelope"></i>
                    </span><g:field type="email" name="email" class="form-control unique" value="${usuarioInstance?.email}"/>
                    </div>
                </div>

            </span>
        </div>

        %{--<div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'password', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="password" class="col-md-2 control-label text-info">--}%
                    %{--Password--}%
                %{--</label>--}%

                %{--<div class="col-md-6">--}%
                    %{--<div class="input-group">--}%
                        %{--<span class="input-group-addon">--}%
                            %{--<i class="fa fa-lock"></i>--}%
                        %{--</span>--}%
                        %{--<g:field type="password" name="password" maxlength="255" class="form-control" value=""/>--}%
                    %{--</div>--}%
                %{--</div>--}%

            %{--</span>--}%
        %{--</div>--}%

        <div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'esAdmin', 'error')} required">
            <span class="grupo">
                <label for="esAdmin" class="col-md-2 control-label text-info">
                    Es Admin
                </label>

                <div class="col-md-6">
                    <g:select name="esAdmin" from="['S': 'Sí', 'N': 'No']" class="form-control required"
                              value="${usuarioInstance?.esAdmin}" optionKey="key" optionValue="value"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'esCientifico', 'error')} required">
            <span class="grupo">
                <label for="esCientifico" class="col-md-2 control-label text-info">
                    Es Cientifico
                </label>

                <div class="col-md-6">
                    <g:select name="esCientifico" from="['S': 'Sí', 'N': 'No']" class="form-control required"
                              value="${usuarioInstance?.esCientifico}" optionKey="key" optionValue="value"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>

                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="100" required="" class="form-control required" value="${usuarioInstance?.nombre}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'apellido', 'error')} required">
            <span class="grupo">
                <label for="apellido" class="col-md-2 control-label text-info">
                    Apellido
                </label>

                <div class="col-md-6">
                    <g:textField name="apellido" maxlength="100" required="" class="form-control required" value="${usuarioInstance?.apellido}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'facebookId', 'error')} ">
            <span class="grupo">
                <label for="facebookId" class="col-md-2 control-label text-info">
                    Facebook Id
                </label>

                <div class="col-md-6">
                    <g:textField name="facebookId" maxlength="30" class="form-control" value="${usuarioInstance?.facebookId}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'tipo', 'error')} required">
            <span class="grupo">
                <label for="tipo" class="col-md-2 control-label text-info">
                    Tipo
                </label>

                <div class="col-md-6">
                    <g:textField name="tipo" maxlength="10" required="" class="form-control required" value="${usuarioInstance?.tipo}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuarioInstance, field: 'titulo', 'error')} required">
            <span class="grupo">
                <label for="titulo" class="col-md-2 control-label text-info">
                    Titulo
                </label>

                <div class="col-md-6">
                    <g:textField name="titulo" maxlength="30" required="" class="form-control required" value="${usuarioInstance?.titulo}"/>
                </div>
                *
            </span>
        </div>

    </g:form>


    <script type="text/javascript">
        var validator = $("#frmUsuario").validate({
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
            }, rules       : {

                email : {
                    remote : {
                        url  : "${createLink(action: 'validar_unique_email_ajax')}",
                        type : "post",
                        data : {
                            id : "${usuarioInstance?.id}"
                        }
                    }
                }

            },
            messages       : {

                email : {
                    remote : "Ya existe Email"
                }

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