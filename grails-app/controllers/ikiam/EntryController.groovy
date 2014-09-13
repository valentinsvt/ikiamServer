package ikiam

import org.springframework.dao.DataIntegrityViolationException

class EntryController {

    def imageResizeService

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
            def c = Entry.createCriteria()
            list = c.list(params) {
                or {
                    especie {
                        ilike("nombre", "%" + params.search + "%")
                        ilike("nombreComun", "%" + params.search + "%")
                        genero {
                            ilike("nombre", "%" + params.search + "%")
                            familia {
                                ilike("nombre", "%" + params.search + "%")
                            }
                        }
                        order("nombreComun", "asc")
                    }
                }
                eq("deleted", 0)
            }
        } else {
//            list = Entry.findAllByDeleted(0, params)
            def c = Entry.createCriteria()
            list = c.list(params) {
                especie {
                    order("nombreComun", "asc")
                }
                eq("deleted", 0)
            }
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def like_ajax() {
        if (params.id) {
            def entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render "ERROR*No se encontró Entry"
                return
            }
            def msg = ""
            def ok = ""
            def fotos = entryInstance.fotos
            fotos.each { f ->
                f.likes = (f.likes ?: 0) + 1
                if (!f.save(flush: true)) {
                    msg += "<li>" + renderErrors(bean: f) + "</li>"
                } else {
                    ok += f.likes + "_"
                }
            }
            if (msg != "") {
                render "<ul>" + msg + "</ul>"
                return
            }
            render "SUCCESS*" + ok
            return
        } else {
            render "ERROR*No se encontró Entry"
        }
    }

    def listReportados() {
        def list = Entry.findAllByDeletedAndReportadoGreaterThan(0, 0, [sort: "reportado", order: "desc"])

        return [list: list]
    }

    def reportar_ajax() {
        if (params.id) {
            if (params.razon.trim() != "") {
                def entryInstance = Entry.get(params.id)
                if (!entryInstance) {
                    render "ERROR*No se encontró Entry"
                    return
                }
                entryInstance.reportado = (entryInstance.reportado ?: 0) + 1
                if (!entryInstance.save(flush: true)) {
                    render "ERROR*Ha ocurrido un error al guardar Entry: " + renderErrors(bean: entryInstance)
                    return
                }
                def usuario = Usuario.get(params.usu)
                def reporte = ReporteEntry.findOrSaveByEntryAndUsuario(entryInstance, usuario)
                reporte.razon = params.razon
                if (!reporte.save(flush: true)) {
                    render "ERROR*Ha ocurrido un error al guardar Reporte: " + renderErrors(bean: reporte)
                    return
                }
                render "SUCCESS*Se ha registrado su reporte"
                return
            } else {
                render "ERROR*No se puede registrar un reporte sin razón"
                return
            }
        } else {
            render "ERROR*No se encontró Entry"
        }
    }

    def comment() {
        println "COMMENT::: " + params
        if (!params.usuario) {
            params.usuario = 9
        }

        def usuario = Usuario.get(params.usuario)
        if (params.id) {
            def entryInstance = Entry.get(params.id.toLong())
            if (!entryInstance) {
                flash.tipo = "notFound"
                flash.message = "No se encontró nada que mostrar"
            }
            def comentarios = ""

            Comentario.findAllByEntry(entryInstance, [sort: 'fecha']).each { com ->
                comentarios += printComment(com, usuario)
            }

            return [entryInstance: entryInstance, comentarios: comentarios, usuario: usuario]
        } else {
            flash.tipo = "notFound"
            flash.message = "No se encontró nada que mostrar"
            return [entryInstance: null]
        }
    }

    def getComments(id, usuario) {
        if (id) {
            def entryInstance = Entry.get(id)
            if (!entryInstance) {
                render ""
            }
            def comentarios = ""

            Comentario.findAllByEntry(entryInstance, [sort: 'fecha']).each { com ->
                comentarios += printComment(com, usuario)
            }

            def js = "<script type='text/javascript'>"
            js += '$(".btnContestar").click(function () {'
            js += 'dialogComentario($(this).attr("id"));'
            js += 'return false;'
            js += '});'
            js += "</script>"

            render comentarios + js
        } else {
            render ""
            return
        }
    }

    def printComment(Comentario comentario, Usuario usuario) {
        def html = ""
        html += '<div class="media my-media bg-info ui-corner-all">'
//        html += "<div >"
        html += '<div class="thumbnail pull-left text-center">'
        if (comentario.usuario) {
            html += "<p>" + comentario.usuario.nombre + " " + comentario.usuario.apellido + "<br/>" + comentario.usuario.titulo + "</p>"
        }
        html += "<p><i class='fa fa-comment${comentario.padre ? 's' : ''} fa-3x fa-flip-horizontal text-info'></i></p>"
        html += '</div>'
        html += '<div class="media-body">'
        html += '<div class="text-right text-info"><small>' + comentario.fecha.format("dd-MM-yyyy HH:mm") + "</small></div>"
        html += "<p>${comentario.texto}</p>"
        if (usuario) {
            html += "<a href='#' class='btn btn-info pull-right btnContestar' id='${comentario.id}' title='Contestar'><i class='fa fa-comments'></i> </a>"
        }
        html += '</div>'
//        html += "</div>"
        Comentario.findAllByPadre(comentario, [sort: "fecha"]).each { com ->
            html += printComment(com, usuario)
        }

        html += "</div>"
        return html
    }

    def comentar_ajax() {
        if (params.id) {
            def entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render ""
                return
            }
            def usuario = Usuario.get(params.usu)
            def comentario = params.com
            def comment = new Comentario()
            if (params.padre) {
                comment.entry = null
                comment.padre = Comentario.get(params.padre)
            } else {
                comment.entry = entryInstance
                comment.padre = null
            }
            comment.texto = comentario
            comment.usuario = usuario
            comment.fecha = new Date()
            comment.likes = 0
            if (!comment.save(flush: true)) {
                render ""
                return
            }
            render getComments(params.id, usuario)
        } else {
            render ""
            return
        }
    }

    def
    list() {
        def entryInstanceList = getList(params, false)
        def entryInstanceCount = getList(params, true).size()
        return [entryInstanceList: entryInstanceList, entryInstanceCount: entryInstanceCount, params: params]
    }

    def show() {
        if (params.id) {
            def entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
            def path = servletContext.getRealPath("/") + "uploaded/"
            def pathThumb = path + "markers/"
            new File(pathThumb).mkdirs()
            entryInstance.fotos.each { foto ->
                def thumb = new File(pathThumb + foto.path)
                if (!thumb.exists()) {
                    imageResizeService.createMarker(path + foto.path, pathThumb + foto.path)
                }
            }
            return [entryInstance: entryInstance]
        } else {
            render "ERROR*No se encontró Entry."
        }
    } //show

    def show_ajax() {
        if (params.id) {
            def entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
            return [entryInstance: entryInstance]
        } else {
            render "ERROR*No se encontró Entry."
        }
    } //show para cargar con ajax en un dialog

    def form() {
        def entry = new Entry()
        if (params.id) {
            entry = Entry.get(params.id.toLong())
            if (!entry) {
                entry = new Entry()
            }
        }
        return [entry: entry]
    } //form

    def save() {
        def entry = new Entry()
        if (params.id) {
            entry = Entry.get(params.id)
            if (!entry) {
                entry = new Entry()
            }
        }

        def familia = Familia.findOrSaveByNombre(params.familia.trim())
        def genero = Genero.findOrSaveByNombreAndFamilia(params.genero.trim(), familia)
        def especie = Especie.findOrSaveByNombreAndGenero(params.especie.trim(), genero)
        especie.nombreComun = params.nombreComun.trim()
        especie.color1 = Color.get(params.color1.toLong())
        if (params.color2) {
            especie.color2 = Color.get(params.color2.toLong())
        }
        especie.save(flush: true)

        entry.especie = especie
        if (!params.id) {
            entry.fecha = new Date()
        }
        entry.observaciones = params.observaciones.trim()
        entry.save(flush: true)

        def coord = Coordenada.findOrSaveByLatitudAndLongitud(params.latitud.toDouble(), params.longitud.toDouble())
        coord.altitud = params.altitud.toDouble()
        coord.save(flush: true)

        def foto = new Foto()
        if (params.id) {
            foto = entry.fotos.first()
        }
        foto.coordenada = coord
        foto.entry = entry
        foto.especie = especie
        def keys = ["animal", "arbol", "corteza", "hoja", "flor", "fruta"]
        def keywords = ""
        keys.each { k ->
            if (params[k] == "on") {
                if (keywords != "") {
                    keywords += ", "
                }
                keywords += k
            }
        }
        foto.keyWords = keywords
        foto.save(flush: true)

        def path = servletContext.getRealPath("/") + "uploaded/"
        def pathThumb = servletContext.getRealPath("/") + "uploaded/markers/"
        def pathAndroid = servletContext.getRealPath("/") + "uploaded/android/"
        new File(path).mkdirs()
        new File(pathThumb).mkdirs()
        new File(pathAndroid).mkdirs()

        def f = request.getFile("file")
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                }
            }

            ext = "jpg"
            fileName = fileName.size() < 40 ? fileName : fileName[0..39]
            fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

            def nombre = fileName + "." + ext
            def pathFile = path + nombre
            def fn = fileName
            def src = new File(pathFile)
            def i = 1
            while (src.exists()) {
                nombre = fn + "_" + i + "." + ext
                pathFile = path + nombre
                src = new File(pathFile)
                i++
            }
            try {
                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                foto.path = nombre
                foto.save(flush: true)
                //println pathFile
            } catch (e) {
                println "error transfer to file ????????\n" + e + "\n???????????"
            }
            imageResizeService.createMarker(pathFile, pathThumb + nombre)
            imageResizeService.resizeAndroid(pathFile, pathAndroid + nombre)
        } else {
            println "error es empty"
        }
        redirect(controller: "entry", action: "list")
    }//save

    def form_ajax() {
        def entryInstance = new Entry()
        if (params.id) {
            entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
        }
        entryInstance.properties = params
        return [entryInstance: entryInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def entryInstance = new Entry()
        if (params.id) {
            entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
        }
        entryInstance.properties = params
        if (!entryInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Entry: " + renderErrors(bean: entryInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Entry exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render "ERROR*No se encontró Entry."
                return
            }
//                entryInstance.delete(flush: true)
            entryInstance.deleted = 1
            if (entryInstance.save(flush: true)) {
                render "SUCCESS*Eliminación de Entry exitosa."
            }
            return
        } else {
            render "ERROR*No se encontró Entry."
            return
        }
    } //delete para eliminar via ajax

//    def delete_ajax() {
//        if (params.id) {
//            def entryInstance = Entry.get(params.id)
//            if (!entryInstance) {
//                render "ERROR*No se encontró Entry."
//                return
//            }
//            try {
//                entryInstance.delete(flush: true)
//                render "SUCCESS*Eliminación de Entry exitosa."
//                return
//            } catch (DataIntegrityViolationException e) {
//                render "ERROR*Ha ocurrido un error al eliminar Entry"
//                return
//            }
//        } else {
//            render "ERROR*No se encontró Entry."
//            return
//        }
//    } //delete para eliminar via ajax

}
