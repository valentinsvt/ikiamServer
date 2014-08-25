<%=packageName ? "package ${packageName}" : ''%>

import org.springframework.dao.DataIntegrityViolationException
<% props = domainClass.properties %>
class ${className}Controller {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action:"list", params: params)
    }

    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if(all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if(params.search) {
            def c = ${className}.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    eq("id", "%" + params.search + "%")
                    <% for (p in props) {
                if(p.type == String && !p.name.contains("pass")) { %>
                    eq("${p.name}", "%" + params.search + "%")  <% } } %>
                }
            }
        } else {
            list = ${className}.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def ${propertyName}List = getList(params, false)
        def ${propertyName}Count = getList(params, true).size()
        return [${propertyName}List: ${propertyName}List, ${propertyName}Count: ${propertyName}Count]
    }

    def show_ajax() {
        if(params.id) {
            def ${propertyName} = ${className}.get(params.id)
            if(!${propertyName}) {
                render "ERROR*No se encontró ${className}."
                return
            }
            return [${propertyName}: ${propertyName}]
        } else {
            render "ERROR*No se encontró ${className}."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def ${propertyName} = new ${className}()
        if(params.id) {
            ${propertyName} = ${className}.get(params.id)
            if(!${propertyName}) {
                render "ERROR*No se encontró ${className}."
                return
            }
        }
        ${propertyName}.properties = params
        return [${propertyName}: ${propertyName}]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def ${propertyName} = new ${className}()
        if(params.id) {
            ${propertyName} = ${className}.get(params.id)
            if(!${propertyName}) {
                render "ERROR*No se encontró ${className}."
                return
            }
        }
        ${propertyName}.properties = params
        if(!${propertyName}.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar ${className}: " + renderErrors(bean: ${propertyName})
            return
        }
        render "SUCCESS*\${params.id ? 'Actualización' : 'Creación'} de ${className} exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def ${propertyName} = ${className}.get(params.id)
            if (!${propertyName}) {
                render "ERROR*No se encontró ${className}."
                return
            }
            try {
                ${propertyName}.delete(flush: true)
                render "SUCCESS*Eliminación de ${className} exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar ${className}"
                return
            }
        } else {
            render "ERROR*No se encontró ${className}."
            return
        }
    } //delete para eliminar via ajax
    <% for (p in props) {
        unique = p.name.contains('codigo') || p.name.contains('login') || p.name.contains('mail') || p.name.contains('email')
        if(unique) { %>
    def validar_unique_${p.name}_ajax() {
        params.${p.name} = params.${p.name}.toString().trim()
        if (params.id) {
            def obj = ${className}.get(params.id)
            if (obj.${p.name}.toLowerCase() == params.${p.name}.toLowerCase()) {
                render true
                return
            } else {
                render ${className}.countBy${p.name.capitalize()}Ilike(params.${p.name}) == 0
                return
            }
        } else {
            render ${className}.countBy${p.name.capitalize()}Ilike(params.${p.name}) == 0
            return
        }
    }
        <% }
    }
    %>
}
