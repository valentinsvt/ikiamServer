package ikiam

class SocialController {

    def fotosUsuarios(){
        println "fotos usuario "+params
        def usuario = null
        if(params.type!="" && params.type!="-1"){
            if(params.type=="ikiam")
                usuario=Usuario.get(params.usuario)
            else
                usuario=Usuario.findByFacebookId(params.usuario)
        }
        def entrys
        if(usuario){
            entrys=Entry.findAllByUsuarioNotEqualAndEspecieIsNull(usuario)
        }else{
            entrys=Entry.findAllByEspecieIsNull()
        }
        def data =""
        entrys.each {e->
            println "entry "+e.usuario.nombre+" "+e.id
            def foto = Foto.findAllByEntry(e)
            if(foto){
                data+=""+e.observaciones+";"+foto.path+";"+foto.coordenada.latitud+";"+foto.coordenada.longitud+";"+e.usuario.nombre+" "+e.usuario.apellido+";"+e.usuario.titulo+"&";
            }
        }
        render data

    }
}
