/*
 48-57      -> numeros
 96-105     -> teclado numerico
 188        -> , (coma)
 190        -> . (punto) teclado
 110        -> . (punto) teclado numerico
 8          -> backspace
 46         -> delete
 9          -> tab
 37         -> flecha izq
 39         -> flecha der
 */
/**
 * retorna true en caso de q la tecla presionada sea un numero (teclado numerico o no), un punto (teclado numerico o no), backspace, delete, tab, flecha izq, flecha der
 *
 * para usar:
 * $(".number").keydown(function (ev) {
 *     return validarInt(ev);
 * });
 *
 * @param ev
 * @returns {boolean}
 */
function validarDec(ev) {
    if (ev.ctrlKey) {
        return true;
    }
    return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||                   // 0-9 teclado normal
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||                  // 0-9 teclado numerico
            ev.keyCode == 190 || ev.keyCode == 110 ||                   // punto tec. normal, punto tec. num
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||   // backspace, delete, tab
            ev.keyCode == 37 || ev.keyCode == 39 ||                     // flecha izq, flecha der
            ev.keyCode == 116);                                         // F5
}

/**
 * retorna true en caso de q la tecla presionada sea un numero (teclado numerico o no), backspace, delete, tab, flecha izq, flecha der
 * @param ev
 * @returns {boolean}
 */
function validarInt(ev) {
    if (ev.ctrlKey) {
        return true;
    }
    return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39 ||
            ev.keyCode == 116);
}

/**
 * muestra notificaciones flotantes
 * @param msg: el mensaje a mostrar
 * @param type: tipo de mensaje: 'error' o 'success'
 * @param title: el titulo del mensaje (opcional)
 * @param hide: si se oculta solo o no (opcional)
 */
function log(msg, type, title, hide) {
    if (!hide) {
        hide = type != "error";
    }
    if (!title) {
        title = type == 'error' ? "Ha ocurrido un error" : "";
    }
    $.pnotify({
        title        : title,
//        addclass     : "stack-bar-top",
//        cornerclass  : 'ui-pnotify-sharp',
//        icon         : "",
        closer_hover : false,
        text         : msg,
        type         : type,
        hide         : hide
    });
}
