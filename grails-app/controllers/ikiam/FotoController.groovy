package ikiam

import org.springframework.dao.DataIntegrityViolationException

class FotoController {

    def imageResizeService

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def fotosUsuario() {
        def usuario = Usuario.get(params.id)
        def fotos = Foto.findAllByUsuario(usuario)
        fotos.each { foto ->
            def data = foto.path.split("/")
            println "data " + data
            if (data.size() > 1) {
                foto.path = data[7].trim()
                foto.save(flush: true)
            }
            def path = servletContext.getRealPath("/") + "uploaded/"
            def pathThumb = path + "markers/"
            new File(pathThumb).mkdirs()
//                def thumb = new File(pathThumb + foto.path)
//                if (!thumb.exists()) {
            imageResizeService.createMarker(path + foto.path, pathThumb + foto.path)
//                }
        }
        println "FOTOS: " + fotos
        return [fotos: fotos]
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
            def c = Foto.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("keyWords", "%" + params.search + "%")
                    ilike("path", "%" + params.search + "%")
                }
            }
        } else {
            list = Foto.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def fotoInstanceList = getList(params, false)
        def fotoInstanceCount = getList(params, true).size()
        return [fotoInstanceList: fotoInstanceList, fotoInstanceCount: fotoInstanceCount, params: params]
    }

    def show_ajax() {
        if (params.id) {
            def fotoInstance = Foto.get(params.id)
            if (!fotoInstance) {
                render "ERROR*No se encontró Foto."
                return
            }
            return [fotoInstance: fotoInstance]
        } else {
            render "ERROR*No se encontró Foto."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def fotoInstance = new Foto()
        if (params.id) {
            fotoInstance = Foto.get(params.id)
            if (!fotoInstance) {
                render "ERROR*No se encontró Foto."
                return
            }
        }
        fotoInstance.properties = params
        return [fotoInstance: fotoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def fotoInstance = new Foto()
        if (params.id) {
            fotoInstance = Foto.get(params.id)
            if (!fotoInstance) {
                render "ERROR*No se encontró Foto."
                return
            }
        }
        fotoInstance.properties = params
        if (!fotoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Foto: " + renderErrors(bean: fotoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Foto exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def fotoInstance = Foto.get(params.id)
            if (!fotoInstance) {
                render "ERROR*No se encontró Foto."
                return
            }
            try {
                fotoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Foto exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Foto"
                return
            }
        } else {
            render "ERROR*No se encontró Foto."
            return
        }
    } //delete para eliminar via ajax

}
