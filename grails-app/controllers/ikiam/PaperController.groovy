package ikiam

import org.springframework.dao.DataIntegrityViolationException

class PaperController {

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
            def c = Paper.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("path", "%" + params.search + "%")
                    ilike("titulo", "%" + params.search + "%")
                }
            }
        } else {
            list = Paper.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def paperInstanceList = getList(params, false)
        def paperInstanceCount = getList(params, true).size()
        return [paperInstanceList: paperInstanceList, paperInstanceCount: paperInstanceCount, params: params]
    }

    def show_ajax() {
        if (params.id) {
            def paperInstance = Paper.get(params.id)
            if (!paperInstance) {
                render "ERROR*No se encontró Paper."
                return
            }
            return [paperInstance: paperInstance]
        } else {
            render "ERROR*No se encontró Paper."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def paperInstance = new Paper()
        if (params.id) {
            paperInstance = Paper.get(params.id)
            if (!paperInstance) {
                render "ERROR*No se encontró Paper."
                return
            }
        }
        paperInstance.properties = params
        return [paperInstance: paperInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def paperInstance = new Paper()
        if (params.id) {
            paperInstance = Paper.get(params.id)
            if (!paperInstance) {
                render "ERROR*No se encontró Paper."
                return
            }
        }
        paperInstance.properties = params
        if (!paperInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Paper: " + renderErrors(bean: paperInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Paper exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def paperInstance = Paper.get(params.id)
            if (!paperInstance) {
                render "ERROR*No se encontró Paper."
                return
            }
            try {
                paperInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Paper exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Paper"
                return
            }
        } else {
            render "ERROR*No se encontró Paper."
            return
        }
    } //delete para eliminar via ajax

}
