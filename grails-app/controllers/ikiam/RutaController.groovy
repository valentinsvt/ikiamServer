package ikiam

class RutaController {

    def index() {}

    def rutaUploader(){
        //String parameters = "ruta="+ruta.descripcion+"&fecha="+ruta.fecha+"&coords=";
        println "ruta uploader "+params
        def usuario = null
        if(params.tipo=="facebook"){
            usuario=Usuario.findByFacebookId(params.userId)
            if(!usuario){
                usuario = new Usuario()
                usuario.facebookId=params.userId
                usuario.tipo="facebook"
                if(params.nombre){
                    def data = params.nombre.split(" ")
                    if(data.size()>1) {
                        usuario.nombre = data[0]
                        usuario.apellido = data[1]
                    }else{
                        if(data.size()>0) {
                            usuario.nombre = data[0]
                        }else{
                            usuario.nombre="N.A."
                            usuario.apellido="N.A."
                        }
                    }
                }else{
                    usuario.nombre="N.A."
                    usuario.apellido="N.A."
                }
                if(!usuario.save(flush: true)){
                    usuario=null
                }

            }
        }else{
            usuario=Usuario.get(params.userId)
        }
        def band =true
        if(usuario){
            def ruta = new Ruta();
            ruta.descripcion=params.ruta
            ruta.fecha = new Date().parse("yyyy-MM-dd HH:mm:ss",params.fecha)
            ruta.usuario=usuario

            if(ruta.save(flush: true)){
                def datos = params.coords.split("\\|")
                println "datos "+datos
                datos.each {d->
                    if(d.size()>0){
                        def parts = d.split(";")
                        println "parts "+parts
                        def cord = new Coordenada();
                        cord.longitud=parts[1].toDouble()
                        cord.latitud=parts[0].toDouble()
                        cord.altitud=parts[2].toDouble()
                        cord.ruta=ruta
                        if(!cord.save(flush: true)){
                            println "error save cord "+cord.errors
                            band=false
                        }
                    }
                }
            }else{
                println "error ruta save "+ruta.errors
                band=false
            }
        }else {
            band=false
        }


        if(band){
            render ""+ruta.id
        }else{
            render "-1"
        }

    }

    def fotoUploader() {
        println " foto uploader" + params

        def ruta = Ruta.get(params.ruta)
        if(!ruta){
            render "-1"
        }else{
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
                coord.latitud=lat
                coord.longitud=lon
                coord.altitud=alt
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
                foto.path = pathFile
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
}
