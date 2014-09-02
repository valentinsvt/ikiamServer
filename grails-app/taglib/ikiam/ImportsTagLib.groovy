package ikiam

class ImportsTagLib {
//    static defaultEncodeAs = 'html'
//    static encodeAsForTags = [tagName: 'raw']
    static namespace = 'imp'

    def favicon = { attrs ->
//        def text = "<link rel=\"shortcut icon\" href=\"${resource(dir: 'images', file: 'favicon.ico')}\" type=\"image/x-icon\">\n"
//        text += "   <link rel=\"apple-touch-icon\" href=\"${resource(dir: 'images', file: 'apple-touch-icon.png')}\">\n"
//        text += "   <link rel=\"apple-touch-icon\" sizes=\"114x114\" href=\"${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}\">"

        def text = "<link rel=\"apple-touch-icon\" sizes=\"57x57\" href=\"${resource(dir: 'images/favicons', file: 'apple-touch-icon-57x57.png')}\">\n" +
                "<link rel=\"apple-touch-icon\" sizes=\"72x72\" href=\"${resource(dir: 'images/favicons', file: 'apple-touch-icon-72x72.png')}\">\n" +
                "<link rel=\"apple-touch-icon\" sizes=\"60x60\" href=\"${resource(dir: 'images/favicons', file: 'apple-touch-icon-60x60.png')}\">\n" +
                "<link rel=\"icon\" type=\"image/png\" href=\"${resource(dir: 'images/favicons', file: 'favicon-16x16.png')}\" sizes=\"16x16\">\n" +
                "<link rel=\"icon\" type=\"image/png\" href=\"${resource(dir: 'images/favicons', file: 'favicon-32x32.png')}\" sizes=\"32x32\">\n" +
                "<meta name=\"msapplication-TileColor\" content=\"#ffffff\">"
        out << text
    }

    def cssNoMenu = { attrs ->
        def bootstrapTheme = attrs.bootstrap ?: "theme"
        def jqueryTheme = attrs.jquery ?: "ui-lightness"

        // Bootstrap
        def text = " <link href=\"${resource(dir: 'bootstrap-3.2.0/css', file: 'bootstrap.min.css')}\" rel=\"stylesheet\">\n"
        text += "    <link href=\"${resource(dir: 'bootstrap-3.2.0/css', file: 'bootstrap-' + bootstrapTheme + '.min.css')}\" rel=\"stylesheet\">\n"
        // JQuery
        text += "    <link href=\"${resource(dir: 'js/jquery/css/' + jqueryTheme, file: 'jquery-ui-1.10.4.min.css')}\" rel=\"stylesheet\">\n"
        // FontAwesome
        text += "    <link href=\"${resource(dir: 'fonts/font-awesome-4.2.0/css', file: 'font-awesome.min.css')}\" rel=\"stylesheet\">"
        // MFizz
        text += "    <link href=\"${resource(dir: 'fonts/font-mfizz-1.2', file: 'font-mfizz.css')}\" rel=\"stylesheet\">"
        // Octicons
        text += "    <link href=\"${resource(dir: 'fonts/octicons', file: 'octicons.css')}\" rel=\"stylesheet\">"

        // custom font styles
        text += "    <link href=\"${resource(dir: 'css/custom', file: 'texto.css')}\" rel=\"stylesheet\">"

        out << text
    }

    def css = { attrs ->
        def text = ""
        text += cssNoMenu(bootstrap: attrs.bootstrap, jquery: attrs.jquery)

        // CUSTOM
        text += "    <link href=\"${resource(dir: 'css/custom', file: 'custom.css')}\" rel=\"stylesheet\">"
        text += "    <link href=\"${resource(dir: 'css/custom', file: 'inputs.css')}\" rel=\"stylesheet\">"
        out << text
    }

    def js = { attrs ->
        // jQuery (necessary for Bootstrap's JavaScript plugins)
        def text = " <script src=\"${resource(dir: 'js/jquery/js', file: 'jquery-1.10.2.js')}\"></script>\n"
        text += "    <script src=\"${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.10.4.min.js')}\"></script>\n"
        // Include all compiled plugins (below), or include individual files as needed
        text += "    <script src=\"${resource(dir: 'bootstrap-3.2.0/js', file: 'bootstrap.min.js')}\"></script>"
        text += "    <script src=\"${resource(dir: 'js/plugins/jquery-validation-1.13.0/dist', file: 'jquery.validate.min.js')}\"></script>"
        text += "    <script src=\"${resource(dir: 'js/plugins/jquery-validation-1.13.0/dist/localization', file: 'messages_es.js')}\"></script>"

        out << text
    }

