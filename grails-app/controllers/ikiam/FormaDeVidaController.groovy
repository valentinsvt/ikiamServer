package ikiam

import org.springframework.dao.DataIntegrityViolationException

class FormaDeVidaController {

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
            def c = FormaDeVida.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = FormaDeVida.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def formaDeVidaInstanceList = getList(params, false)
        def formaDeVidaInstanceCount = getList(params, true).size()
        return [formaDeVidaInstanceList: formaDeVidaInstanceList, formaDeVidaInstanceCount: formaDeVidaInstanceCount, params: params]
    }

    def show_ajax() {
        if (params.id) {
            def formaDeVidaInstance = FormaDeVida.get(params.id)
            if (!formaDeVidaInstance) {
                render "ERROR*No se encontró FormaDeVida."
                return
            }
            return [formaDeVidaInstance: formaDeVidaInstance]
        } else {
            render "ERROR*No se encontró FormaDeVida."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def formaDeVidaInstance = new FormaDeVida()
        if (params.id) {
            formaDeVidaInstance = FormaDeVida.get(params.id)
            if (!formaDeVidaInstance) {
                render "ERROR*No se encontró FormaDeVida."
                return
            }
        }
        formaDeVidaInstance.properties = params
        return [formaDeVidaInstance: formaDeVidaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def formaDeVidaInstance = new FormaDeVida()
        if (params.id) {
            formaDeVidaInstance = FormaDeVida.get(params.id)
            if (!formaDeVidaInstance) {
                render "ERROR*No se encontró FormaDeVida."
                return
            }
        }
        formaDeVidaInstance.properties = params
        if (!formaDeVidaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar FormaDeVida: " + renderErrors(bean: formaDeVidaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de FormaDeVida exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def formaDeVidaInstance = FormaDeVida.get(params.id)
            if (!formaDeVidaInstance) {
                render "ERROR*No se encontró FormaDeVida."
                return
            }
            try {
                formaDeVidaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de FormaDeVida exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar FormaDeVida"
                return
            }
        } else {
            render "ERROR*No se encontró FormaDeVida."
            return
        }
    } //delete para eliminar via ajax

}
