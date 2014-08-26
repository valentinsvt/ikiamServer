package ikiam

import org.springframework.dao.DataIntegrityViolationException

class FamiliaController {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action:"list", params: params)
    }

    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if(all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if(params.search) {
            def c = Familia.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                    ilike("nombre", "%" + params.search + "%")  
                }
            }
        } else {
            list = Familia.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def familiaInstanceList = getList(params, false)
        def familiaInstanceCount = getList(params, true).size()
        return [familiaInstanceList: familiaInstanceList, familiaInstanceCount: familiaInstanceCount, params: params]
    }

    def show_ajax() {
        if(params.id) {
            def familiaInstance = Familia.get(params.id)
            if(!familiaInstance) {
                render "ERROR*No se encontró Familia."
                return
            }
            return [familiaInstance: familiaInstance]
        } else {
            render "ERROR*No se encontró Familia."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def familiaInstance = new Familia()
        if(params.id) {
            familiaInstance = Familia.get(params.id)
            if(!familiaInstance) {
                render "ERROR*No se encontró Familia."
                return
            }
        }
        familiaInstance.properties = params
        return [familiaInstance: familiaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def familiaInstance = new Familia()
        if(params.id) {
            familiaInstance = Familia.get(params.id)
            if(!familiaInstance) {
                render "ERROR*No se encontró Familia."
                return
            }
        }
        familiaInstance.properties = params
        if(!familiaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Familia: " + renderErrors(bean: familiaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Familia exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def familiaInstance = Familia.get(params.id)
            if (!familiaInstance) {
                render "ERROR*No se encontró Familia."
                return
            }
            try {
                familiaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Familia exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Familia"
                return
            }
        } else {
            render "ERROR*No se encontró Familia."
            return
        }
    } //delete para eliminar via ajax
    
}
