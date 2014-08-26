package ikiam

import org.springframework.dao.DataIntegrityViolationException

class EntryController {

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
            def c = Entry.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                    ilike("observaciones", "%" + params.search + "%")  
                }
            }
        } else {
            list = Entry.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def entryInstanceList = getList(params, false)
        def entryInstanceCount = getList(params, true).size()
        return [entryInstanceList: entryInstanceList, entryInstanceCount: entryInstanceCount, params: params]
    }

    def show_ajax() {
        if(params.id) {
            def entryInstance = Entry.get(params.id)
            if(!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
            return [entryInstance: entryInstance]
        } else {
            render "ERROR*No se encontró Entry."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def entryInstance = new Entry()
        if(params.id) {
            entryInstance = Entry.get(params.id)
            if(!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
        }
        entryInstance.properties = params
        return [entryInstance: entryInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def entryInstance = new Entry()
        if(params.id) {
            entryInstance = Entry.get(params.id)
            if(!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
        }
        entryInstance.properties = params
        if(!entryInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Entry: " + renderErrors(bean: entryInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Entry exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
            try {
                entryInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Entry exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Entry"
                return
            }
        } else {
            render "ERROR*No se encontró Entry."
            return
        }
    } //delete para eliminar via ajax
    
}
