package ikiam

import org.springframework.dao.DataIntegrityViolationException

class CoordenadaController {

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
            def c = Coordenada.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                }
            }
        } else {
            list = Coordenada.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def coordenadaInstanceList = getList(params, false)
        def coordenadaInstanceCount = getList(params, true).size()
        return [coordenadaInstanceList: coordenadaInstanceList, coordenadaInstanceCount: coordenadaInstanceCount, params: params]
    }

    def show_ajax() {
        if(params.id) {
            def coordenadaInstance = Coordenada.get(params.id)
            if(!coordenadaInstance) {
                render "ERROR*No se encontró Coordenada."
                return
            }
            return [coordenadaInstance: coordenadaInstance]
        } else {
            render "ERROR*No se encontró Coordenada."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def coordenadaInstance = new Coordenada()
        if(params.id) {
            coordenadaInstance = Coordenada.get(params.id)
            if(!coordenadaInstance) {
                render "ERROR*No se encontró Coordenada."
                return
            }
        }
        coordenadaInstance.properties = params
        return [coordenadaInstance: coordenadaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def coordenadaInstance = new Coordenada()
        if(params.id) {
            coordenadaInstance = Coordenada.get(params.id)
            if(!coordenadaInstance) {
                render "ERROR*No se encontró Coordenada."
                return
            }
        }
        coordenadaInstance.properties = params
        if(!coordenadaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Coordenada: " + renderErrors(bean: coordenadaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Coordenada exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def coordenadaInstance = Coordenada.get(params.id)
            if (!coordenadaInstance) {
                render "ERROR*No se encontró Coordenada."
                return
            }
            try {
                coordenadaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Coordenada exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Coordenada"
                return
            }
        } else {
            render "ERROR*No se encontró Coordenada."
            return
        }
    } //delete para eliminar via ajax
    
}
