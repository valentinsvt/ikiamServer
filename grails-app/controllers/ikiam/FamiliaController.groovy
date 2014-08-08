package ikiam


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FamiliaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Familia.list(params), model: [familiaInstanceCount: Familia.count()]
    }

    def show(Familia familiaInstance) {
        respond familiaInstance
    }

    def create() {
        respond new Familia(params)
    }

    @Transactional
    def save(Familia familiaInstance) {
        if (familiaInstance == null) {
            notFound()
            return
        }

        if (familiaInstance.hasErrors()) {
            respond familiaInstance.errors, view: 'create'
            return
        }

        familiaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'familiaInstance.label', default: 'Familia'), familiaInstance.id])
                redirect familiaInstance
            }
            '*' { respond familiaInstance, [status: CREATED] }
        }
    }

    def edit(Familia familiaInstance) {
        respond familiaInstance
    }

    @Transactional
    def update(Familia familiaInstance) {
        if (familiaInstance == null) {
            notFound()
            return
        }

        if (familiaInstance.hasErrors()) {
            respond familiaInstance.errors, view: 'edit'
            return
        }

        familiaInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Familia.label', default: 'Familia'), familiaInstance.id])
                redirect familiaInstance
            }
            '*' { respond familiaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Familia familiaInstance) {

        if (familiaInstance == null) {
            notFound()
            return
        }

        familiaInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Familia.label', default: 'Familia'), familiaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'familiaInstance.label', default: 'Familia'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
