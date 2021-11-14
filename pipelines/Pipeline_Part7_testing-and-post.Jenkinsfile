pipeline {
    agent any
    stages {
        
        stage('Build') {
            steps {
                echo 'Building ...'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing ...'
                sh 'python3 -m unittest test_two_sum.py'
            }
        }
        stage('Deploy') {
            steps {
                echo 'in deployment'
            }
        }
    }
    post {

        // This runs regardles of the build status
        always {
            echo 'This will always run'
        }

        // This runs if the build status is SUCCESS
        success {
            echo 'Pipeline execution was a success!'
        }

        // This runs if the build status is FAILURE
        failure {
            echo 'Pipeline execution was a failure!'
        }

        // This runs if the build status is UNSTABLE
        unstable {
            echo 'Build was marked as unstable!'
        }

        // This only runs if the build status is different than the previous build
        changed {
            echo 'Pipeline status of this build is different than the previous build!'
        }
    }
}