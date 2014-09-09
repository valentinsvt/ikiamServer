package ikiam

class SocialController {

    def fotosUsuarios() {
        println "fotos usuario " + params
        def usuario = null
        if (params.type != "" && params.type != "-1") {
            if (params.type == "ikiam")
                usuario = Usuario.get(params.usuario)
            else
                usuario = Usuario.findByFacebookId(params.usuario)
        }
        def entrys
        println "usuario " + usuario + " " + usuario?.id
        if (usuario) {
            entrys = Entry.findAll("from Entry  where usuario!=${usuario.id} and especie is null")
            println "wtf " + entrys
        } else {
            entrys = Entry.findAllByEspecieIsNull()
        }
        println "entrys " + entrys
        def data = ""
        entrys.each { e ->
            println "entry " + e.usuario?.nombre + " " + e.id
            def foto = Foto.findByEntry(e)
            if (foto) {
                println "foto " + foto + " " + foto.coordenada
                println "obs " + e.observaciones
                data += "" + e.observaciones?.toString()?.decodeURL() + ";" + foto.path + ";" + foto.coordenada.latitud + ";" +
                        foto.coordenada.longitud + ";" + e.usuario?.nombre + " " + e.usuario?.apellido + ";" + e.usuario?.titulo + ";" +
                        foto.likes + ";" + e.id + "&";
            }
        }
        render data
    }
}
