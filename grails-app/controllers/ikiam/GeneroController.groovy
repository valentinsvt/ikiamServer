package ikiam


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GeneroController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Genero.list(params), model: [generoInstanceCount: Genero.count()]
    }

    def show(Genero generoInstance) {
        respond generoInstance
    }

    def create() {
        respond new Genero(params)
    }

    @Transactional
    def save(Genero generoInstance) {
        if (generoInstance == null) {
            notFound()
            return
        }

        if (generoInstance.hasErrors()) {
            respond generoInstance.errors, view: 'create'
            return
        }

        generoInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'generoInstance.label', default: 'Genero'), generoInstance.id])
                redirect generoInstance
            }
            '*' { respond generoInstance, [status: CREATED] }
        }
    }

    def edit(Genero generoInstance) {
        respond generoInstance
    }

    @Transactional
    def update(Genero generoInstance) {
        if (generoInstance == null) {
            notFound()
            return
        }

        if (generoInstance.hasErrors()) {
            respond generoInstance.errors, view: 'edit'
            return
        }

        generoInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Genero.label', default: 'Genero'), generoInstance.id])
                redirect generoInstance
            }
            '*' { respond generoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Genero generoInstance) {

        if (generoInstance == null) {
            notFound()
            return
        }

        generoInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Genero.label', default: 'Genero'), generoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'generoInstance.label', default: 'Genero'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
