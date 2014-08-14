package ikiam


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AtraccionTuristicaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def atracciones(){
        def atracciones = AtraccionTuristica.list()
        def datos=""
        atracciones.each {
            def foto = Foto.findByAtraccion(it)
            datos+=it.nombre+"&"+it.likes+"&"+it.coordenada.latitud+"&"+it.coordenada.longitud+"&"+foto.path+"&"+it.url+";"

        }
        //println "datos "+datos
        render datos
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AtraccionTuristica.list(params), model: [atraccionTuristicaInstanceCount: AtraccionTuristica.count()]
    }

    def show(AtraccionTuristica atraccionTuristicaInstance) {
        respond atraccionTuristicaInstance
    }

    def create() {
        respond new AtraccionTuristica(params)
    }

    @Transactional
    def save(AtraccionTuristica atraccionTuristicaInstance) {
        if (atraccionTuristicaInstance == null) {
            notFound()
            return
        }

        if (atraccionTuristicaInstance.hasErrors()) {
            respond atraccionTuristicaInstance.errors, view: 'create'
            return
        }

        atraccionTuristicaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'atraccionTuristicaInstance.label', default: 'AtraccionTuristica'), atraccionTuristicaInstance.id])
                redirect atraccionTuristicaInstance
            }
            '*' { respond atraccionTuristicaInstance, [status: CREATED] }
        }
    }

    def edit(AtraccionTuristica atraccionTuristicaInstance) {
        respond atraccionTuristicaInstance
    }

    @Transactional
    def update(AtraccionTuristica atraccionTuristicaInstance) {
        if (atraccionTuristicaInstance == null) {
            notFound()
            return
        }

        if (atraccionTuristicaInstance.hasErrors()) {
            respond atraccionTuristicaInstance.errors, view: 'edit'
            return
        }

        atraccionTuristicaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AtraccionTuristica.label', default: 'AtraccionTuristica'), atraccionTuristicaInstance.id])
                redirect atraccionTuristicaInstance
            }
            '*' { respond atraccionTuristicaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AtraccionTuristica atraccionTuristicaInstance) {

        if (atraccionTuristicaInstance == null) {
            notFound()
            return
        }

        atraccionTuristicaInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AtraccionTuristica.label', default: 'AtraccionTuristica'), atraccionTuristicaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'atraccionTuristicaInstance.label', default: 'AtraccionTuristica'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
