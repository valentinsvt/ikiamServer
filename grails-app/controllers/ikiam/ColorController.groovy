package ikiam

import org.springframework.dao.DataIntegrityViolationException

class ColorController {

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
            def c = Color.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                    ilike("color", "%" + params.search + "%")  
                }
            }
        } else {
            list = Color.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def colorInstanceList = getList(params, false)
        def colorInstanceCount = getList(params, true).size()
        return [colorInstanceList: colorInstanceList, colorInstanceCount: colorInstanceCount, params: params]
    }

    def show_ajax() {
        if(params.id) {
            def colorInstance = Color.get(params.id)
            if(!colorInstance) {
                render "ERROR*No se encontró Color."
                return
            }
            return [colorInstance: colorInstance]
        } else {
            render "ERROR*No se encontró Color."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def colorInstance = new Color()
        if(params.id) {
            colorInstance = Color.get(params.id)
            if(!colorInstance) {
                render "ERROR*No se encontró Color."
                return
            }
        }
        colorInstance.properties = params
        return [colorInstance: colorInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def colorInstance = new Color()
        if(params.id) {
            colorInstance = Color.get(params.id)
            if(!colorInstance) {
                render "ERROR*No se encontró Color."
                return
            }
        }
        colorInstance.properties = params
        if(!colorInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Color: " + renderErrors(bean: colorInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Color exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def colorInstance = Color.get(params.id)
            if (!colorInstance) {
                render "ERROR*No se encontró Color."
                return
            }
            try {
                colorInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Color exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Color"
                return
            }
        } else {
            render "ERROR*No se encontró Color."
            return
        }
    } //delete para eliminar via ajax
    
}
