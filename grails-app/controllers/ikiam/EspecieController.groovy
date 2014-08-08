package ikiam


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EspecieController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Especie.list(params), model: [especieInstanceCount: Especie.count()]
    }

    def show(Especie especieInstance) {
        respond especieInstance
    }

    def create() {
        respond new Especie(params)
    }

    @Transactional
    def save(Especie especieInstance) {
        if (especieInstance == null) {
            notFound()
            return
        }

        if (especieInstance.hasErrors()) {
            respond especieInstance.errors, view: 'create'
            return
        }

        especieInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'especieInstance.label', default: 'Especie'), especieInstance.id])
                redirect especieInstance
            }
            '*' { respond especieInstance, [status: CREATED] }
        }
    }

    def edit(Especie especieInstance) {
        respond especieInstance
    }

    @Transactional
    def update(Especie especieInstance) {
        if (especieInstance == null) {
            notFound()
            return
        }

        if (especieInstance.hasErrors()) {
            respond especieInstance.errors, view: 'edit'
            return
        }

        especieInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Especie.label', default: 'Especie'), especieInstance.id])
                redirect especieInstance
            }
            '*' { respond especieInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Especie especieInstance) {

        if (especieInstance == null) {
            notFound()
            return
        }

        especieInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Especie.label', default: 'Especie'), especieInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'especieInstance.label', default: 'Especie'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
