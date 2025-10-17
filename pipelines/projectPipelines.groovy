freeStyleJob('example') {
    logRotator(-1, 10)
    steps {
        echo 'Inside job'
    }
}
