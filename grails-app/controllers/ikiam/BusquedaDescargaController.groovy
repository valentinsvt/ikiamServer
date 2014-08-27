package ikiam

class BusquedaDescargaController {

    def buscaEspecies() {
//        println params

        def especies = Especie.withCriteria {
            if (params.comun) {
                ilike("nombreComun", "%" + params.comun.trim() + "%")
            }
            if (params.especie) {
                ilike("nombre", "%" + params.especie.trim() + "%")
            }
            if (params.genero || params.familia) {
                genero {
                    if (params.genero) {
                        ilike("nombre", "%" + params.genero.trim() + "%")
                        if (params.familia) {
                            familia {
                                ilike("nombre", "%" + params.familia.trim() + "%")
                            }
                        }
                    }
                }
            }
        }

        def str = ""

        especies.each { e ->
            def fotos = Foto.findAllByEspecie(e, [max: 3])
            if (str != "") {
                str += "&"
            }
            str += e.nombreComun + ";" + e.genero?.familia?.nombre + ";" + e.genero?.nombre + ";" + e.nombre + ";" + e.id + ";" + e.color1.color
            if (e.color2) {
                str += ";" + e.color2.color
            }
            fotos.each { f ->
                str += ";" + f.id
            }
        }
        println "Retorna: " + str
        render str
    }
}
