pipelineJob('example') {
    definition {
        cps {
            script('''
                pipeline {
                    agent any
                    stages {
                        stage('Print') {
                            steps {
                                echo 'Inside job'
                            }
                        }
                    }
                }
            ''')
        }
    }
}
