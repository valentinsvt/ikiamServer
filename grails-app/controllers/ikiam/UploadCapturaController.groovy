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

        def color1 = null, color2 = null, familia = null, genero = null, especie = null, usuario = null, coord = null

        def lat = params.lat ? params.lat.toDouble() : 0
        def lon = params.long ? params.long.toDouble() : 0

        def alt = params.alt ? params.alt.toDouble() : 0

        if (params.color1) {
            color1 = Color.findOrSaveByColor(params.color1.trim())
        }
        if (params.color2) {
            color2 = Color.findOrSaveByColor(params.color2.trim())
        }

        if (params.familia) {
            familia = Familia.findOrSaveByNombre(params.familia.trim())
            genero = Genero.findOrSaveByNombreAndFamilia(params.genero.trim(), familia)
            especie = Especie.findOrSaveByNombreAndGenero(params.especie.trim(), genero)
            especie.nombreComun = params.comun.trim()
            especie.color1 = color1
            especie.color2 = color2
            especie.save(flush: true)
        }

        def userId = params.userId.trim() //id (faceboook - fb id, ikiam db.id
        def userName = params.userName.trim()
        def userType = params.userType.trim() //facebook || ikiam
        def userMail = params.userMail.trim()
        def userCientifico = params.userCientifico.trim() //N || S

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
        } else {
            usuario = Usuario.get(userId)
        }

        if (lat > 0 && lon > 0) {
            coord = Coordenada.findOrSaveByLatitudAndLongitud(lat, lon)
            coord.altitud = alt
            coord.save(flush: true)
        }

        def fecha = new Date().parse("yyyy-MM-dd HH:mm:ss", params.fecha)

        def entry = new Entry()
        if (especie) {
            entry.especie = especie
        }
        entry.fecha = fecha
        entry.observaciones = params.comentarios.trim()
        entry.usuario = usuario
        entry.cautiverio = (params.cautiverio == "1" ? "S" : "N")
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
