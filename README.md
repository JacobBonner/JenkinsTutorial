# An Introduction to Jenkins


## What is Jenkins?

Jenkins is an open source framework used to manage all types of automation, from software builds and application testing, to deployments and more. It is a highly extensible automation server that can be used as a simple continuous integration server, or transformed into the continuous delivery hub for any project.

## Why Use Jenkins?
1. Open Source / Free
    - As an open source project, there is a community around Jenkins that provides large support and thorough documentation.
    - Anyone can examine the code, find and fix issues, or develop new features.
    - There are hundredes of plugins available to support building, deploying and automating any project, and it is easy to create your own.
2. Extensibility and Flexibility
    - There are hundreds of community developed plugins, allowing you to integrate with practically every tool in the CI/CD toolchain. By using plugins you can extend the features and functionality of Jenkins, providing limitless possibilities.
    - Jenkins is distributed, giving you the ability to easily distribute work across multiple machines. This allows you to drive builds, tests and deployments faster.
3. Ease of Use
    - As self-contained, java-based, and ready to run out-of-the-box for all major operating systems, Jenkins has a readily available and easy installation.
    - Jenkins can be set up and configured via its web interface, which includes on-the-fly error checks and built-in help. There is documentation and examples directly included or easily accessible from your environment.
    - Both the Jenkins UI and documentation are user-friendly, intuitive, and easy to navigate.

## What Can Jenkins Do?

Jenkins can be easily configured and extended, and comes with a multitude of plugins which allow great flexibility. Below are some of the many uses for Jenkins:

1. Maintain, orchestrate, and accelerate the entire software development lifecycle.
2. Integrate with various SCM systems.
3. Manage and control software delivery processes throughout the entire lifecyle
    - Build, Document, Test, Package, Deploy
4. Generate reports.
5. Push to various respositories.
6. Notify stakeholders of build status.
    - Slack, Email, etc

And due to the plethora of avilable plugins in the community, Jenkins can do so much more.

___


## Part 1 - Setup 

