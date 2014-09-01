package ikiam

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC

class UploadCapturaController {

    def imageResizeService

    /*
           si tipoUsuario == facebook
                   validar si existe usuario (facebokId) y si no ingresar
    */

    def uploadData() {
        println "::: " + params

        def familia = Familia.findAllByNombre(params.familia)
        def genero = Genero.findAllByNombre(params.genero)
        def especie = Especie.findAllByNombre(params.especie)

        def color1 = Color.findAllByColor(params.color1)
        def color2 = Color.findAllByColor(params.color2)

        def userId = params.userId //id (faceboook - fb id, ikiam db.id
        def userName = params.userName
        def userType = params.userType //facebook || ikiam
        def userMail = params.userMail
        def userCientifico = params.userCientifico //N || S

        def usuario
        if (userType == "facebook") {
            usuario = Usuario.findByFacebookId(userId)
            if (!usuario) {
                usuario = new Usuario()
                usuario.facebookId = userId
                usuario.nombre = userName
                usuario.apellido = userName
                usuario.password = userName
                usuario.esAdmin = "N"
                usuario.esCientifico = "N"
                if (userMail != "-1") {
                    usuario.email = userMail
                }
                usuario.tipo = "facebook"
                if (!usuario.save(flush: true)) {
                    println "error save usuario: " + usuario.errors
                }
            }
        }

        def lat = params.lat ? params.lat.toDouble() : null
        def lon = params.long ? params.long.toDouble() : null

        def coord = null
        if (lat && lon) {
            coord = Coordenada.findAllByLatitudAndLongitud(lat, lon)
            if (coord.size() == 1) {
                coord = coord.first()
            } else if (coord.size() == 0) {
                coord = new Coordenada()
                coord.latitud = lat
                coord.longitud = lon
                if (!coord.save(flush: true)) {
                    println "Error coord: " + coord.errors
                }
            }
        }

        def fecha = new Date().parse("yyyy-MM-dd HH:mm:ss", params.fecha)

        if (color1.size() == 1) {
            color1 = color1.first()
        } else if (color1.size() == 0) {
            if (params.color1) {
                color1 = new Color()
                color1.color = params.color1
                if (!color1.save(flush: true)) {
                    println "Error color1: " + color1.errors
                }
            } else {
                color1 = null
            }
        }
        if (color2.size() == 1) {
            color2 = color2.first()
        } else if (color2.size() == 0) {
            if (params.color2) {
                color2 = new Color()
                color2.color = params.color2
                if (!color2.save(flush: true)) {
                    println "Error color2: " + color2.errors
                }
            } else {
                color2 = null
            }
        }
        if (familia.size() == 1) {
            familia = familia.first()
        } else if (familia.size() == 0) {
            if (params.familia) {
                familia = new Familia()
                familia.nombre = params.familia
                if (!familia.save(flush: true)) {
                    println "Error familia: " + familia.errors
                }
            } else {
                familia = null
            }
        }
        if (genero.size() == 1) {
            genero = genero.first()
        } else if (genero.size() == 0) {
            if (params.genero) {
                genero = new Genero()
                genero.nombre = params.genero
                genero.familia = familia
                if (!genero.save(flush: true)) {
                    println "Error genero: " + genero.errors
                }
            } else {
                genero = null
            }
        }
        if (especie.size() == 1) {
            especie = especie.first()
        } else if (especie.size() == 0) {
            if (params.especie) {
                especie = new Especie()
                especie.nombre = params.especie
                especie.nombreComun = params.comun
                if (genero) {
                    especie.genero = genero
                }
                especie.color1 = color1
                especie.color2 = color2
                if (!especie.save(flush: true)) {
                    println "Error especie: " + especie.errors
                }
            } else {
                especie = null
            }
        }

        def entry = new Entry()
        if (especie) {
            entry.especie = especie
        }
        entry.fecha = fecha
        entry.observaciones = params.comentarios
        entry.usuario = usuario
        if (!entry.save(flush: true)) {
            println "Error entry: " + entry.errors
        }

        def path = servletContext.getRealPath("/") + "uploaded/"
        def pathThumb = servletContext.getRealPath("/") + "uploaded/markers/"
        def pathAndroid = servletContext.getRealPath("/") + "uploaded/android/"
        new File(path).mkdirs()
        new File(pathThumb).mkdirs()
        new File(pathAndroid).mkdirs()

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

            imageResizeService.createMarker(pathFile, pathThumb + nombre)
            imageResizeService.resizeAndroid(pathFile, pathAndroid + nombre)

            def foto = new Foto()
            foto.path = nombre
            foto.keyWords = params.keywords
            foto.entry = entry
            if (especie) {
                foto.especie = especie
            }
            if (coord) {
                foto.coordenada = coord
            }
            foto.usuario = usuario
            if (!foto.save(flush: true)) {
                println "Error foto: " + foto.errors
            }

        } else {
            println "error es empty"
        }
        render "ok"
    }
}
