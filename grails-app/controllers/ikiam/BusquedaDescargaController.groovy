package ikiam

class BusquedaDescargaController {

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

        def str = ""
//        def path = servletContext.getRealPath("/") + "uploaded/"

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
                maxResults(3)
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
                str += ";uploaded/" + f.path + ";" + f.coordenada?.latitud + ";" + f.coordenada?.longitud + ";" + f.coordenada?.altitud + ";" + f.entry?.observaciones
//                str += ";" + f.id;
            }
        }
        println "Retorna: " + str
        render str
    }
}
