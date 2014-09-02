package ikiam

import org.springframework.dao.DataIntegrityViolationException

class FichaTecnicaPlantaController {

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
            def c = FichaTecnicaPlanta.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("edaficos", "%" + params.search + "%")
                    ilike("factoresLimitantesCrecimiento", "%" + params.search + "%")
                    ilike("fenologia", "%" + params.search + "%")
                    ilike("flor", "%" + params.search + "%")
                    ilike("fruto", "%" + params.search + "%")
                    ilike("hojas", "%" + params.search + "%")
                    ilike("semilla", "%" + params.search + "%")
                    ilike("tronco", "%" + params.search + "%")
                }
            }
        } else {
            list = FichaTecnicaPlanta.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def fichaTecnicaPlantaInstanceList = getList(params, false)
        def fichaTecnicaPlantaInstanceCount = getList(params, true).size()
        return [fichaTecnicaPlantaInstanceList: fichaTecnicaPlantaInstanceList, fichaTecnicaPlantaInstanceCount: fichaTecnicaPlantaInstanceCount, params: params]
    }

    def show_ajax() {
        if (params.id) {
            def fichaTecnicaPlantaInstance = FichaTecnicaPlanta.get(params.id)
            if (!fichaTecnicaPlantaInstance) {
                render "ERROR*No se encontró FichaTecnicaPlanta."
                return
            }
            return [fichaTecnicaPlantaInstance: fichaTecnicaPlantaInstance]
        } else {
            render "ERROR*No se encontró FichaTecnicaPlanta."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def fichaTecnicaPlantaInstance = new FichaTecnicaPlanta()
        if (params.id) {
            fichaTecnicaPlantaInstance = FichaTecnicaPlanta.get(params.id)
            if (!fichaTecnicaPlantaInstance) {
                render "ERROR*No se encontró FichaTecnicaPlanta."
                return
            }
        }
        fichaTecnicaPlantaInstance.properties = params
        return [fichaTecnicaPlantaInstance: fichaTecnicaPlantaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def fichaTecnicaPlantaInstance = new FichaTecnicaPlanta()
        if (params.id) {
            fichaTecnicaPlantaInstance = FichaTecnicaPlanta.get(params.id)
            if (!fichaTecnicaPlantaInstance) {
                render "ERROR*No se encontró FichaTecnicaPlanta."
                return
            }
        }
        fichaTecnicaPlantaInstance.properties = params
        if (!fichaTecnicaPlantaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar FichaTecnicaPlanta: " + renderErrors(bean: fichaTecnicaPlantaInstance)
            return
        }
        redirect(controller: 'especie',action: 'fichaPlanta',id: fichaTecnicaPlantaInstance.especie.id)
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def fichaTecnicaPlantaInstance = FichaTecnicaPlanta.get(params.id)
            if (!fichaTecnicaPlantaInstance) {
                render "ERROR*No se encontró FichaTecnicaPlanta."
                return
            }
            try {
                fichaTecnicaPlantaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de FichaTecnicaPlanta exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar FichaTecnicaPlanta"
                return
            }
        } else {
            render "ERROR*No se encontró FichaTecnicaPlanta."
            return
        }
    } //delete para eliminar via ajax

}
