package ikiam

import org.springframework.dao.DataIntegrityViolationException

class EspecieController {

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
            def c = Especie.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                    ilike("nombre", "%" + params.search + "%")  
                    ilike("nombreComun", "%" + params.search + "%")  
                }
            }
        } else {
            list = Especie.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def especieInstanceList = getList(params, false)
        def especieInstanceCount = getList(params, true).size()
        return [especieInstanceList: especieInstanceList, especieInstanceCount: especieInstanceCount, params: params]
    }

    def show_ajax() {
        if(params.id) {
            def especieInstance = Especie.get(params.id)
            if(!especieInstance) {
                render "ERROR*No se encontró Especie."
                return
            }
            return [especieInstance: especieInstance]
        } else {
            render "ERROR*No se encontró Especie."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def especieInstance = new Especie()
        if(params.id) {
            especieInstance = Especie.get(params.id)
            if(!especieInstance) {
                render "ERROR*No se encontró Especie."
                return
            }
        }
        especieInstance.properties = params
        return [especieInstance: especieInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def especieInstance = new Especie()
        if(params.id) {
            especieInstance = Especie.get(params.id)
            if(!especieInstance) {
                render "ERROR*No se encontró Especie."
                return
            }
        }
        especieInstance.properties = params
        if(!especieInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Especie: " + renderErrors(bean: especieInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Especie exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def especieInstance = Especie.get(params.id)
            if (!especieInstance) {
                render "ERROR*No se encontró Especie."
                return
            }
            try {
                especieInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Especie exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Especie"
                return
            }
        } else {
            render "ERROR*No se encontró Especie."
            return
        }
    } //delete para eliminar via ajax
    
}
