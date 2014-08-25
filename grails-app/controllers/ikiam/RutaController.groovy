package ikiam

import org.springframework.dao.DataIntegrityViolationException

class RutaController {

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
            def c = Ruta.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    eq("id", "%" + params.search + "%")
                }
            }
        } else {
            list = Ruta.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    def list() {
        def rutaInstanceList = getList(params, false)
        def rutaInstanceCount = getList(params, true).size()
        return [rutaInstanceList: rutaInstanceList, rutaInstanceCount: rutaInstanceCount]
    }

    def publish() {
        println "params publish " + params
        def ruta = Ruta.get(params.id)
        if (!ruta) {
            render "ruta no encontrada"
            return
        } else {
            def cords = Coordenada.findAllByRuta(ruta)
            def fotos = Foto.findAllByRuta(ruta)
            fotos.each {
                def data = it.path.split("/")
                println "data " + data
                if (data.size() > 1) {
                    it.path = data[7].trim()
                    it.save(flush: true)
                }

            }
//            println "Ruta: " + ruta
//            println "coords: " + cords
//            println "fotos: " + fotos
            [ruta: ruta, cords: cords, fotos: fotos]
        }
    }

    def rutaUploader() {
        //String parameters = "ruta="+ruta.descripcion+"&fecha="+ruta.fecha+"&coords=";
        println "ruta uploader " + params
        def usuario = null
        if (params.tipo.trim() == "facebook") {
            println "es facebook"
            usuario = Usuario.findByFacebookId(params.userId.trim())
            println "encontro usuario facebook? " + usuario
            if (!usuario) {
                usuario = new Usuario()
                usuario.facebookId = params.userId
                usuario.tipo = "facebook"
                if (params.nombre) {
                    def data = params.nombre.split(" ")
                    if (data.size() > 1) {
                        usuario.nombre = data[0]
                        usuario.apellido = data[1]
                    } else {
                        if (data.size() > 0) {
                            usuario.nombre = data[0]
                        } else {
                            usuario.nombre = "N.A."
                            usuario.apellido = "N.A."
                        }
                    }
                } else {
                    usuario.nombre = "N.A."
                    usuario.apellido = "N.A."
                }
                if (!usuario.save(flush: true)) {
                    println "error save usuario " + usuario.errors
                    usuario = null
                }

            }
        } else {
            usuario = Usuario.get(params.userId)
        }
        def band = true
        def ruta = new Ruta();
        if (usuario) {

            ruta.descripcion = params.ruta
            ruta.fecha = new Date().parse("yyyy-MM-dd HH:mm:ss", params.fecha)
            ruta.usuario = usuario

            if (ruta.save(flush: true)) {
                def datos = params.coords.split("\\|")
                println "datos " + datos
                datos.each { d ->
                    if (d.size() > 0) {
                        def parts = d.split(";")
                        println "parts " + parts
                        def cord = new Coordenada();
                        cord.longitud = parts[1].toDouble()
                        cord.latitud = parts[0].toDouble()
                        cord.altitud = parts[2].toDouble()
                        cord.ruta = ruta
                        if (!cord.save(flush: true)) {
                            println "error save cord " + cord.errors
                            band = false
                        }
                    }
                }
            } else {
                println "error ruta save " + ruta.errors
                band = false
            }
        } else {
            println "no usuario"
            band = false
        }


        if (band) {
            render "" + ruta.id
        } else {
            render "-1"
        }

    }

    def fotoUploader() {
        println " foto uploader" + params

        def ruta = Ruta.get(params.ruta)
        if (!ruta) {
            render "-1"
        } else {
            def path = servletContext.getRealPath("/") + "uploaded/"
            def folderMk = new File(path)
            folderMk.mkdirs()
            def f = request.getFile("foto-file")
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
                def lat = params.lat ? params.lat.toDouble() : null
                def lon = params.long ? params.long.toDouble() : null
                def alt = params.alt ? params.alt.toDouble() : null
                def coord = new Coordenada()
                coord.latitud = lat
                coord.longitud = lon
                coord.altitud = alt
                coord.save(flush: true)
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
                    //println pathFile
                } catch (e) {
                    println "error transfer to file ????????\n" + e + "\n???????????"
                }

                def foto = new Foto()
                foto.path = nombre
                foto.keyWords = ""
                foto.ruta = ruta
                if (coord) {
                    foto.coordenada = coord
                }
                foto.usuario = ruta.usuario
                if (!foto.save(flush: true)) {
                    println "Error foto: " + foto.errors
                }

            } else {
                println "error es empty"
            }
        }
        render "ok"
    }

    def show_ajax() {
        if (params.id) {
            def rutaInstance = Ruta.get(params.id)
            if (!rutaInstance) {
                render "ERROR*No se encontró Ruta."
                return
            }
            return [rutaInstance: rutaInstance]
        } else {
            render "ERROR*No se encontró Ruta."
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def rutaInstance = new Ruta()
        if (params.id) {
            rutaInstance = Ruta.get(params.id)
            if (!rutaInstance) {
                render "ERROR*No se encontró Ruta."
                return
            }
        }
        rutaInstance.properties = params
        return [rutaInstance: rutaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def rutaInstance = new Ruta()
        if (params.id) {
            rutaInstance = Ruta.get(params.id)
            if (!rutaInstance) {
                render "ERROR*No se encontró Ruta."
                return
            }
        }
        rutaInstance.properties = params
        if (!rutaInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar Ruta: " + renderErrors(bean: rutaInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Ruta exitosa."
        return
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def rutaInstance = Ruta.get(params.id)
            if (!rutaInstance) {
                render "ERROR*No se encontró Ruta."
                return
            }
            try {
                rutaInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Ruta exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Ruta"
                return
            }
        } else {
            render "ERROR*No se encontró Ruta."
            return
        }
    } //delete para eliminar via ajax
}
