package ikiam


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CoordenadaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Coordenada.list(params), model: [coordenadaInstanceCount: Coordenada.count()]
    }

    def show(Coordenada coordenadaInstance) {
        respond coordenadaInstance
    }

    def create() {
        respond new Coordenada(params)
    }

    @Transactional
    def save(Coordenada coordenadaInstance) {
        if (coordenadaInstance == null) {
            notFound()
            return
        }

        if (coordenadaInstance.hasErrors()) {
            respond coordenadaInstance.errors, view: 'create'
            return
        }

        coordenadaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'coordenadaInstance.label', default: 'Coordenada'), coordenadaInstance.id])
                redirect coordenadaInstance
            }
            '*' { respond coordenadaInstance, [status: CREATED] }
        }
    }

    def edit(Coordenada coordenadaInstance) {
        respond coordenadaInstance
    }

    @Transactional
    def update(Coordenada coordenadaInstance) {
        if (coordenadaInstance == null) {
            notFound()
            return
        }

        if (coordenadaInstance.hasErrors()) {
            respond coordenadaInstance.errors, view: 'edit'
            return
        }

        coordenadaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Coordenada.label', default: 'Coordenada'), coordenadaInstance.id])
                redirect coordenadaInstance
            }
            '*' { respond coordenadaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Coordenada coordenadaInstance) {

        if (coordenadaInstance == null) {
            notFound()
            return
        }

        coordenadaInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Coordenada.label', default: 'Coordenada'), coordenadaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'coordenadaInstance.label', default: 'Coordenada'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
