<%@ page import="ikiam.Genero" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'genero.label', default: 'Genero')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>

    <body>
        <a href="#list-genero" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
            </ul>
        </div>

        <div id="list-genero" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                    <tr>

                        <g:sortableColumn property="nombre" title="${message(code: 'genero.nombre.label', default: 'Nombre')}"/>

                        <th><g:message code="genero.familia.label" default="Familia"/></th>

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${generoInstanceList}" status="i" var="generoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td>
                                <g:link action="show" id="${generoInstance.id}">
                                    ${URLDecoder.decode(generoInstance.nombre, "UTF-8")}
                                %{--${generoInstance.nombre.toString().decodeUrl()}--}%
                                </g:link>
                            </td>

                            <td>
                                ${URLDecoder.decode(generoInstance.familia?.nombre, "UTF-8")}
                            </td>

                        </tr>
                    </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${generoInstanceCount ?: 0}"/>
            </div>
        </div>
    </body>
</html>
