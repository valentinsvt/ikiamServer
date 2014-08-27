package ikiam

class BusquedaDescargaController {

    def buscaEspecies() {
        println params

        def especies = Especie.withCriteria {
            if (params.comun) {
                ilike("nombreComun", "%" + params.comun + "%")
            }
            if (params.especie) {
                ilike("nombre", "%" + params.especie + "%")
            }
            if (params.genero || params.familia) {
                genero {
                    if (params.genero) {
                        ilike("nombre", "%" + params.genero + "%")
                        if (params.familia) {
                            familia {
                                ilike("nombre", "%" + params.familia + "%")
                            }
                        }
                    }
                }
            }
        }

        def str = ""

        especies.each { e ->
            if (str != "") {
                str += "&"
            }
            str += e.nombreComun + ";" + e.genero?.familia?.nombre + ";" + e.genero?.nombre + ";" + e.nombre + ";" + e.color1.color
            if (e.color2) {
                str += ";" + e.color2.color
            }
        }

        render str
    }
}
