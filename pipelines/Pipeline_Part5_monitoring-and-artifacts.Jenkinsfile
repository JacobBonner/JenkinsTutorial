pipeline {

    // Specify an agent to build on
    agent any

    // Parameters
    parameters {

        // The number of seconds to sleep in between each file creation
        string (
            name: 'secondsToSleep', 
            defaultValue: '10', 
            description: 'How long to sleep in between creating files (in seconds).'
        )
    }

    // Pipeline-scope environment variables
    environment {
        DIRECTORY = "build${env.BUILD_NUMBER}"
        ARTIFACTS = "artifacts_${DIRECTORY}.zip"
    }

    stages {

        // Create files and sleep for a bit, then zip them together
        stage('CreateFiles') {

            // Run shell script
            steps {
                sh  '''
                    mkdir ${DIRECTORY}

                    for i in 1 2 3 4 5 6 7 8 9 10
                    do
                        file="${DIRECTORY}/file${i}.txt"
                        echo "Sleeping for ${secondsToSleep} seconds and creating file '${file}' ..."
                        sleep ${secondsToSleep}
                        touch $file
                    done

                    zip -r ${ARTIFACTS} ${DIRECTORY}
                    '''
            }
        }

        // Archive artifacts
        stage('Archive') {

            // Archive all of the .txt files that were created in the previous stage
            steps {
                archiveArtifacts artifacts: "${env.ARTIFACTS}", onlyIfSuccessful: true
            }
        }
    }
}