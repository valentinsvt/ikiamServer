/**
 * Created with IntelliJ IDEA.
 * User: luz
 * Date: 11/12/13
 * Time: 1:05 PM
 * To change this template use File | Settings | File Templates.
 */

//hace q todos los elementos con un atributo title tengan el title bonito de twitter bootstrap
//$('[title!=]').tooltip({});

//hace q todos los elementos con un atributo title tengan el title bonito de qtip2
$('[title!=""]').qtip({
    style    : {
        classes : 'qtip-tipsy'
    },
    position : {
        my : "bottom center",
        at : "top center"
    }
});

//hace q los inputs q tienen maxlenght muestren la cantidad de caracteres utilizados/caracterres premitidos
$('[maxlength]').maxlength({
    alwaysShow        : true,
    warningClass      : "label label-success",
    limitReachedClass : "label label-important",
    placement         : 'top'
});

//para los dialogs, setea los defaults
bootbox.setDefaults({
    locale      : "es",
    closeButton : false,
    show        : true
});

////para el context menu deshabilita el click derecho en las paginas
//$("html").contextMenu({
//    items  : {
//        header : {
//            label  : "No click derecho!!",
//            header : true
//        }
//    }
//});

$(".digits").keydown(function (ev) {
    return validarInt(ev);
});

$(".number").keydown(function (ev) {
    return validarDec(ev);
});

function doSearch($btn) {
    var str = $btn.parent().prev().val();
    location.href = $btn.attr("href") + "?search=" + str;
}
$(".btn-search").click(function () {
    doSearch($(this));
    return false;
});
$(".input-search").focus().keyup(function (ev) {
    if (ev.keyCode == 13) {
        doSearch($(this).next().children("a"));
    }
});

