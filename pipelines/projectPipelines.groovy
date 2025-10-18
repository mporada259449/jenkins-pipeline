freeStyleJob('example') {
    logRotator(-1, 10)
    steps {
        println "Inside job"
    }
}
