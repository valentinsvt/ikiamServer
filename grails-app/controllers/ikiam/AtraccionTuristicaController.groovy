package ikiam

import org.springframework.dao.DataIntegrityViolationException

class AtraccionTuristicaController {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def atracciones() {
        def atracciones = AtraccionTuristica.list()
        def datos = ""
        atracciones.each {
            def foto = Foto.findByAtraccion(it)
            datos += it.nombre + "&" + it.likes + "&" + it.coordenada.latitud + "&" + it.coordenada.longitud + "&" + foto.path + "&" + it.url + ";"

        }
        //println "datos "+datos
        render datos
    }

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
            def c = AtraccionTuristica.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("nombre", "%" + params.search + "%")
                    ilike("url", "%" + params.search + "%")
                }
            }
        } else {
            list = AtraccionTuristica.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def atraccionTuristicaInstanceList = getList(params, false)
        def atraccionTuristicaInstanceCount = getList(params, true).size()
        return [atraccionTuristicaInstanceList: atraccionTuristicaInstanceList, atraccionTuristicaInstanceCount: atraccionTuristicaInstanceCount, params: params]
    }

    def show_ajax() {
        if (params.id) {
            def atraccionTuristicaInstance = AtraccionTuristica.get(params.id)
            if (!atraccionTuristicaInstance) {
                render "ERROR*No se encontró AtraccionTuristica."
                return
            }
            return [atraccionTuristicaInstance: atraccionTuristicaInstance]
        } else {
            render "ERROR*No se encontró AtraccionTuristica."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def atraccionTuristicaInstance = new AtraccionTuristica()
        if (params.id) {
            atraccionTuristicaInstance = AtraccionTuristica.get(params.id)
            if (!atraccionTuristicaInstance) {
                render "ERROR*No se encontró AtraccionTuristica."
                return
            }
        }
        atraccionTuristicaInstance.properties = params
        return [atraccionTuristicaInstance: atraccionTuristicaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def atraccionTuristicaInstance = new AtraccionTuristica()
        if (params.id) {
            atraccionTuristicaInstance = AtraccionTuristica.get(params.id)
            if (!atraccionTuristicaInstance) {
                render "ERROR*No se encontró AtraccionTuristica."
                return
            }
        }
        atraccionTuristicaInstance.properties = params
        if (!atraccionTuristicaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar AtraccionTuristica: " + renderErrors(bean: atraccionTuristicaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de AtraccionTuristica exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def atraccionTuristicaInstance = AtraccionTuristica.get(params.id)
            if (!atraccionTuristicaInstance) {
                render "ERROR*No se encontró AtraccionTuristica."
                return
            }
            try {
                atraccionTuristicaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de AtraccionTuristica exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar AtraccionTuristica"
                return
            }
        } else {
            render "ERROR*No se encontró AtraccionTuristica."
            return
        }
    } //delete para eliminar via ajax

}