    def customJs = { attrs ->
        def text = "    <script src=\"${resource(dir: 'js', file: 'funciones.js')}\"></script>"
        text += "    <script src=\"${resource(dir: 'js', file: 'functions.js')}\"></script>"
        out << text
    }

    def validation = { attrs ->
        //context js
        def text = "    <script src=\"${resource(dir: 'js/plugins/jquery-validation-1.13.0/dist', file: 'jquery.validate.min.js')}\"></script>"
        text += "       <script src=\"${resource(dir: 'js/plugins/jquery-validation-1.13.0/dist/localization', file: 'messages_es.js')}\"></script>"

        out << text
    }

    def plugins = { attrs ->
        //bootbox
        def text = " <script src=\"${resource(dir: 'js/plugins/bootbox/js', file: 'bootbox.js')}\"></script>\n"
        ///datepicker
        text += "    <script src=\"${resource(dir: 'js/plugins/bootstrap-datepicker/js', file: 'bootstrap-datepicker.js')}\"></script>\n"
        text += "    <script src=\"${resource(dir: 'js/plugins/bootstrap-datepicker/js/locales', file: 'bootstrap-datepicker.es.js')}\"></script>\n"
        text += "    <link href=\"${resource(dir: 'js/plugins/bootstrap-datepicker/css', file: 'datepicker.css')}\" rel=\"stylesheet\">"
        text += "    <link href=\"${resource(dir: 'css/custom/', file: 'datepicker.css')}\" rel=\"stylesheet\">"
        //maxlength
        text += "    <script src=\"${resource(dir: 'js/plugins/bootstrap-maxlength/js', file: 'bootstrap-maxlength.min.js')}\"></script>\n"
        //countdown
        text += "    <script src=\"${resource(dir: 'js/plugins/jquery.countdown', file: 'jquery.countdown.js')}\"></script>"
        text += "    <script src=\"${resource(dir: 'js/plugins/jquery.countdown', file: 'jquery.countdown-es.js')}\"></script>"
        //qtip2
        text += "    <script src=\"${resource(dir: 'js/plugins/jquery.qtip-2.2.0', file: 'jquery.qtip.min.js')}\"></script>"
        text += "    <link href=\"${resource(dir: 'js/plugins/jquery.qtip-2.2.0', file: 'jquery.qtip.min.css')}\" rel=\"stylesheet\">"
        //pines notify
        text += "    <script src=\"${resource(dir: 'js/plugins/pines/js', file: 'jquery.pnotify.min.js')}\"></script>"
        text += "    <link href=\"${resource(dir: 'js/plugins/pines/css', file: 'jquery.pnotify.default.css')}\" rel=\"stylesheet\">"
        //typeahead
        text += "    <script src=\"${resource(dir: 'js/plugins/typeahead.js/js', file: 'typeahead.js')}\"></script>"
        //context js
        text += "    <script type=\"text/javascript\" src=\"${resource(dir: 'js/plugins/lzm.context/js', file: 'lzm.context-0.5.js')}\"></script>"
        text += "    <link href=\"${resource(dir: 'js/plugins/lzm.context/css', file: 'lzm.context-0.5.css')}\" rel=\"stylesheet\">"
        //validation
        text += imp.validation()

        out << text
    }

    def spinners = {
        def text = "<script type=\"text/javascript\">\n" +
                "            var spinner24Url = \"${resource(dir: 'images/spinners', file: 'spinner_24.GIF')}\";\n" +
                "            var spinner64Url = \"${resource(dir: 'images/spinners', file: 'spinner_64.GIF')}\";\n" +
                "\n" +
                "            var spinnerSquare64Url = \"${resource(dir: 'images/spinners', file: 'loading_new.GIF')}\";\n" +
                "\n" +
                "            var spinner = \$(\"<img src='\" + spinner24Url + \"' alt='Cargando...'/>\");\n" +
                "            var spinner64 = \$(\"<img src='\" + spinner64Url + \"' alt='Cargando...'/>\");\n" +
                "            var spinnerSquare64 = \$(\"<img src='\" + spinnerSquare64Url + \"' alt='Cargando...'/>\");\n" +
                "        </script>"
        out << text
    }
}
