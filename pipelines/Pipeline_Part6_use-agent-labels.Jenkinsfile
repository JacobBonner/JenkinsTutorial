pipeline {

    // Specify the agent to build on by using a label
    agent {
        label 'docker'
    }
    stages {

        // Execute a step on the agent
        stage('GetDockerVersion'){

            // Run simple shell command to get the version of docker that is installed
            steps {
                sh 'docker --version'
            }
        }
    }
}