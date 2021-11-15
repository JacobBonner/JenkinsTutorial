pipeline {
    agent any
    stages {
        
        stage('Build') {
            steps {
                echo 'Building ...'
                sh  '''
                    echo 'Jenkins' > application.txt
                    echo 'is' >> application.txt
                    echo 'Cool' >> application.txt
                    '''
            }
            post {
                success {
                    echo 'Build Complete!'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Testing ...'
                sh  '''
                      for n in Jenkins is Super Cool
                        do 
                            if grep $n application.txt; then
                                echo "Test for '$n' passed!"
                            else
                                echo "Test for '$n' failed!"
                                exit 1
                            fi
                        done
                    '''
            }
            post {
                success {
                    echo 'All Tests Passed!'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying ...'
            }
            post {
                success {
                    echo 'Deployment Finished!'
                }
            }
        }
    }
    post {

        // This always runs after every other section in the post block
        cleanup {
            echo 'This is always the last section to run, regardless of build status!'
        }

        // This runs if the build status is NOT success
        unsuccessful {
            echo 'Pipeline execution was NOT success!'
        }

        // This runs if the build status is UNSTABLE
        unstable {
            echo 'Build was marked as unstable!'
        }

        // This runs if the build status is SUCCESS
        success {
            echo 'Pipeline execution was a success!'
        }

        // This runs if the build status is FAILURE
        failure {
            echo 'Pipeline execution was a failure!'
        }

        // This only runs if the build status is aborted
        aborted {
            echo 'Pipeline execution was aborted!'
        }

        // This only runs if the build status is failure, unstable, or aborted, and the previous build was success
        regression {
            echo 'Pipeline status of this build is failure, unstable, or aborted, and the previous build was success!'
        }

        // This only runs if the build status is 'success' and the previous build was failed or unstable
        fixed {
            echo 'Pipeline status of this build is success, and the previous build was failed or unstable!'
        }

        // This only runs if the build status is different than the previous build
        changed {
            echo 'Pipeline status of this build is different than the previous build!'
        }

        // This runs regardless of the build status
        always {
            echo 'This will always run!'
        }
    }
}