package ikiam

import groovy.json.JsonBuilder

class BusquedaDescargaController {

    def imageResizeService

    def buscaEspecies() {
        println params

        def especies = Especie.withCriteria {
            if (params.comun) {
                ilike("nombreComun", "%" + params.comun.trim() + "%")
            }
            if (params.especie) {
                ilike("nombre", "%" + params.especie.trim() + "%")
            }
            genero {
                if (params.genero) {
                    ilike("nombre", "%" + params.genero.trim() + "%")
                }
                familia {
                    if (params.familia) {
                        ilike("nombre", "%" + params.familia.trim() + "%")
                    }
                    order("nombre", "asc")
                }
                order("nombre", "asc")
            }
            order("nombre", "asc")
        }
        def path = servletContext.getRealPath("/") + "uploaded/"
        def pathThumb = servletContext.getRealPath("/") + "uploaded/markers/"
        def pathAndroid = servletContext.getRealPath("/") + "uploaded/android/"
        new File(path).mkdirs()
        new File(pathThumb).mkdirs()
        new File(pathAndroid).mkdirs()

        def objs = []
        especies.each { e ->
            def obj = [:]
            def c = Foto.createCriteria()
            def fotos = c.listDistinct() {
                or {
                    eq("especie", e)
                    entry {
                        eq("especie", e)
                    }
                }
                maxResults(6)
            }
            obj.nombreComun = e.nombreComun
            obj.familia = e.genero?.familia?.nombre
            obj.genero = e.genero?.nombre
            obj.especie = e.nombre
            obj.color1 = e.color1.color
            obj.color2 = e.color2 ? e.color2.color : "-"
            obj.fotos = []
            fotos.each { f ->
                def thumb = new File(pathThumb + f.path)
                def android = new File(pathAndroid + f.path)
                if (!thumb.exists()) {
                    imageResizeService.createMarker(path + f.path, pathThumb + f.path)
                }
                if (!android.exists()) {
                    imageResizeService.resizeAndroid(path + f.path, pathAndroid + f.path)
                }

                def objf = [:]
                objf.path = "uploaded/android/" + f.path
                objf.latitud = f.coordenada?.latitud ?: 0
                objf.longitud = f.coordenada?.longitud ?: 0
                objf.altitud = f.coordenada?.altitud ?: 0
                objf.keywords = f.keyWords
                objf.observaciones = f.entry?.observaciones ?: ""
                obj.fotos += objf
            }
            objs += obj
        }

        def json = new JsonBuilder(objs)
        println json
        render json
    }

    def buscaEspecies_old() {
        println params

        def especies = Especie.withCriteria {
            if (params.comun) {
                ilike("nombreComun", "%" + params.comun.trim() + "%")
            }
            if (params.especie) {
                ilike("nombre", "%" + params.especie.trim() + "%")
            }
            genero {
                if (params.genero) {
                    ilike("nombre", "%" + params.genero.trim() + "%")
                }
                familia {
                    if (params.familia) {
                        ilike("nombre", "%" + params.familia.trim() + "%")
                    }
                    order("nombre", "asc")
                }
                order("nombre", "asc")
            }
            order("nombre", "asc")
        }

        def str = ""
        def path = servletContext.getRealPath("/") + "uploaded/"
        def pathThumb = servletContext.getRealPath("/") + "uploaded/markers/"
        def pathAndroid = servletContext.getRealPath("/") + "uploaded/android/"
        new File(path).mkdirs()
        new File(pathThumb).mkdirs()
        new File(pathAndroid).mkdirs()

        especies.each { e ->
//            def fotos = Foto.findAllByEspecie(e, [max: 3])
            def c = Foto.createCriteria()
            def fotos = c.listDistinct() {
                or {
                    eq("especie", e)
                    entry {
                        eq("especie", e)
                    }
                }
                maxResults(6)
            }
            if (str != "") {
                str += "&"
            }
            str += e.nombreComun + ";" + e.genero?.familia?.nombre + ";" + e.genero?.nombre + ";" + e.nombre + ";" + e.id + ";" + e.color1.color
            if (e.color2) {
                str += ";" + e.color2.color
            } else {
                str += ";-"
            }
            fotos.each { f ->
                def thumb = new File(pathThumb + f.path)
                def android = new File(pathAndroid + f.path)
                if (!thumb.exists()) {
                    imageResizeService.createMarker(path + f.path, pathThumb + f.path)
                }
                if (!android.exists()) {
                    imageResizeService.resizeAndroid(path + f.path, pathAndroid + f.path)
                }
                str += ";uploaded/android/" + f.path + ";" + (f.coordenada?.latitud ?: 0) + ";" + (f.coordenada?.longitud ?: 0) +
                        ";" + (f.coordenada?.altitud ?: 0) + ";" + (f.entry?.observaciones ?: "")
//                str += ";" + f.id;
            }
        }
        println "Retorna: " + str
        render str
    }
}
