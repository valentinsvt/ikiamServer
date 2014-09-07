dataSource {
    pooled = true
    driverClassName = "org.postgresql.Driver"
    dialect = org.hibernate.dialect.PostgreSQLDialect
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    //cache.provider_class='com.opensymphony.oscache.hibernate.OSCacheProvider'
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
           // url = "jdbc:postgresql://10.0.0.2:5432/ikiam2"
           url = "jdbc:postgresql://127.0.0.1:5432/ikiam"
//            url = "jdbc:postgresql://10.0.0.2:5432/yachay"
            username = "postgres"
            password = "steinsgate"
            //password = "Sunday.server.2011"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://127.0.0.1:5432/ikiam"
            username = "postgres"
            //password = "postgres"
            password = "Sunday.server.2011"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://127.0.0.1:5432/ikiam"
            username = "postgres"
            //password = "postgres"
            password = "steinsgate"
        }
    }
}

//dataSource {
//    pooled = true
//    driverClassName = "org.h2.Driver"
//    username = "sa"
//    password = ""
//}
//hibernate {
//    cache.use_second_level_cache = true
//    cache.use_query_cache = false
//    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
////    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
//}
//
//// environment specific settings
//environments {
//    development {
//        dataSource {
//            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
//            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
//        }
//    }
//    test {
//        dataSource {
//            dbCreate = "update"
//            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
//        }
//    }
//    production {
//        dataSource {
//            dbCreate = "update"
//            url = "jdbc:h2:prodDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
//            properties {
//                maxActive = -1
//                minEvictableIdleTimeMillis=1800000
//                timeBetweenEvictionRunsMillis=1800000
//                numTestsPerEvictionRun=3
//                testOnBorrow=true
//                testWhileIdle=true
//                testOnReturn=false
//                validationQuery="SELECT 1"
//                jdbcInterceptors="ConnectionState"
//            }
//        }
//    }
//}
