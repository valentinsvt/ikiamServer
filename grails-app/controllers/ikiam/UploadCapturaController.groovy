package ikiam

class UploadCapturaController {

    def uploadData() {
        println "::: " + params

        def familia = Familia.findAllByNombre(params.familia)
        def genero = Genero.findAllByNombre(params.genero)
        def especie = Especie.findAllByNombre(params.especie)

        def color1 = Color.findAllByColor(params.color1)
        def color2 = Color.findAllByColor(params.color2)

        def lat = params.lat ? params.lat.toDouble() : null
        def lon = params.long ? params.lon.toDouble() : null

        def coord = null
        if (lat && lon) {
            coord = Coordenada.findAllByLatitudAndLongitud(lat, lon)
            if (coord.size() == 1) {
                coord = coord.first()
            } else if (coord.size() == 0) {
                coord = new Coordenada([
                        latitud : lat,
                        longitud: lon
                ])
                if (!coord.save(flush: true)) {
                    println "Error coord: " + coord.errors
                }
            }
        }

        def fecha = new Date().parse("yyyy-MM-dd HH:mm:ss", params.fecha)

        if (color1.size() == 1) {
            color1 = color1.first()
        } else if (color1.size() == 0) {
            color1 = new Color([
                    color: params.color1
            ])
            if (!color1.save(flush: true)) {
                println "Error color1: " + color1.errors
            }
        }
        if (color2.size() == 1) {
            color2 = color2.first()
        } else if (color2.size() == 0) {
            if (params.color2) {
                color2 = new Color([
                        color: params.color2
                ])
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
            familia = new Familia([
                    nombre: params.familia
            ])
            if (!familia.save(flush: true)) {
                println "Error familia: " + familia.errors
            }
        }
        if (genero.size() == 1) {
            genero = genero.first()
        } else if (genero.size() == 0) {
            genero = new Genero([
                    nombre : params.genero,
                    familia: familia
            ])
            if (!genero.save(flush: true)) {
                println "Error genero: " + genero.errors
            }
        }
        if (especie.size() == 1) {
            especie = especie.first()
        } else if (especie.size() == 0) {
            especie = new Especie([
                    nombre     : params.genero,
                    nombreComun: params.comun,
                    genero     : genero,
                    color1     : color1,
                    color2     : color2
            ])
            if (!especie.save(flush: true)) {
                println "Error especie: " + especie.errors
            }
        }

        def entry = new Entry([
                especie      : especie,
                fecha        : fecha,
                observaciones: params.comentarios
        ])
        if (!entry.save(flush: true)) {
            println "Error entry: " + entry.errors
        }

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

            def foto = new Foto(
                    path: pathFile,
                    keyWords: params.keywords,
                    entry: entry,
                    especie: especie,
                    coordenada: coord
            )
            if (!foto.save(flush: true)) {
                println "Error foto: " + foto.errors
            }

        } else {
            println "error es empty"
        }
        render "ok"
    }
}
