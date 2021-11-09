pipeline {

    // Specify the docker image to build on
    agent {
        docker { image 'python:latest' }
    }
    stages {

        // Execute some steps in the container
        stage('Test'){

            // Run simple shell command to show functionality
            steps {
                sh 'python --version'
            }
        }
    }
}