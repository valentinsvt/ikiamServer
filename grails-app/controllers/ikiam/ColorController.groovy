package ikiam


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ColorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Color.list(params), model: [colorInstanceCount: Color.count()]
    }

    def show(Color colorInstance) {
        respond colorInstance
    }

    def create() {
        respond new Color(params)
    }

    @Transactional
    def save(Color colorInstance) {
        if (colorInstance == null) {
            notFound()
            return
        }

        if (colorInstance.hasErrors()) {
            respond colorInstance.errors, view: 'create'
            return
        }

        colorInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'colorInstance.label', default: 'Color'), colorInstance.id])
                redirect colorInstance
            }
            '*' { respond colorInstance, [status: CREATED] }
        }
    }

    def edit(Color colorInstance) {
        respond colorInstance
    }

    @Transactional
    def update(Color colorInstance) {
        if (colorInstance == null) {
            notFound()
            return
        }

        if (colorInstance.hasErrors()) {
            respond colorInstance.errors, view: 'edit'
            return
        }

        colorInstance.save flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Color.label', default: 'Color'), colorInstance.id])
                redirect colorInstance
            }
            '*' { respond colorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Color colorInstance) {

        if (colorInstance == null) {
            notFound()
            return
        }

        colorInstance.delete flush: true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Color.label', default: 'Color'), colorInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'colorInstance.label', default: 'Color'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
