package vesta

class MenuTagLib {
//    static defaultEncodeAs = 'html'
    //static encodeAsForTags = [tagName: 'raw']

    static namespace = 'mn'

    def menu = { attrs ->

        def items = [
                [
                        label     : "Inicio",
                        icon      : "fa fa-home",
                        controller: ""
                ],
                [
                        label     : "Atracción turística",
                        icon      : "fa fa-globe",
                        controller: "atraccionTuristica"
                ],
                [
                        label     : "Usuarios",
                        icon      : "fa fa-users",
                        controller: "usuario"
                ],
                [
                        label     : "Rutas",
                        icon      : "fa fa-exchange fa-rotate-90",
                        controller: "ruta"
                ],
                [
                        label     : "Especies",
                        icon      : "fa fa-leaf",
                        controller: "especie"
                ],
                [
                        label: "Configuración",
                        icon : "fa fa-cogs",
                        hijos: [
                                [
                                        label: "Colores",
                                        icon : "fa fa-paint-brush"
                                ]/*,
                                [
                                        label          : "Ventas",
                                        icon           : "fa fa-upload",
                                        separate_before: true
                                ]*/
                        ]
                ]
        ]

        def html = "<nav class=\"navbar navbar-default navbar-fixed-top\" role=\"navigation\">"

        html += "<div class=\"container-fluid\">"

        // Brand and toggle get grouped for better mobile display
        html += '<div class="navbar-header">'
        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">'
        html += '<span class="sr-only">Toggle navigation</span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '</button>'
        html += '<a class="navbar-brand" href="#">' + attrs.title + '</a>'
        html += '</div>'

        // Collect the nav links, forms, and other content for toggling
        html += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">'
        html += '<ul class="nav navbar-nav">'

        items.each { item ->
            def icon = ""
            if (item.icon) {
                icon = "<i class='${item.icon}'></i> "
            }
            if (item.hijos) {
                html += '<li class="dropdown">'
                html += "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>${icon}${item.label} <b class='caret'></b></a>"
                html += '<ul class="dropdown-menu">'
                item.hijos.each { hijo ->
                    def iconh = ""
                    def linkh = "#"
                    if (hijo.controller) {
                        linkh = createLink(controller: hijo.controller ?: "list", action: hijo.action, params: hijo.params)
                    }
                    if (hijo.icon) {
                        iconh = "<i class='${hijo.icon}'></i> "
                    }
                    if (hijo.separate_before) {
                        html += '<li class="divider"></li>'
                    }
                    html += "<li><a href='${linkh}'>${iconh}${hijo.label}</a></li>"
                }
                html += '</ul>'
                html += '</li>'
            } else {
                def link = "#"
                if (item.controller) {
                    link = createLink(controller: item.controller, action: item.action ?: "list", params: item.params)
                }
                html += "<li><a href='${link}'>${icon}${item.label}</a></li>"
            }
        }
        html += '</ul>'

        html += '<ul class="nav navbar-nav navbar-right">'
        html += '<li class="dropdown">'
        html += '<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> Usuario <b class="caret"></b></a>'
        html += '<ul class="dropdown-menu">'
        html += '<li><a href="#"><i class="fa fa-cog"></i> Configuración</a></li>'
        html += '<li class="divider"></li>'
        html += '<li><a href="' + createLink(controller: 'login', action: 'logout') + '"><i class="fa fa-sign-out"></i> Salir</a></li>'
        html += '</ul>'
        html += '</li>'
        html += '</ul>'

        html += '</div><!-- /.navbar-collapse -->'

        html += "</div>"

        html += "</nav>"

        out << html
    }

}
