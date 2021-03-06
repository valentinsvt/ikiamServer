package ikiam

import org.springframework.dao.DataIntegrityViolationException

class EspecieController {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def form() {
        def especie = Especie.get(params.id)
        [especie: especie]
    }

    def show() {
//        println "especies "+Especie.list().nombre
        def especie = Especie.findByNombre(params.nombre)
        println "id  " + especie?.id
        if (especie) {
            def entrys = Entry.findAllByEspecieAndDeleted(especie, 0)
            return [especie: especie, entrys: entrys]
        } else {
            return [especie: null, entrys: null]
        }

    }

    def saveTextos() {
        def especie = Especie.get(params.id)
        especie.properties = params
        especie.save(flush: true)
        flash.message = "Datos guardados"
        redirect(action: "form", id: especie.id)
    }

    def getEspecies() {
        def especies = Especie.findAllByFeatured("S")
        def datos = ""
        especies.each { e ->
            //println "especie "+e.nombreComun
            def entry = Entry.findByEspecie(e)
            //println "entry "+entry.observaciones
            def foto = Foto.findByEntry(entry)
            //println "foto entry "+foto?.path
            if (!foto)
                foto = Foto.findByEspecie(e)
            //println "foto despues "+foto?.path
            def coord = foto.coordenada
            //println "coord "+coord
            datos += "" + e.nombreComun + ";" + entry.observaciones + ";" + foto.path + ";" + coord.latitud + ";" + coord.longitud + ";" + coord.altitud + ";" + e.likes + ";" + e.nombre + "&"
        }
        render datos
    }

    def showFicha() {
        def esp = Especie.get(params.id)
        def fichaplanta = FichaTecnicaPlanta.findByEspecie(esp)
        if (fichaplanta)
            redirect(action: "showFichaPlanta", id: fichaplanta.id)
        else {
            def fichaAnimal = FichaTecnicaAnimal.findByEspecie(esp)
            if (fichaAnimal)
                redirect(action: "showFichaAnimal", id: fichaAnimal?.id)
            else
                redirect(action: "show", params: ["nombre": esp.nombre])
        }
    }

    def showPapers() {
        def esp = Especie.get(params.id)
        def papers = Paper.findAllByEspecie(esp)
        [papers: papers, especie: esp]
    }


    def showFichaPlanta() {
        def ficha = FichaTecnicaPlanta.get(params.id)
        [ficha: ficha, especie: ficha.especie]
    }

    def showFichaAnimal() {
        def ficha = FichaTecnicaAnimal.get(params.id)
        [ficha: ficha, especie: ficha.especie]
    }


    def fichaAnimal() {
        def esp = Especie.get(params.id)
        def ficha = FichaTecnicaAnimal.findByEspecie(esp)
        if (!ficha) {
            ficha = new FichaTecnicaAnimal()
            ficha.especie = esp;
            if (!ficha.save(flush: true))
                println "errors " + ficha.errors
        }
        [fichaTecnicaAnimalInstance: ficha]
    }

    def fichaPlanta() {
        def esp = Especie.get(params.id)
        def ficha = FichaTecnicaPlanta.findByEspecie(esp)
        if (!ficha) {
            ficha = new FichaTecnicaPlanta()
            ficha.especie = esp;
            if (!ficha.save(flush: true))
                println "errors " + ficha.errors
        }
        [fichaTecnicaPlantaInstance: ficha]
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
        if (params.id) {
            def especieInstance = Especie.get(params.id)
            if (!especieInstance) {
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
        if (params.id) {
            especieInstance = Especie.get(params.id)
            if (!especieInstance) {
                render "ERROR*No se encontró Especie."
                return
            }
        }
        especieInstance.properties = params
        return [especieInstance: especieInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def especieInstance = new Especie()
        if (params.id) {
            especieInstance = Especie.get(params.id)
            if (!especieInstance) {
                render "ERROR*No se encontró Especie."
                return
            }
        }
        especieInstance.properties = params
        if (!especieInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Especie: " + renderErrors(bean: especieInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Especie exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
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
