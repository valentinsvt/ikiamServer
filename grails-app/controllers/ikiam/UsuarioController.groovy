package ikiam

import org.springframework.dao.DataIntegrityViolationException

class UsuarioController {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Usuario.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("apellido", "%" + params.search + "%")
                    ilike("email", "%" + params.search + "%")
                    ilike("esAdmin", "%" + params.search + "%")
                    ilike("esCientifico", "%" + params.search + "%")
                    ilike("facebookId", "%" + params.search + "%")
                    ilike("nombre", "%" + params.search + "%")
                    ilike("tipo", "%" + params.search + "%")
                }
            }
        } else {
            list = Usuario.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def usuarioInstanceList = getList(params, false)
        def usuarioInstanceCount = getList(params, true).size()
        return [usuarioInstanceList: usuarioInstanceList, usuarioInstanceCount: usuarioInstanceCount, params: params]
    }

    def show_ajax() {
        if (params.id) {
            def usuarioInstance = Usuario.get(params.id)
            if (!usuarioInstance) {
                render "ERROR*No se encontró Usuario."
                return
            }
            return [usuarioInstance: usuarioInstance]
        } else {
            render "ERROR*No se encontró Usuario."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def usuarioInstance = new Usuario()
        if (params.id) {
            usuarioInstance = Usuario.get(params.id)
            if (!usuarioInstance) {
                render "ERROR*No se encontró Usuario."
                return
            }
        }
        usuarioInstance.properties = params
        return [usuarioInstance: usuarioInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def usuarioInstance = new Usuario()
        if (params.password && params.password.trim() != "") {
            params.password = params.password.trim().toString().encodeAsMD5()
        } else {
            params.remove("password")
        }
        if (params.id) {
            usuarioInstance = Usuario.get(params.id)
            if (!usuarioInstance) {
                render "ERROR*No se encontró Usuario."
                return
            }
        }
        usuarioInstance.properties = params
        if (!usuarioInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Usuario: " + renderErrors(bean: usuarioInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Usuario exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def usuarioInstance = Usuario.get(params.id)
            if (!usuarioInstance) {
                render "ERROR*No se encontró Usuario."
                return
            }
            try {
                usuarioInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Usuario exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Usuario"
                return
            }
        } else {
            render "ERROR*No se encontró Usuario."
            return
        }
    } //delete para eliminar via ajax

    def validar_unique_email_ajax() {
        params.email = params.email.toString().trim()
        if (params.id) {
            def obj = Usuario.get(params.id)
            if (obj.email.toLowerCase() == params.email.toLowerCase()) {
                render true
                return
            } else {
                render Usuario.countByEmailIlike(params.email) == 0
                return
            }
        } else {
            render Usuario.countByEmailIlike(params.email) == 0
            return
        }
    }

}