1. Install Prerequisites: [VirtualBox](https://www.virtualbox.org/wiki/Downloads) , [Vagrant](https://www.vagrantup.com/downloads) , [Git](https://git-scm.com/downloads) , and a Terminal with an SSH client ([PS Core](https://github.com/powershell/powershell), [MobaXterm](https://mobaxterm.mobatek.net/), etc).

2. On Github, hit the 'Fork' button for this repository. The reason for forking rather simply cloning is for the use of webhooks in a future section. Then from your terminal, run the command `git clone https://github.com/{YOUR_USERNAME}/JenkinsTutorial.git`, or however you wish to clone your newly forked repository.

3. From your terminal, navigate to the `vagrant` folder in the repo you just cloned, i.e. the directory `JenkinsTutorial/vagrant`.

4. Run command `vagrant box add ubuntu/bionic64`.

5. Run command `vagrant up`.

6. After the previous command is finished, you should see a string of characters as the last output. Copy that string - it is the initial admin password to sign in to jenkins.

7. On your host machine: open a web browser and enter the URL http://localhost:8080.

8. You should see a 'Getting Started' screen, prompting you to 'Unlock Jenkins'. Paste the password that you copied in step 6, and press 'Continue' at the bottom.

9. Now you should see a 'Customize Jenkins' header and two choices for installing plugins. Press 'Install suggested plugins'.

10. After all of the plugins have been installed, you should see a screen titled 'Create First Admin User'. Fill in all of the fields and then press 'Save and Continue' at the bottom.

11. On the next screen there is a header 'Instance Configuration', and a section for changing the default Jenkins URL. Leave this be right now, and press 'Save and Finish' at the bottom.

12. The final screen you should see is 'Jenkins is Ready!'. Press 'Start Using Jenkins' to login. You should now be on the Jenkins Dashboard.

___


## Part 2 - Key Terminology

Here is a list of some of the key Jenkins terminology that will be used throughout this tutorial. All of the below terminology, and more, is defined and can be found at https://www.jenkins.io/doc/book/glossary/.

1. __Job__/__Project__: A user-configured description of work which Jenkins should perform, such as building a piece of software, etc.
2. __Pipeline__: A user-defined model of a continuous delivery pipeline. 
3. __Folder__: An organizational container for Pipelines and/or Projects, similar to folders on a file system.
4. __Item__: An entity in the web UI corresponding to either a Folder, Pipeline, or Job/Project.
5. __Build__: The result of a single execution of a Job/Project.
6. __Controller__: The central, coordinating process which stores configuration, loads plugins, and renders the various user interfaces for Jenkins.
7. __Agent__: Typically a machine, or container, which connects to a Jenkins controller and executes tasks when directed by the controller.
8. __Node__: A machine which is part of the Jenkins environment and capable of executing Pipelines or Projects. Both the Controller and Agents are considered to be Nodes.
9. __Artifact__: An immutable file generated during a Build or Pipeline run which is archived onto the Jenkins Controller for later retrieval by users.
10. __Label__: User-defined text for grouping Agents, typically by similar functionality or capability. For example linux for Linux-based agents or docker for Docker-capable agents.
11. __Workspace__: A disposable directory on the file system of a Node where work can be done by a Pipeline or Project. Workspaces are typically left in place after a Build or Pipeline run completes unless specific Workspace cleanup policies have been put in place on the Jenkins Controller.

___


## Part 3 - Jenkins User Interface

1. Following a successful log in you will be brought to the Jenkins Dashboard. There will be a screen with something similar to 'Welcome to Jenkins!', followed by 'Start building your software project' and 'Set up a distributed build'. This page is normally where you would see a list of the projects/jobs and any folder or views that have been created, but because you have a new install there won't be any projects defined.

2. On the left hand side of the Dashboard there is a list of menu items:
    - __New Item__: Starts the process of creating a new Item, such as a project/job.
    - __People__: Lists all known users that are defined on the system.
    - __Build History__: A list of the builds that have completed, along with a timeline showing when those builds ran.
    - __Mange Jenkins__: Opens another menu with options for configuring Jenkins. There are many options here, so some of them are highlighted below:
        - __System Configuration__: Using the choices under this section, you can: define global settings and paths; configure various tools; add, remove, update, disable or enable plugins; add, remove, control, and monitor nodes and cloud configuration.
        - __Security__: Here you can define who is allowed to access and use the system, define values used for authenticating the services outside of Jenkins with usernames, passwords, private keys and certificates, and you can create, delete or modify users that can log into this Jenkins.  
3. Below all of these menu items is the __Build Queue__, which is a list of what builds are waiting to be run. Beneath the build queue is the __Build Executor Status__, which shows what builds are running at the present moment. 
4. Feel free to explore the user interface before moving on to the next section.

___


## Part 4 - Projects and Pipelines
In order to start using the Jenkins environment in our CI toochain, we first need to start by creating a job (project) definition. Recall that a job is a user-configured description of work which Jenkins should perform.

### 4.1 Types of Items

If you're running a default Jenkins installation, when you click 'New Item' on the left side of the Dashboard, you'll see a list of items that you can create. If you recall, an item is an entity in the web UI corresponding to either a Folder, Pipeline, or Job/Project. Below are the items that you can create:

1. __Freestyle__: Allows you to freely control the way Jenkins manages the tasks you want to automate. 

2. __Pipeline__: The most common way of thinking about the multiple stages of a continuous integration process, this is a user-defined model of a continuous delivery pipeline. It is useful for jobs that require a series of steps to produce a final outcome. For example, building an application, which may take the steps: check out code, run tests, compile the code, deploy the application.

3. __Multi-configuration__: Useful when you might have multiple jobs that do the same thing but for different combinations of parameters. Instead of duplicating steps by creating a single job for each set of parameters, you can use the multi-configuration project to create a single job that applies the parameters for you. 

4. __Folder__: Jenkins uses folders to group items together.

5. __Multibranch Pipeline__: Suited for working with code repositories. 

6. __Organization Folder__: Scans for repositories to create a set of multibranch project subfolders.


From here you will start by creating both a Freestyle Job/Project and Pipeline, to show the structure and configuration options for each. 

### 4.2 - Freestyle Jobs/Projects

#### __4.2.1 - Job Configuration__
After clicking 'New Item' from the Dashboard, enter the item name `hello-world`. Then select 'Freestyle project' and hit OK at the bottom. Whenever you create a job you will be brought to the configuration page for that job, which is what you should see now. There is a bar of several tabs at the top, outlining the various sections of configuration. Each of these sections and most of their options are described below. Feel free to skim over this, as several of the key options are described in future sections.

1. __General__
    - __Description__: Here you can add additional text outside the job name to help describe the job and what it does.
    - __Discard Old Builds__: Jenkins keeps a record of each build and the files that were generated for that build, including artifacts, log files, etc. This parameter allows you to put a limit both on the number of builds that Jenkins will keep for this job and how long (in days) Jenkins will keep a build for.
    - __Github Project__:  This option helps with associating a Jenkins job to a project being hosted on Github. By selecting this you can enter the url for the repo where the project is hosted, and enter a name to display the link on the home page for the Jenkins job.
    - __This project is parametrized__: This is a powerful option that allows you to pass various types of parameters to a job, such as strings, files, booleans, and more. This makes it easy to create a job that can be used differently based on the parameters you pass to it.  
    - __Throttle builds__: This option gives you control over how many times the job can run within a given period of time. If the job is CPU intensive or runs for a long time, this option can be useful if you want to keep a job from allocating too many resources.
    - __Disable this project__: This option is very intuitive in that it disables the job, meaning you won't be able to run it manually or trigger it from another job. 
    - __Execute concurrent builds if necessary__:  By default, Jenkins only runs one instance of a job at any given time. Selecting this option allows Jenkins to build multiple instances of this job simultaneously.
    - The 'Advanced...' button underneath the options just listed reveals even more options ...
        - __Quiet Period__: This option let's you specify an amount of time between triggering a build and when it actually starts building. Newly triggered builds of this project will be added to the build queue, but will wait the specified down time before actually starting the build.
        - __Retry Count__: When this option is activated, and this project is configured to use a SCM system, Jenkins will try the specified amount of times to check out from the SCM system until it succeeds.
        - __Block build when upstream project is building__: When this option is selected, Jenkins will prevent the job from building when a dependency of this project is in the queue, or building.
        - __Block build when downstream project is building__: When this option is selected, Jenkins will prevent the project from building when a child of this project is in the queue, or building.
        - __Use custom workspace__: Rather than using the default workspace as specified on a Node, this option lets you specify the workspace location manually for a job.
        - __Display Name__: This option allows you to specify an optionla job name shown for the project throughout the Jenkins web GUI.
2. __Source Code Management__: This section controls how Jenkins interacts with any code stored in external SCM. For example, the 'Git' option allows you to enter the repository url and any credentials needed to access the repo. You can also specify which branches to check out.
3. __Build Triggers__: This section has options for specifying how and when a job is built automatically.
    - __Trigger builds remotely__: This option allows you to trigger new builds by accessing a predefined URL with the REST API, which requires an authorization token.
    - __Build after other projects are built__: With this option you can trigger a new build for this job after some other specified project(s) are built.
    - __Build periodically__: With this option you can specify periodic times to build the job, in a CRON-like format.
    - __Github hook trigger for GITCsm polling__: Activating this option let's you automatically trigger a build when there is a change in a specified Github repository.
    - __Poll SCM__: This option allows you to specify a CRON-like schedule for which a specified SCM repository will be polled for changes. If a change is found, then the job will build.
4. __Build Environment__:  This section gives you control over the environment in which the job will run.
    - __Delete workspace before build starts__: When this option is selected, the workspace of the job will be deleted and recreated at the start of each build.
    - __Use secret text(s) or file(s)__: Allows you to take credentials of various sorts and use them throughout the job.
    - __Abort the build if it's stuck__: To keep a job from waiting on an external process or something else indefinitely, you can specify an absolute amount of time a job has to run, or even a deadline that the job has to finish by. If that time is passed or the deadline is not met, you can abort the build.
    - __Add timestamps to the Console Output__: This option simply adds timestamps to the console output throughout a build.
5. __Build__: This section let's you add various types of steps that will be executed in any build for this job, including shell scripts and other commands.
6. __Post-build Actions__: In this section you can add various steps that will execute after a build of the job is complete, such as sending email notifications, archiving artifacts, and more.

#### __4.2.2 - Adding a Build Step and Building the Job__

1. When you are done looking through the configuration options, go to the 'Build' section, hit 'Add build step', and select 'Execute Shell'. In the shell window, enter the command `echo 'Hello, World!'`.

2. Locked at the bottom of the screen, no matter where you are on the configuration page, are two buttons: 'Save' and 'Apply'. Both buttons save your current unsaved changes, but 'Apply' keeps you on the configuration page, while 'Save' takes you back to the job's home/status page. Hit the 'Save' button.

3. Once you are back on the job's status page, hit the 'Build Now' button on the left side of the screen. Soon you should see a build appear under the 'Build History' section on the left of the screen. There will be an icon, a build number, and then the date and time at which it was built.

4. Click on the build number link '#1', and it will take you to the build. Now click 'Console Output', and you should see some information printed out, including the execution and output of the build step you added, `echo 'Hello, World!'`.

5. Now go back to the Jenkins Dashboard. You should see the new Project `hello-world` listed under 'All', which is a list of all of the Projects in your environment.


### 4.3 - Pipelines

#### __4.3.1 - What is Jenkins Pipeline?__
Jenkins Pipeline (or just Pipeline) is a suite of plugins which supports the implementation and integration of continuous delivery (CD) pipelines into Jenkins. It provides an extensible set of tools for modeling simple or complex delivery pipelines as code via the Pipeline domain-specific language (DSL) syntax. 

The definition of a Jenkins Pipeline is written either directly in the Jenkins UI via an embedded script block, or into a file called a Jenkinsfile which can be committed into source control. This process of defining a CI pipeline in a file as part of an application in SCM forms the basis for "Pipeline-as-code".

__IMPORTANT__: While the syntax for defining a Pipeline is the same in the web UI and in a Jenkinsfile, it is considered best practice to define the Pipeline in a Jenkinsfile and check it in to source control. The benefits for doing so are similar to that of using source control for any other code, and more. In particular, by storing the Jenkinsfile in SCM you get tracking and edit history, which would be lost by editing the Pipeline directly in Jenkins. Also, you can trigger builds with changes to SCM, automatically building, testing, and deploying.

A Jenkinsfile can be written using two types of syntax - __Declarative__ and __Scripted__. Throughout this tutorial you will use Declarative syntax, but you can read about the differences and similarities between the two, as well as more of an introduction to Pipeline, at the following link: https://www.jenkins.io/doc/book/pipeline/.


#### __4.3.2 - Why Pipeline?__
Jenkins receives a powerful set of automation tools from Pipeline, supporting tasks spanning from simple CI to complex CD pipelines. By utilizing the various capabilities and functionalities of Pipeline, it provides several features and benefits to users:
1. __Code__: Pipelines are written as code and generally added to source control, allowing continous and trackable editing, consistent reviewing, iteration, etc.
2. __Durability__: Pipelines persist both planned and unplanned restarts of the Controller.
3. __Pausability__: Pipelines have the ability to wait for human input or approval before continuing.
4. __Versatility__: Pipelines support complex real-world CD requirements.
5. __Extensibility__: The Pipeline plugin supports custom extensions and endless integration possibilities with other plugins.


#### __4.3.3 - Pipeline Concepts and Syntax__
As stated before, Pipeline is written as code via the Pipeline domain-specific language (DSL). There are several key components to writing a Pipeline, which include:
1. __Pipeline__: This is the user-defined CD pipeline as a whole, representing the basis for your entire build process.
2. __Node or Agent__: A machine that is part of the Jenkins environment. Capable of building a Pipeline.
3. __Stage__: A stage defines a conceptually distinct subset of tasks performed through the entire Pipeline (e.g. "Build", "Test" and "Deploy" stages).
4. __Step__: A single task, telling Jenkins what to do at a particular point in time / step in the process. For example, executing a shell command.

When it comes to creating a Jenkinsfile, there is a particular syntax to follow for Declarative vs Scripted Pipelines. There are four components that are fundamental for a Declarative Pipeline: a `pipeline` block, an `agent` specified, a `stages` block, at least one `stage`, and `steps` within that stage. Below is a sample Declarative pipeline.

```
pipeline {
    agent any // specifies the agent to run on, which in this case is any agent
    stages {
        stage('Build') { // Defines the Build stage
            steps {
                // perform any steps required for the Build stage
            }
        }
        stage('Test') { // Defines the Test stage
            steps {
                // perform any steps required for the Test stage
            }
        }
        stage('Deploy') { // Defines the Deploy stage
            steps {
                // perform any steps required for the Deploy stage
            }
        }
    }
}
```
To read more on Pipeline syntax as a whole, check out this link: https://www.jenkins.io/doc/book/pipeline/syntax.


#### __4.3.4 - Pipeline Job configuration__
Now we will create a Jenkins Pipeline. From the Dashboard, create a new item, give it the name `hello-world-pipeline`, and select 'Pipeline'. Just like for the Freestyle Job, you will be brought to a configuration page, with a bar of tabs at the top representing the configuration sections. Some of the options in the sections are the same as Freestyle jobs, so only the new options are described below.

1. __General__
    - __Do not allow the pipeline to resume if the controller restarts__: This option prevents a build of this pipeline from resuming if the controller restarts.
    - __Pipeline speed/durability override__: This option allows you to change the default durability mode for running Pipelines. In most cases this is a trade-off between performance and the ability for running pipelines to resume after unplanned Jenkins outages.
    - __Preserve stashes from completed builds__: When this option is activated, the stashes from the most recent completed builds of this project are preserved. Read [here](https://www.jenkins.io/doc/pipeline/steps/workflow-basic-steps/#stash-stash-some-files-to-be-used-later-in-the-build) for more on stashes.
2. __Build Triggers__
    - This section contains no new options that are not available in Freestyle Jobs. Check the Freestyle Jobs section of this document for more info.
3. __Advanced Project Options__
    - By defult, this section only contains the 'Display Name' option, which was described in the Freestyle Jobs section of this document.
4. __Pipeline__
    - This section is where the Pipeline will be defined as code. Recall that it can either be created in the embedded code box that is shown, or you can configure the pipeline to pull code from a Jenkinsfile in a SCM repository.

#### __4.3.5 - Adding Pipeline Code and Building the Pipeline__
1. When you are done looking through the configuration options, go to the 'Pipeline' section, and copy and paste the contents of the file ___ into the 'Script' box.

2. Like Freestyle Jobs, the 'Save' and 'Apply' buttons are locked at the bottom of the screen. Hit the 'Save' button.

3. Once you are back on the job's status page, hit the 'Build Now' button on the left side of the screen. Soon you should see a build appear under the 'Build History' section on the left of the screen. There will be an icon, a build number, and then the date and time at which is was built.

4. Click on the build number link '#1', and it will take you to the build. Now click 'Console Output', and you should see some information printed out, including the execution and output of the build step you added, `echo 'Hello, World!'`.

5. Now go back to the Jenkins Dashboard. You should see the new Pipeline `hello-world-pipeline` listed along with the first project `hello-world`.

### 4.4 - Parameters, Environment Variables, and a Job's Workspace

#### __4.4.1 - Parametrizing a Job__
1. From the Dashboard, click on the freestyle job `hello-world`, and then hit 'Configure'. In the 'General' section of the configuration page, check the box 'This project is parametrized'. When you click 'Add Parameter' you will see a dropdown menu of the type of parameters you can add:
    - __Boolean__: A true or false value.
    - __Choice__: A list of various values that you can select from.
    - __Credentials__: A credential as defined in Jenkins.
    - __File__: A file submission from a browser.
    - __Multi-line String__: A piece of text that spans one or many lines.
    - __Password__: Simply a password. The password entered here is made available to the build in plain text as an environment variable like a string parameter would be.
    - __Run__: A single run of a certain project.
    - __String__: A piece of single-line text.
2. Hit 'Add Parameter' and select the 'Choice' option from the drop down. Then for the options of this parameter enter the following for each ...
    - Name: `greeting`
    - Choices: 
        ```
        Hello
        Good morning
        Good afternoon
        Good evening
        ```
    - Description: `A greeting to give.`
    - _Note_: The default value for this type of parameter is the first option.
3. Hit 'Add Parameter' and select the 'String' option from the drop down. Then for the options of this parameter enter the following for each ...
    - Name: `receiver`
    - Default Value: `World`
    - Description: `Who the greeting parameter is directed to, i.e. who will be receiving the greeting.`
4. Now go down to the 'Build' section, and in the 'Execute Shell' step, replace `echo 'Hello, World!'` with `echo "${greeting}, ${receiver}!"`, and then hit 'Save'.
5. Now back on the job's status page, because the purpose of the job has changed, hit the 'Rename' button at the bottom of the left hand side menu. Enter the new name `give-greeting` and hit 'Rename'. You should see the new name appear in the Project's home page.
6. Now click 'Build with Parameters'. Select the greeting you want to give and who the greeting should be directed towards. Then hit 'Build'.
7. Under the 'Build History', click on '#2', then 'Console Output'. You should now see the invocation and result of the command `echo "${greeting}, ${receiver}!"` with the parameters that you passed.

#### __4.4.2 - Environment Variables__

In Jenkins, you can define your own environment variables both globally across Jenkins and on a per job basis. There is also a set of environment variables that are set automatically in each environment, which can be found at `${YOUR_JENKINS_HOST}/env-vars.html` on your Jenkins master server. Since your instance of Jenkins is running on a local VM and was configured for port 8080, this will be http://localhost:8080/env-vars.html/.

#### __4.4.3 - A Job's Workspace__
Recall that a workspace is a disposable directory on the file system of a Node where work can be done by a Pipeline or Job. Every Job and Pipeline you have defined is given a dedicated workspace, where the job stores any files that are generated during a build or pulled from source control. Throughout the build of a job or pipeline, you can access the workspace, whether it be to run scripts that are stored in the workspace or to create new files.

To access the workspace for a Job, you can either press the 'Workspace' option in the menu on the left side of a job's home page, or from the 'Status' page there is a 'Workspace' option under the project name. If you go the freestyle project `give-greeting`, you will see the 'Workspace', but it will be empty because we have not added any files to it.

Since each build of a job uses the same workspace, it can be useful to clean up between runs. At the very top level of the workspace, you'll see a link in the left menu that reads 'Wipe Out Current Workspace'. Clicking this link, and selecting OK to confirm, will remove all files from the workspace. As shown in the configuration section for the jobs and pipelines, you can automatically clean up the workspace before each build, and also clean up the workspace once a build completes.


### 4.6 Bringing It All Together

#### __4.6.1 - Recap__
Let's recap Projects and Pipelines, and their various components:
1. Freestyle Projects
    - Many configuration options, such as parametrization
2. Pipelines
    - CI pipelines written as code
    - Durable, extensible, versatile, etc
    - Fundamental components are a `pipeline` block, an `agent`, a `stages` block, at least one `stage`, and `steps` within that stage.
3. Parameters
    - Both Freestyle Project and Pipelines support parameters
    - There are many available types, and more can be added via plug ins.
4. Environment Variables
    - Default Jenkins environment variables
    - You can create your own
5. Workspaces
    - Each job has a workspace on the node that it builds on
    - Can run scripts and access files stored in the workspace 

#### __4.6.2 - Creating a More Advanced Pipeline__
Now we will create a Pipeline that brings together all of the components from the previous sections.
1. From the Dashboard, hit 'New Item', name it `bring-it-together`, and make it a 'Pipeline'.
2. Now go down to the 'Pipeline' section of the configuration page. Copy and paste the pipeline from the file ___ into the script block on the configuration page.
3. Below is a description of each part of this pipeline:
    - `parameters` block
        - This is where you can define and configure parameters for the pipeline. The two parameters here are the same two parameters from the Freestyle Job `give-greeting`.
    - `environment` block 
        - Where you can define environment variables. This section can be added before the `stages` or within a `stage`. Depending on where it is placed, the variables defined in it either exist in the global pipeline scope, or the scope specific to the stage they are defined in.
    - 'Build' `stage`
        - There is an `environment` block defining an environment variable that exists only in the scope of this stage.
        - In the `steps` of this stage: the `greeting` is printed to the `receiver`, the global-scope env variable is printed, and the env variable defined in this stage is printed.
    - 'Test' `stage`
        - In the `steps` of this stage: the `BUILD_NUMBER` and `JOB_NAME` default environment variables are printed, the global-scope env variable is printed, and the env variable defined in the 'Build' stage is printed but will be 'null' because it is out of scope.
    - 'Deploy' `stage`
        - In the `steps` of this stage: a script stored in the workspace is executed using the `WORKSPACE` default environment variable, the global-scope env variable is printed, and the env variable defined in the 'Build' stage is printed but will be 'null' because it is out of scope.

4. Now hit 'Save'. Then press 'Build Now' on the Pipeline's home page. You probably noticed that even though there are parameters defined in the Pipeline, you were not prompted to enter any parameters just now. That is because jenkins needs to read the Pipeline code on the first build to get the configuration defined in it, and then it will be added to the configuration in the jenkins UI.

5. In the 'Build History' section, you should see a red 'X' next to build '#1', indicating that it failed. This is because the script that is executed in the 'Deploy' `stage` does not exist in the workspace yet. In order to fix this we need to add the script to the workspace of this Pipeline on the jenkins server.
    - From the directory `JenkinsTutorial/vagrant`, run the command `vagrant ssh jenkins_server`.
    - Now on the Jenkins server, run the command `sudo cp /vagrant/calculate-sum.sh /var/lib/jenkins/workspace/bring-it-together`, to copy the script to the Pipeline's workspace.
    - Change the file permissions with the command `sudo chmod 777 /var/lib/jenkins/workspace/bring-it-together/calculate-sum.sh`, so that we can execute the script.

6. Now go back to the Jenkins UI and refresh the page. Now you should see 'Build with Parameters' instead of 'Build Now', because Jenkins has read the configuration written in the Pipieline code. Go ahead and hit that button to build, and enter values for the parameters before hitting 'Build' at the bottom of the page. 

7. Now there should be a second build under the 'Build History'. If you click on '#2' and go to the 'Console Log', the script we added to the workspace should now have executed, and the output for each stage will match what was described in step 3 of this section.

With a foundation in Project and Pipelines, in the next part of this tutorial we will go into more detail on Builds.
___


## Part 5 - Builds 

### 5.1 - Tracking/Monitoring Build State

Within Jenkins, many projects don't happen instantaneously, and it is often useful to have the ability to go into the system and monitor the current status of a build environment. As an example, we are going to create a simple pipeline prject that runs for a few minutes so we can go in and monitor the build.

1. From the Jenkins Dashboard, hit 'New Item', give it the name `monitoring-build-state`, and select Pipeline.

2. Copy the contents of the file `pipelines\Pipeline_Part5_monitoring-and-artifacts.Jenkinsfile` and paste it into the box under 'Pipeline script'. Check the box 'This project is parametrized' in the 'General' section, select 'String' parameter, and enter the default value, name and description according to how the parameter is defined in the Pipeline code. Then hit 'Save' at the bottom of the screen.

3. Now click 'Build with Parameters' on the left side of your screen. Enter the value 5 for 'secondsToSleep', and hit 'Build'.

4. Right away, under 'Build History', you should see the following:
    - A circle with three blue dots in the center, and a bar moving clockwise around the perimeter of the circle. The three dots indicates that the pipeline has not been built before, and the bar in the perimeter of the circle moving means that the build is in progress.
    - A number, which is the build number / build ID. It's a unique identifier that Jenkins uses to organize the builds associated with a a Project or Pipeline.
    - A striped line/pipe, which is a visual indicator on how long the build has been running, and how much longer before completion. Once Jenkins has built a Project or Pipeline several times, this bar gives a better indication on how much longer the job might run. 

5. After the build is finished, the blue circle with three dots will to a circle with a green check mark, letting you know the job finished successfully. Also the progress bar goes away, and is replaced by the time the build started.

6. Click 'Build with Parameters' again, and enter 10 for 'secondsToSleep'. There will be a build schedule notification like before, but this time you should see a circle with the green check mark again, rather than the three blue dots. The green check mark means the previous build finished successfully, and the bar moving around the perimeter of the circle means the job is currently in progress. Instead of a striped bar, there is an empty bar that looks to be filling up as the job runs. This is a visual indicator on how long the build has been running and approximately how much is remaining.

7. If the build finishes then trigger a new build, otherwise continue. On the Pipeline's status page you should see the 'Stage View'. This gives you the ability to see what stage the build is currently in, and you can also view the logs by hovering over the stage in progress and pressing 'Logs' when it comes up.

8. Another way you can monitor the build is by looking at the build history either from within the 'Stage View' or under 'Build History' by clicking on the build number. That brings us to the 'Status' page of the build, and you can see the bar on the top right shows that it is still in progress. From here you can click on several of the options in the menu on the left side of the screen:
    - Going to 'Pipeline Steps' will show you where the build is at in the pipeline. 
    - Clicking on 'Console Output' will show you real time output of the pipeline's execution.

These are all just some of the ways of monitoring the status of a build, and seeing the log output from the different steps within the deployment process.


### 5.2 - Polling SCM for Build Triggering
An important part of any continuous integration or continuous deployment process is communicating with a Source Code Management system, like Github. In order to do so, we need a repository that already has a Jenkinsfile, which is where the pipeline is defined. The repository we will use is the fork that you made of this Github repository for this project: https://github.com/{YOUR_USERNAME}/JenkinsTutorial.

1. From the Jenkins Dashboard, click 'New Item'. Give it the name `poll-scm` and select the type 'Pipeline'.

2. Rather than using the 'Pipeline script' definition directly in Jenkins, press the 'Definition' dropdown menu and select 'Pipeline script from SCM'. For the new options that appear enter the following:
    - __SCM__: Select 'Git' from the dropdown.
        - __Repository URL__: https://github.com/{YOUR_USERNAME}/JenkinsTutorial.git
        - __Credentials__: You shouldn't need to enter any credentials because the repo is public/open. 
        - __Branches to build__: Change to '*/main'.
    - __Script Path__: `pipelines\Pipeline_Part4_hello-world.Jenkinsfile`
    - Uncheck the box 'Lightweight checkout'.

3. Now scroll back up to the 'Build Triggers' configuration section, and check the box 'Poll SCM'. The schedule is based on the syntax of cron. For this you should enter `* * * * *`, which will poll every minute on the minute.

4. Hit 'Save' to return to the Pipeline's home page. Along with the standard set of options that appear in the menu on the left of the screen, there is a new option 'Polling Log' or 'Git Polling Log', which describes when the specified repository was last polled and the status of that poll.

5. Now we have to wait for the minute to tick over so that the polling occurs. Soon you should see a new build in 'Build History' that was triggered by the polling, and the 'Git Polling Log' should contain some new information.

6. From the Pipeline's 'Status' page, you can see that the system has done a checkout of the specified Github repository, so it was able to poll SCM and get the necessary information. Additionally, the pipeline defined in the Jenkins file you specified in configuration should have successfully completed.

7. The way this 'Poll SCM' feature works is by polling the specified repository, and if it finds changes then it will build, otherwise it will do nothing. In particular, go back to the 'Git Polling Log'. You may need to wait for the minute to tick over again before seeing another poll in the log. You should see:
    - For the initial poll, there was no previous build or repository state to compare to, so changes were detected. That is why the new build was triggered.
    - For the second poll, Jenkins examined the repository again, but found that there were no changes since the previous poll. Thus, no build was triggered.

8. In reality you wouldn't want to actually poll every minute, but you can specify a reasonable time that works well with when you make changes to your repository and also when other builds are happening in the rest of your Jenkins environment.


### 5.3 - Build Artifacts
Recall that an artifact is an immutable file generated during a build which is archived onto the Jenkins Controller. Most Projects and Pipelines in Jenkins will generate some sort of artifacts in the form of a report, product, or set of files. You can access the artifacts for a particular Project or Pipeline two ways:

1. From a project's 'Status' page, there is an icon of an open cardboard box with the text 'Last Successful Artifacts'. The artifacts are listed underneath this, or you can click on the link 'Last Successful Artifacts' and access them from there. These artifacts are from the last successful build of the project, so that if the last few builds have failed you can still access the most recent artifacts easily.
2. If you click on a particular build of a the project, and it successfully generated artifacts, then there will be the same icon on the build's 'Status' page next to the words 'Build Artifacts'. Again, the artifacts are listed underneath this, or you can click on the link 'Build Artifacts' to access them.

To take a look at some artifacts, go to the Pipeline `monitoring-build-state`. You probably already noticed, but the last stage of the pipeline has a command `archiveArtifacts` that archives the specified artifacts. There should be artifacts available in both of the ways listed before, so find them either under 'Last Successful Artifacts' or click on an individual build to access the artifacts from it.


### 5.4 - Triggering Builds with Github Webhooks

For the most part, the goal is to integrate and use Jenkins with a SCM system, so that changes in an environment, like GitHub, are automatically pushed back into the Jenkins environment. We can do this through Webhooks.

NOTE: For this section you will need to sign up for [ngrok](https://ngrok.com/). There is a free and paid version, but for the purposes of this tutorial you will only need the FREE version. If you don't wish to signup for and configure ngrok on your Jenkins server, then skip this section and continue to Part 6.


#### __5.4.1 - Create a Personal Access Token in Github__
Before we can communicate with GitHub from Jenkins, we need generate a GitHub Personal Access Token that will be used by Jenkins.

1. To create a Personal Access Token in your Github environment, go to [this link](https://github.com/settings/tokens/new). Also, the steps to get to that link are:
    - Go to [Github](https://github.com)
    - Click on your user icon and select '[Settings](https://github.com/settings)' from the dropdown menu. 
    - Then scroll down and click on '[Developer Settings](https://github.com/settings/apps)' in the side bar. 
    - Click on the option '[Personal access tokens](https://github.com/settings/tokens)' and then '[Generate new token](https://github.com/settings/tokens/new)'. 
2. For creating the token:
    - Give it the Note/Name `jenkins-integration`. 
    - Check the box `repo` to give access to all of the repo data.
    - Check the box `admin:repo_hook` which will allow you to talk to the system.
    - Optionally, check the box `notifications` to make it possible to receive access notifications.
    - Then hit 'Generate Token' at the bottom of the page.
3. Be sure to copy the token, as you won't be able to see it again.

#### __5.4.2 - Create Necessary Credentials in Jenkins__
In order to connect to Github from Jenkins and trigger builds with webhooks, we need to create two credentials in Jenkins.
1. From the Jenkins Dashboard hit 'Manage Jenkins', then under the Security section hit 'Manage Credentials'. Under the section 'Stores scoped to Jenkins', there is one option with a Store and Domains. Click on the link `(global)` under Domains. Now on the the left side of the screen there is an option 'Add Credentials'.
2. The first Credential that we are going to add is your GitHub Personal Access Token so that we can establish a connection to GitHub. Click 'Add Credentials', and enter the following for each field:
    - __Kind__: Select 'Secret text' from the dropdown menu.
    - __Secret__: Enter your Github Personal Access Token.
    - __ID__: `github-personal-access-token`
    - __Description__: `github-personal-access-token`
    - Then hit 'OK'.
3. The second Credential that we are going to add is your GitHub username in combination with your Personal Access Token (NOT your password). Click 'Add Credentials', and enter the following for each field:
    - __Kind__: Select 'Username with password' from the dropdown menu.
    - __Username__: Enter your Github username.
    - __Password__: Enter your Github Personal Access Token.
    - __ID__: `github-credentials`
    - __Description__: `github-credentials`
    - Then hit 'OK'.

#### __5.4.3 - Configure GitHub Server in Jenkins__
In order to use the Jenkins and Github integration for webhooks, we have to create a Github connection within Jenkins. 

1. From the Jenkins Dashboard, click on the 'Manage Jenkins' option, 'Configure System', and then scroll down the 'Github' section. 
2. Press 'Add Github Server' to create a basic Github server definition
3. Give it the name 'Github'. 
4. For Credentials, click on the dropdown menu and select the Credentials `github-personal-access-token`.
5. Hit 'Test Connection', and you should see a verification message. Now your Github server connection is configured.
6. Hit 'Save' at the bottom of the page.


#### __5.4.4 - Setup and Configure ngrok__
It is not possible to add a webhook for Jenkins running on `localhost` as it doesn’t have a public URL exposed over the internet. To resolve this issue we are going to use ngrok, because it will expose the local server to the public internet.

1. If you don't already have an account for ngrok, then sign up [here](https://dashboard.ngrok.com/signup).

2. After logging in, you should be brought to the [Setup & Installation](https://dashboard.ngrok.com/get-started/setup) page. The first step is to install ngrok, which has already been done in the script __ while provisioning your Jenkins server.

3. Next you need to connect your ngrok account to your Jenkins server.
    - From the directory `JenkinsTutorial\vagrant`, run the command `vagrant ssh jenkins_server`.
    - Copy and paste the command shown for you under step 2 on the ngrok steup page. It should be `ngrok authtoken {YOUR_TOKEN}`.

4. Now you need to setup the tunnel.
    - Run the command `ngrok http 8080`. You should then see text similar to the following:
        ```
        ngrok by @inconshreveable                                            (Ctrl+C to quit)  
                                                
        Session Status                online
        Account                       {YOUR ACCOUNT NAME} (Plan: Free)
        Version                       2.3.40
        Region                        United States (us)
        Web Interface                 http://127.0.0.1:4040
        Forwarding                    http://82df-8-44-144-253.ngrok.io -> http://localhost:8080
        Forwarding                    https://82df-8-44-144-253.ngrok.io -> http://localhost:8080

        Connections                   ttl     opn     rt1     rt5     p50     p90
                                    1       0       0.00    0.00    5.85    5.85 
        ```
    - DO NOT press 'Ctrl + C', because we want to keep this fired up.
    - Note that any time you run this command with the free plan, the forwarding URL will change. Hence, you will need to update your Webhooks whenever you do this.
    
5. Copy the https 'Forwarding' URL, which in the example above is `https://82df-8-44-144-253.ngrok.io`

#### __5.4.5 - Create a Webhook in GitHub__

Recall the fact that you forked this repository rather than just simply cloning it. The reason for doing so was for this section here. In order to create a Webhook for a repository and successfuly use your access token and username, the repo must be associated with your own Github profile.

1. To create a Webhook for your repository that you forked from this tutorial, go to `https://github.com/{YOUR_USERNAME}/JenkinsTutorial/settings/hooks/new`. The steps to get here are:
    - Go to `https://github.com/{YOUR_USERNAME}/JenkinsTutorial/`
    - Click on 'Settings' in the bar of options underneath the name of the repo.
    - Click 'Webhooks' in the side bar that shows up.
    - Then hit 'Add webhook'.

2. To create the Webhook, follow the next stetps:
    - __Payload URL__: This will be the 'Forwarding' URL that you copied after running `ngrok http 8080`, with `/github-webhook/` appended onto it. It will have the form `https://{YOUR_URL_ID}.ngrok.io/github-webhook/`.
    - __Content Type__: Select 'application/json'
    - __Which events would you like to trigger this webhook?__: Select the option 'Send me everything'.

3. Then hit 'Add Webhook' at the bottom of the screen. If you go back to your terminal, you should see some new text indicating that you have received a POST from your new github webhook.
    ```
    HTTP Requests
    -------------

    POST /github-webhook/          200 OK 
    ```




#### __5.4.5 - Create a Pipeline in Jenkins and Trigger with Webhook__


1. From the Jenkins Dashboard, hit 'New Item', give it the name `github-webhook` and select 'Multibranch Pipeline'. You will notice that the configuration page is much more complex and has many more sections than Freestyle Projects or Pipelines. Feel free to look around at the configuration options in more detail.

4. Under the section 'Branch Sources', click 'Add Source', then select 'Github'. Then fill in the following components as specified:
    - __Credentials__: Press the button 'Add' and click the dropdown 'Jenkins'. In the popup window:
        - Change 'Kind' to 'Username with password'.
        - For 'Description' enter 'Github username and access token'.
        - For 'Username' enter your Github username.
        - For 'Password' enter the Github access token `jenkins-integration` that you created in the previous section.
        - Then hit 'Add'.
    - Now select the 'Credentials' dropdown menu and select the new credential you just created.
    - Make sure the circle is filled in next to 'Repository HTTPS URL' and enter the URL `https://github.com/{YOUR_USERNAME}/JenkinsTutorial`

5. Scroll down to the 'Build Configuration' section. Make sure 'Mode' is `by Jenkinsfile`, and under 'Script path' enter `pipelines/Pipeline_Part4_hello-world.Jenkinsfile`.

6. Hit 'Save' at the bottom. You should be redirected to 'Scan Repository Log', under which there will be a log of the Pipeline scanning the Github repository you specified. It should find the branch `main` and the Jenkinsfile `pipelines/Pipeline_Part4_hello-world.Jenkinsfile`.

7. Now click on the 'Status' option in the left menu, where you will see a list of jobs/projects for each of the branches that were found in the repository scan. Click on 'main', and then under 'Build History' click on '#1' and then 'Console Output'. In the log you will see a stage `Declarative: Checkout SCM` which went to Github and checked out the repository and found the Jenkinsfile you specified in the configuration. Then it proceeds by building the Pipeline specified in the Jenkinsfile, which in this case will just be the printing of 'Hello World!'.

Now that we have the Pipeline `github-webhook` configured to scan the repository, we want to commit a change to the repository so that Jenkins will find it and trigger a new build. 
1. In your repository `https://github.com/{YOUR_USERNAME}/JenkinsTutorial`, make a change to a file that will not break any functionality (adding or removing whitespace), and then commit the change to the branch `main`.
2. Go back to the 'Status' page of the Pipeline 'Branch main' of `github-webhook`. You should se


___

## Part 6 - Agents and Distributing Builds

### 6.1 - Adding an SSH Build Agent

#### __Retrieve Private SSH Key from Worker__

1. From your terminal in the directory `JenkinsTutorial/vagrant`, run the command `vagrant ssh jenkins_worker`. Now you should be on the jenkins worker node.

2. Run the command `cat ~/.ssh/jenkinsAgent_rsa` to show the private key that was generated when the jenkins worker was provisioned. Copy the entire output.

3. Now run `exit` to return to your host.

#### __Add a Node in Jenkins__

1. From the Jenkins Dashboard, click 'Manage Jenkins' on the left part of the screen, then under the 'System Configuration' section click 'Manage Nodes and Clouds'.
2. On the left side of the screen, click 'New Node'. Give the node the name 'worker', and check the box (circle) 'Permanent Agent'. Then press 'OK'.
3. Now you should see a list of various fields that can be configured for the new node. If you want to read more about what each field is, click the blue question mark next to the field name on the right side of the screen. 
4. The 'Number of Executors' is the maximum number of concurrent builds that Jenkins may perform on this node. Leave this field as 1.
5. The 'Remote root directory' is a directory on the agent that is dedicated to Jenkins. In this field, enter the value '/home/vagrant'.
6. Change the 'Launch method' to 'Launch agents via SSH'. Under this field we have ...
    - __Host__, which needs to be the private ip address of the jenkins_worker virtual machine. If you changed the values of the ip addresses on lines 8 and 9 of `/vagrant/Vagrantfile`, enter the value for `IP_ADDRESS_WORKER`, otherwise enter '192.168.33.11'.
    - __Credentials__, which we need to add a new credential for. Press the button 'Add' and click the dropdown 'Jenkins'. In the popup window:
        - Change 'Kind' to 'SSH Username with private key'.
        - For 'Description' enter 'vagrant ssh key for jenkins worker'.
        - For username, enter 'vagrant'.
        - Under 'Private Key', select 'enter directly', then select 'Add'. In the box, paste the private key that you copied in step 2 of the previous section 'Retrieve Private SSH Key from Worker'.
        - Then hit 'Add'.
    - Now select the 'Credentials' dropdown menu and select the new credential you just created.
    - __Host Key Verification Strategy__, which in this case we can set to 'Non verifying Verification Strategy'.
    - Finally, hit 'Save'. The agent should be launching and successfully connecting soon.
7. Now you should see a list of the Nodes for the system, which includes 'master' and 'worker' (the one we just created). Under the 'Name' column in the table, click on the link 'worker'.
8. On the left side of the screen there is a list of various options. Click on the 'Log' button, which will show us the log and launch status of the agent. The bottom should say (or soon say) 'Agent successfully connected and online'.
9. We now have a jenkins worker agent that we can build projects on and distribute work to.


### 6.2 - Using Docker Images for Agents

#### __6.2.1 - Configure Jenkins for Docker__
1. The first step in using Docker images for agents is to configure the target system's Docker for web/REST access. In this case the target system is the vm jenkins_worker, which was configured in this way automatically on lines 27-31 in the script `vagrant/provision/worker.sh`.
2. Next we need to add the 'Docker' and 'Docker Pipeline' plugins to Jenkins. From the Jenkins Dashboard, click 'Manage Jenkins' on the left part of the screen, then under the 'System Configuration' section click 'Manage Plugins'. On the next screen there should be four buttons under a search bar: 'Updates', 'Available', 'Installed', 'Advanced'. To find and install the Docker plugin:
    - Click on the 'Available' section and enter 'docker' in the search bar.
    - Select the box next to the plugin 'Docker' and also the box 'Docker Pipeline'.
    - At the bottom of the page, press 'Install without Restart'.
    - On the next page, wait until all parts have successfully installed, and then return to the Jenkins Dashboard.
3. Now we need to configure the Docker plugin. 
    - From the Dashboard go to 'Manage Jenkins', then 'Configure System'. 
    - Scroll down to the 'Cloud' section and hit the link to take you to the cloud configuration page.
    - Click 'Add a new cloud' and select 'Docker'.
    - Press 'Docker Cloud details...'
    - For 'Docker Host URI', we need to tell it what machine to talk to. For this we need `tcp://`, followed by the ip address of our jenkins worker node. Again, if you changed the values of the ip addresses on lines 8 and 9 of `/vagrant/Vagrantfile`, then use the value for `IP_ADDRESS_WORKER`, otherwise use '192.168.33.11'. Ultimately, the final value we need to enter for the uri is `tcp://192.168.33.11:4243`, where the port is the one that was configured on lines 27-31 of the script `vagrant/provision/worker.sh`
    - Now hit 'Test Connection', which should give a version back.
    - Check the box 'Enabled', and then hit 'Save' at the bottom of the screen.

#### __6.2.2 - Create Pipeline with Docker Agent__

Now that we have an environment capabale of launching a Docker resource, we can create a new Pipeline that will use Docker as an agent.
1. From the Dashboard, create a new item, call it `using-docker-agent`, and make it a Pipeline. 
2. On the pipeline's configuration page, go down to the 'Pipeline' section, and copy and paste the contents of ___ into the script block. This Pipeline simply launches in a python Docker container and runs a simple shell script to show the version of python.
3. Hit 'Save' and then hit 'Build Now'.
4. Once the build show's up under the 'Build History', click on it and go to the 'Console Output'. You should see the container being launched and then the shell command output that prints the python version.

### 6.3 - Further Node Configuration
As your Jenkins environment grows and the number of potential agents increases, you may want to start targeting builds to toward specific nodes. For example, perhaps you have a machine that can only run docker instances, or a machine that can only run certain applications that require specific resources, like GPU or CPU. It is important to have the ability to select where these processes run, which can be done through labels. Recall that a label is a user-defined text for grouping Agents, typically by similar functionality or capability.

1. To give a Node a label, from the Jenkins Dashboard click 'Manage Jenkins', then under the 'System Configuration' section click 'Manage Nodes and Clouds'.
2. In this case we will give a label to the node 'worker', so click on that node. Then hit 'Configure' in the menu.
3. Scroll down to 'Labels' and enter the label `docker`, to signify that this node can run Docker. Then hit 'Save'.
4. Now that we have the worker node labeled, we need to specify a label in the `agent` block of a Pipeline. From the Dashboard hit 'New Item'. Give it the name `using-agent-labels` and select 'Pipeline'.
5. On the configuration page, go down to the 'Pipeline' section and copy the contents of the file ___ into the 'Pipeline script'. If you look at the `agent` block of the code you can see we are specifying the label `docker`. Then hit 'Save'.
6. On the Pipeline's 'Status' page hit 'Build Now', and then when the build appears under 'Build History' click on it and go to 'Console Output'. You should see a line 'Running on `worker` ...' because of the label we applied, and then a simple stage that gets the version of Docker installed on the Node.

Given that we only have the Controller and one additional Node (worker), the use of labels is not very noticeable. However, if we had many more nodes, then using labels would be a useful way to connect a specific Project or Pipeline with a specific set of target machines that can run the agent that supports our environment.


___

## Part 7 - Testing and 'Post' Behavior
1. Code coverage and test reports.
2. Using test results to fail a job.


___

## Part 8 - REST API
While most interactions with Jenkins are done through the UI or through SCM, there are times when we may want to interact with Jenkins outside of a plugin enabled resource. An example of this is using the Jenkins REST API, through which you can retreive information on jobs, pipelines, builds, the build queue, and more, as well as trigger builds remotely. Below are steps you must take before you can trigger builds or retrieve information from your Jenkins server with the REST API:

1. Before we can send requests via the Jenkins API, we need to aqcuire a token from the Jenkins UI.
    - From the Dashboard, click on your name in the top right corner, and then click on 'Configure'. 
    - Under the section 'API Token', press 'Add new Token', give it a name, and then hit 'Generate'.
    - Make sure to copy this token because it can't be recovered in the future! You can also revoke the token and create a new one if you need to.
    - Lastly, hit 'Save' at the bottom of the page.

### 8.1 - What can you do with the REST API?
There is plenty that you can do in Jenkins using the REST API, including:

1. Create, Copy, and Delete Projects and Pipelines
2. Retrieve all builds of a specified Project or Pipeline
3. Retrieve the Build Queue
4. Fetch or Update a Project or Pipeline description
5. Perform/Trigger a build of a Project or Pipeline

To find more details on the API for various pages in Jenkins, there is a link in the bottom right corner labeled 'REST API'. Alternatively, you can just append `/api` onto the url of the Dashboard, a Project or Pipeline, a Build, etc. 


### 8.2 - URL Tips for Fetching Data
In general, when retrieving information using the REST API, the URL format is `{YOUR_JENKINS_URL}/{RESOURCE_TYPE}/{RESOURCE_NAME}/api`, and if you want the data to be json it would be `{YOUR_JENKINS_URL}/{RESOURCE_TYPE}/{RESOURCE_NAME}/api/json`

#### __Appending Arguments onto URLs__
When you decide to add arguments onto the url for your request, you can do so by adding `?` at the end, and then add `&` between each argument that you use. Here are some examples of the arguments you can add:
1. `pretty=true`
    - Returns the data in a readable, nicely formatted manner
2. `tree=property1,property2,property3,...`
    - Allows you to specify what properties/fields to return from the data, separated by commas.
3. `depth=X`, where X can be 1,2,3,...
    - How many layers of data/properties to retrieve.

As an example, if you wanted to retrieve json that is formatted for readability, and returns `property1` and `property2` from the data, the URL would be

`
{YOUR_JENKINS_URL}/{RESOURCE_TYPE}/{RESOURCE_NAME}/api/json?pretty=true&tree=property1,property2
`

### 8.3 - Triggering a build via the REST API
Now we are going to trigger a build of the freestyle Project/Job `hello-world`.
1. From your command line, run the command

    `
    curl -u {USER_NAME}:{API_TOKEN} {JENKINS_URL}/job/hello-world/build --data-urlencode json=''
    `

2. Now from the Jenkins Dashboard go to the freestyle Project `hello-world`. If not already, you should soon see a new build in progress or finished.

### 8.4 - Retrieving Various Information via the REST API
As mentioned before, you can retrieve various information from Jenkins using the REST API. Below is a list of some of the data you can request, along with the generalized URL you would use.
1. Job Information

    `
    curl -u {USER_NAME}:{API_TOKEN} {YOUR_JENKINS_URL}/job/{JOB_NAME}/api/json?pretty=true
    `
2. Information of a Specified Build of a Job

    `
    curl -u {USER_NAME}:{API_TOKEN} {YOUR_JENKINS_URL}/job/{JOB_NAME}/{BUILD_NUMBER}/api/json?pretty=true
    `
3. The Build Queue

    `
    curl -u {USER_NAME}:{API_TOKEN} {YOUR_JENKINS_URL}/queue/api/json?pretty=true
    `

3. Information on the Nodes (Controller and other Nodes)

    `
    curl -u {USER_NAME}:{API_TOKEN} {YOUR_JENKINS_URL}/computer/api/json?pretty=true
    `

For example, run the command `curl -u {USER_NAME}:{API_TOKEN} {YOUR_JENKINS_URL}/computer/api/json?pretty=true`

## Part 9 - Further Topics and Next Steps

This tutorial walked through the basic functionalities of Jenkins, but only scratched the surface of what you can accomplish by using this tool. Below are some further topics to consider exploring:

1. Using Folders and Views to organize jobs
    - Can filter the most important projects, or group projects together by what they accomplish or do

2. Triggering Downstream Builds
    - Trigger the build of one job when another job completes

3. Security
    - Adding users and defining permissions
    - Adding credentials and using them in Pipelines
    - Using Folders to restrict access and create security realms

4. Pipelines
    - Adding post-stage and post-pipeline behavior with `post` blocks. ()
    - Creating pipeline gates, which is asking for user input
    - Job promotion for long-running pipelines
    - Multibranch repository automation
    - Using the 'Pipeline Syntax' tab in a Pipeline home page
    - Using global variables available in Pipelines (https://opensource.triology.de/jenkins/pipeline-syntax/globals)

5. Automating software and tool installation on agents
    - Running commands and installing in Pipelines
    - Use Dockerfile for specifying containers, and creating docker images

8. Global Libraries for pipelines

9. Finding and using more Plugins
    - Jenkins has hundreds of community developed plugins that can extend its features and functionality, providing limitless possibilities. By adding plugins, you aqcuire many more configuration options for jobs, from new parameters, to build steps, and more. Below are some ways that plugins can be used:
        - Integrating with Slack and Email to send notifications, updates, status, etc.
        - Scaling Builds with Other Cloud Services
        - And many more!

Additionally, next steps to consider are exploring the official [Jenkins](https://www.jenkins.io) website, and potentially contributing to the code and the community in some way.

___

## Sources
All of this information can be found among the resources and pages at https://www.jenkins.io.