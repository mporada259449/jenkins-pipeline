freeStyleJob('example') {
    logRotator(-1, 10)
    steps {
        shell('echo Inside job')
    }
}
