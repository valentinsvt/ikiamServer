package ikiam

import org.springframework.dao.DataIntegrityViolationException

class EstadoDeConservacionController {

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
            def c = EstadoDeConservacion.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                    ilike("codigo", "%" + params.search + "%")  
                    ilike("color", "%" + params.search + "%")  
                    ilike("descripcion", "%" + params.search + "%")  
                }
            }
        } else {
            list = EstadoDeConservacion.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def estadoDeConservacionInstanceList = getList(params, false)
        def estadoDeConservacionInstanceCount = getList(params, true).size()
        return [estadoDeConservacionInstanceList: estadoDeConservacionInstanceList, estadoDeConservacionInstanceCount: estadoDeConservacionInstanceCount, params: params]
    }

    def show_ajax() {
        if(params.id) {
            def estadoDeConservacionInstance = EstadoDeConservacion.get(params.id)
            if(!estadoDeConservacionInstance) {
                render "ERROR*No se encontró EstadoDeConservacion."
                return
            }
            return [estadoDeConservacionInstance: estadoDeConservacionInstance]
        } else {
            render "ERROR*No se encontró EstadoDeConservacion."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def estadoDeConservacionInstance = new EstadoDeConservacion()
        if(params.id) {
            estadoDeConservacionInstance = EstadoDeConservacion.get(params.id)
            if(!estadoDeConservacionInstance) {
                render "ERROR*No se encontró EstadoDeConservacion."
                return
            }
        }
        estadoDeConservacionInstance.properties = params
        return [estadoDeConservacionInstance: estadoDeConservacionInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def estadoDeConservacionInstance = new EstadoDeConservacion()
        if(params.id) {
            estadoDeConservacionInstance = EstadoDeConservacion.get(params.id)
            if(!estadoDeConservacionInstance) {
                render "ERROR*No se encontró EstadoDeConservacion."
                return
            }
        }
        estadoDeConservacionInstance.properties = params
        if(!estadoDeConservacionInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar EstadoDeConservacion: " + renderErrors(bean: estadoDeConservacionInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de EstadoDeConservacion exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def estadoDeConservacionInstance = EstadoDeConservacion.get(params.id)
            if (!estadoDeConservacionInstance) {
                render "ERROR*No se encontró EstadoDeConservacion."
                return
            }
            try {
                estadoDeConservacionInstance.delete(flush: true)
                render "SUCCESS*Eliminación de EstadoDeConservacion exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar EstadoDeConservacion"
                return
            }
        } else {
            render "ERROR*No se encontró EstadoDeConservacion."
            return
        }
    } //delete para eliminar via ajax
    
    def validar_unique_codigo_ajax() {
        params.codigo = params.codigo.toString().trim()
        if (params.id) {
            def obj = EstadoDeConservacion.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render EstadoDeConservacion.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render EstadoDeConservacion.countByCodigoIlike(params.codigo) == 0
            return
        }
    }
        
}
