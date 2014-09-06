package ikiam

class UtilsTagLib {
//    static defaultEncodeAs = 'html'
    //static encodeAsForTags = [tagName: 'raw']

    static namespace = "util"

    def renderHTML = { attrs ->
        out << attrs.html
    }
}
