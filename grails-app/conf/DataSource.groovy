dataSource {
    pooled = true
    driverClassName = "org.postgresql.Driver"
    dialect = org.hibernate.dialect.PostgreSQLDialect
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
//            url = "jdbc:postgresql://10.0.0.3:5432/janus2"
//            url = "jdbc:postgresql://10.0.0.2:5432/janus"
            url = "jdbc:postgresql://127.0.0.1:5432/ikiam"
//            url = "jdbc:postgresql://127.0.0.1:5432/gadpp"
            username = "postgres"
            password = "steinsgate"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://10.0.0.3:5432/janus2"
            username = "postgres"
            password = "postgres"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            //url = "jdbc:postgresql://127.0.0.1:5432/janus"
            url = "jdbc:postgresql://127.0.0.1:5432/ikiam"
            username = "postgres"
            password = "steinsgate"
        }

    }


}