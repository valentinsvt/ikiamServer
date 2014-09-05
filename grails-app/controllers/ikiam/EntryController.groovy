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
                    }
                }
            }
        } else {
            list = Entry.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def like_ajax() {

    }

    def reportar_ajax() {
        if (params.id) {
            def entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                render "ERROR*No se encontró Entry"
                return
            }
            entryInstance.reportado = entryInstance.reportado ?: 0 + 1
            if (!entryInstance.save(flush: true)) {
                render "ERROR*Ha ocurrido un error al guardar Entry: " + renderErrors(bean: entryInstance)
                return
            }
            render "SUCCESS"
            return
        } else {
            render "ERROR*No se encontró Entry"
        }
    }

    def comment() {
        if (params.id) {
            def entryInstance = Entry.get(params.id)
            if (!entryInstance) {
                flash.tipo = "notFound"
                flash.message = "No se encontró nada que mostrar"
            }
            return [entryInstance: entryInstance]
        } else {
            flash.tipo = "notFound"
            flash.message = "No se encontró nada que mostrar"
            return [entryInstance: null]
        }
    }

    def list() {
        def entryInstanceList = getList(params, false)
        def entryInstanceCount = getList(params, true).size()
        return [entryInstanceList: entryInstanceList, entryInstanceCount: entryInstanceCount, params: params]
    }

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
        redirect(controller: "especie", action: "list")
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
            try {
                entryInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Entry exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Entry"
                return
            }
        } else {
            render "ERROR*No se encontró Entry."
            return
        }
    } //delete para eliminar via ajax

}
