package ikiam

import org.springframework.dao.DataIntegrityViolationException

class AtraccionTuristicaController {

    def imageResizeService

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    def atracciones() {
        def atracciones = AtraccionTuristica.list()
        def datos = ""
        atracciones.each {
            def foto = Foto.findByAtraccion(it)
            datos += it.nombre + "&" + it.likes + "&" + it.coordenada.latitud + "&" + it.coordenada.longitud + "&" + foto.path + "&" + it.url +"&"+ it.descripcion+";"

        }
        //println "datos "+datos
        render datos
    }

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
            def c = AtraccionTuristica.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("nombre", "%" + params.search + "%")
                    ilike("url", "%" + params.search + "%")
                }
            }
        } else {
            list = AtraccionTuristica.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def atraccionTuristicaInstanceList = getList(params, false)
        def atraccionTuristicaInstanceCount = getList(params, true).size()
        return [atraccionTuristicaInstanceList: atraccionTuristicaInstanceList, atraccionTuristicaInstanceCount: atraccionTuristicaInstanceCount, params: params]
    }

    def show_ajax() {
        if (params.id) {
            def atraccionTuristicaInstance = AtraccionTuristica.get(params.id)
            if (!atraccionTuristicaInstance) {
                render "ERROR*No se encontró AtraccionTuristica."
                return
            }
            return [atraccionTuristicaInstance: atraccionTuristicaInstance]
        } else {
            render "ERROR*No se encontró AtraccionTuristica."
        }
    } //show para cargar con ajax en un dialog

    def show() {
        if (params.id) {
            def atraccionInstance = AtraccionTuristica.get(params.id)
            if (!atraccionInstance) {
                render "ERROR*No se encontró Atracción Turística."
                return
            }
            def path = servletContext.getRealPath("/") + "atraccion/"
            def pathThumb = path + "markers/"
            new File(pathThumb).mkdirs()
            atraccionInstance.fotos.each { foto ->
                def thumb = new File(pathThumb + foto.path)
                if (!thumb.exists()) {
                    imageResizeService.createMarker(path + foto.path, pathThumb + foto.path)
                }
            }
            return [atraccionInstance: atraccionInstance]
        } else {
            render "ERROR*No se encontró Atracción Turística."
        }
    } //show

    def form_ajax() {
        def atraccionTuristicaInstance = new AtraccionTuristica()
        if (params.id) {
            atraccionTuristicaInstance = AtraccionTuristica.get(params.id)
            if (!atraccionTuristicaInstance) {
                render "ERROR*No se encontró AtraccionTuristica."
                return
            }
        }
        atraccionTuristicaInstance.properties = params
        return [atraccionTuristicaInstance: atraccionTuristicaInstance]
    } //form para cargar con ajax en un dialog

    def form() {
        def atraccion = new AtraccionTuristica()
        if (params.id) {
            atraccion = AtraccionTuristica.get(params.id.toLong())
            if (!atraccion) {
                atraccion = new AtraccionTuristica()
            }
        }
        return [atraccion: atraccion]
    } //form

    def save() {
        def atraccion = new AtraccionTuristica()

        def coord = Coordenada.findOrSaveByLatitudAndLongitud(params.latitud.toDouble(), params.longitud.toDouble())
        coord.altitud = params.altitud.toDouble()
        coord.save(flush: true)

        if (params.id) {
            atraccion = AtraccionTuristica.get(params.id)
            if (!atraccion) {
                atraccion = new AtraccionTuristica()
            }
        }

        atraccion.properties = params
        atraccion.coordenada = coord
        atraccion.save(flush: true)

        def foto = new Foto()
        if (params.id) {
            foto = atraccion.fotos.first()
        }
        foto.coordenada = coord
        foto.atraccion = atraccion
        foto.save(flush: true)

        def path = servletContext.getRealPath("/") + "atraccion/"
        def pathThumb = path + "markers/"
        def pathAndroid = path + "android/"
        new File(path).mkdirs()
        new File(pathThumb).mkdirs()
        new File(pathAndroid).mkdirs()
        def oldPath = ""

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
                oldPath = foto.path
                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                foto.path = nombre
                foto.save(flush: true)
                //println pathFile
            } catch (e) {
                println "error transfer to file ????????\n" + e + "\n???????????"
            }
//            println "OLD PATH: " + oldPath
//            println "OLD PATH: " + path + oldPath
            if (oldPath != "") {
                def oldFile = new File(path + oldPath)
                def oldMarker = new File(path + "markers/" + oldPath)
                def oldAndroid = new File(path + "android/" + oldPath)
//                println "exists: " + oldFile.exists()
                if (oldFile.exists()) {
                    oldFile.delete()
                }
                if (oldMarker.exists()) {
                    oldMarker.delete()
                }
                if (oldAndroid.exists()) {
                    oldAndroid.delete()
                }
            }
            imageResizeService.createMarker(pathFile, pathThumb + nombre)
            imageResizeService.resizeAndroid(pathFile, pathAndroid + nombre)
        } else {
            println "error es empty"
        }
        redirect(controller: "atraccionTuristica", action: "list")
    }//save

    def save_ajax() {
        def atraccionTuristicaInstance = new AtraccionTuristica()
        if (params.id) {
            atraccionTuristicaInstance = AtraccionTuristica.get(params.id)
            if (!atraccionTuristicaInstance) {
                render "ERROR*No se encontró AtraccionTuristica."
                return
            }
        }
        atraccionTuristicaInstance.properties = params
        if (!atraccionTuristicaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar AtraccionTuristica: " + renderErrors(bean: atraccionTuristicaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de AtraccionTuristica exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def atraccionTuristicaInstance = AtraccionTuristica.get(params.id)
            if (!atraccionTuristicaInstance) {
                render "ERROR*No se encontró AtraccionTuristica."
                return
            }
            try {
                atraccionTuristicaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de AtraccionTuristica exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar AtraccionTuristica"
                return
            }
        } else {
            render "ERROR*No se encontró AtraccionTuristica."
            return
        }
    } //delete para eliminar via ajax

}
