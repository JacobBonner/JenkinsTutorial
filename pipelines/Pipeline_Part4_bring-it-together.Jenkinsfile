pipeline {

    // Specify the agent to build on
    agent any

    // Define the parameters for the pipeline
    parameters {

        // The greeting to give
        choice (
            name: 'greeting',  
            description: 'A greeting to give.',
            choices: [
                'Hello',
                'Good morning',
                'Good afternoon',
                'Good evening'
            ]
        )

        // Who the greeting is directed to
        string (
            name: 'receiver', 
            defaultValue: 'World', 
            description: 'Who the greeting parameter is directed to, i.e. who will be receiving the greeting.'
        )
    }

    // Define environment variables for the entire pipeline
    environment {
        GLOBAL_VAR = "Sample global-scope environment variable"
    }

    // The stages for the build
    stages {

        stage('Build') {

            // Define environment variables for this stage 
            environment {
                STAGE_VAR = "Sample stage-scope environment variable"
            }

            /*
                Print out the greeting to the receiver.
                Print out the global (pipeline) environment variable, to show that its scope is the entire pipeline.
                Print out the stage environment variable.
                Print out the current build's current result.
            */ 
            steps {
                echo "${params.greeting}, ${params.receiver}!"
                echo "The global-scope environment variable is: '${env.GLOBAL_VAR}'"
                echo "The environment variable for this stage is: '${env.STAGE_VAR}'"
                echo "The current build's current result is: ${currentBuild.currentResult}"
            }
        }

        stage('Test') {

            /*
                Print out the global (pipeline) environment variable, to show that its scope is the entire pipeline.
                Print out two default environment variables, one with 'echo' in groovy and one with a shell command.
                Try to print out the previous stage's environment variable to show that it is out of scope and unavailable. It should be 'null'
                Print out the current build's current result.
            */ 
            steps {
                echo "An example of a default environment variable is the build number: '${env.BUILD_NUMBER}'"
                sh 'echo "Another example of a default environment variable is the job name: \'${JOB_NAME}\'"'
                echo "The global-scope environment variable is: '${env.GLOBAL_VAR}'"
                echo "The environment variable for the previous stage is: '${env.STAGE_VAR}'"
                echo "The current build's current result is: ${currentBuild.currentResult}"
            }
        }

        stage('Deploy') {
            
            /*
                Run a shell script that is in the workspace on the worker node, using the default environment variable WORKSPACE.
                Print out the global (pipeline) environment variable, to show that its scope is the entire pipeline.
                Try to print out the previous stage's environment variable to show that it is out of scope and unavailable.
                Print out the current build's current result.
            */ 
            steps {
                sh '${WORKSPACE}/calculate-sum.sh 2 4 6'
                echo "The global-scope environment variable is: '${env.GLOBAL_VAR}'"
                echo "The environment variable for the previous stage is: '${env.STAGE_VAR}'"
                echo "The current build's current result is: ${currentBuild.currentResult}"
            }
        }
    }
}