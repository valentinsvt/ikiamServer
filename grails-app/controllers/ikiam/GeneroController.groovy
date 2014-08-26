package ikiam

import org.springframework.dao.DataIntegrityViolationException

class GeneroController {

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
            def c = Genero.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    
                    ilike("nombre", "%" + params.search + "%")  
                }
            }
        } else {
            list = Genero.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def generoInstanceList = getList(params, false)
        def generoInstanceCount = getList(params, true).size()
        return [generoInstanceList: generoInstanceList, generoInstanceCount: generoInstanceCount, params: params]
    }

    def show_ajax() {
        if(params.id) {
            def generoInstance = Genero.get(params.id)
            if(!generoInstance) {
                render "ERROR*No se encontró Genero."
                return
            }
            return [generoInstance: generoInstance]
        } else {
            render "ERROR*No se encontró Genero."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def generoInstance = new Genero()
        if(params.id) {
            generoInstance = Genero.get(params.id)
            if(!generoInstance) {
                render "ERROR*No se encontró Genero."
                return
            }
        }
        generoInstance.properties = params
        return [generoInstance: generoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def generoInstance = new Genero()
        if(params.id) {
            generoInstance = Genero.get(params.id)
            if(!generoInstance) {
                render "ERROR*No se encontró Genero."
                return
            }
        }
        generoInstance.properties = params
        if(!generoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Genero: " + renderErrors(bean: generoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Genero exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def generoInstance = Genero.get(params.id)
            if (!generoInstance) {
                render "ERROR*No se encontró Genero."
                return
            }
            try {
                generoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Genero exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Genero"
                return
            }
        } else {
            render "ERROR*No se encontró Genero."
            return
        }
    } //delete para eliminar via ajax
    
}
