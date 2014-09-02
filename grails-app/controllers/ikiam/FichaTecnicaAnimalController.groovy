package ikiam

import org.springframework.dao.DataIntegrityViolationException

class FichaTecnicaAnimalController {

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
            def c = FichaTecnicaAnimal.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("alimentacion", "%" + params.search + "%")
                    ilike("comportamiento", "%" + params.search + "%")
                    ilike("social", "%" + params.search + "%")
                }
            }
        } else {
            list = FichaTecnicaAnimal.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def fichaTecnicaAnimalInstanceList = getList(params, false)
        def fichaTecnicaAnimalInstanceCount = getList(params, true).size()
        return [fichaTecnicaAnimalInstanceList: fichaTecnicaAnimalInstanceList, fichaTecnicaAnimalInstanceCount: fichaTecnicaAnimalInstanceCount, params: params]
    }

    def show_ajax() {
        if (params.id) {
            def fichaTecnicaAnimalInstance = FichaTecnicaAnimal.get(params.id)
            if (!fichaTecnicaAnimalInstance) {
                render "ERROR*No se encontró FichaTecnicaAnimal."
                return
            }
            return [fichaTecnicaAnimalInstance: fichaTecnicaAnimalInstance]
        } else {
            render "ERROR*No se encontró FichaTecnicaAnimal."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def fichaTecnicaAnimalInstance = new FichaTecnicaAnimal()
        if (params.id) {
            fichaTecnicaAnimalInstance = FichaTecnicaAnimal.get(params.id)
            if (!fichaTecnicaAnimalInstance) {
                render "ERROR*No se encontró FichaTecnicaAnimal."
                return
            }
        }
        fichaTecnicaAnimalInstance.properties = params
        return [fichaTecnicaAnimalInstance: fichaTecnicaAnimalInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def fichaTecnicaAnimalInstance = new FichaTecnicaAnimal()
        if (params.id) {
            fichaTecnicaAnimalInstance = FichaTecnicaAnimal.get(params.id)
            if (!fichaTecnicaAnimalInstance) {
                render "ERROR*No se encontró FichaTecnicaAnimal."
                return
            }
        }
        fichaTecnicaAnimalInstance.properties = params
        if (!fichaTecnicaAnimalInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar FichaTecnicaAnimal: " + renderErrors(bean: fichaTecnicaAnimalInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de FichaTecnicaAnimal exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def fichaTecnicaAnimalInstance = FichaTecnicaAnimal.get(params.id)
            if (!fichaTecnicaAnimalInstance) {
                render "ERROR*No se encontró FichaTecnicaAnimal."
                return
            }
            try {
                fichaTecnicaAnimalInstance.delete(flush: true)
                render "SUCCESS*Eliminación de FichaTecnicaAnimal exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar FichaTecnicaAnimal"
                return
            }
        } else {
            render "ERROR*No se encontró FichaTecnicaAnimal."
            return
        }
    } //delete para eliminar via ajax

}
