pipeline {
    agent any   
    environment {
                    registry = "tulikasah689/webimage"
                    registryCredential = 'dockerhub'
                    dockerImage = ''
                 }
    tools
    {
        maven  'Maven3'
        jdk 'JDK_NEW'
    }
    stages {
        stage('Fetch')
        {
            steps
            {
                git url : "https://github.com/tulikasah689/Doc.git"
            }
        }
        stage('Build')
        {
            steps
            {
                echo 'Hello World'
        echo 'Building.....'
                bat 'mvn clean install'
            }
        }
        stage('Unit Test')
        {
            steps
            {
        echo 'Testing....'
                bat 'mvn test'
            }
        }
        stage('Sonar Analysis')
        {
            steps
            {
        echo 'Sonar Analysis....'
                withSonarQubeEnv("SonarQube")
                {
                    bat "mvn sonar:sonar"
                }  
            }
        }
         stage('Upload to Artifactory')
        {
            steps
            {
            echo 'Uploading....'
                rtMavenDeployer (
                    id: 'deployer-unique-id',
                    serverId: 'artifactory-server',
                    releaseRepo: 'libs-release-local',
                    snapshotRepo: 'libs-release-local'
                )
                rtMavenRun (
                pom: 'pom.xml',
                goals: 'clean install',
                deployerId: 'deployer-unique-id'
                )
                rtPublishBuildInfo (
                    serverId: 'artifactory-server'
                        )
            }
        }
        stage('Build Image')
                    {
                        steps
                            {
                                 bat "docker build -t dockima:${BUILD_NUMBER} ."
                            }
                    }

        stage("Cleaning Previous Deployment"){
            steps{
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                            bat "docker stop assignmentdevcontainer"
                            bat "docker rm -f assignmentdevcontainer"
                        }
            }
        }
        stage ("Docker Deployment")
        {
        steps
        {
        bat "docker run --name assignmentdevcontainer -d -p 9056:8080 dockima:${BUILD_NUMBER}"
        }
       }
        stage ("Pushing the image to dockerhub"){
            steps{
                script{
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') { 
                            bat "docker login -u tulikasah689 -p CallmeDK@1011"
                            bat "docker tag dockima:${BUILD_NUMBER}  tulikasah689/dockima:${BUILD_NUMBER}"
                            bat "docker rmi dockima:${BUILD_NUMBER}"
                            bat "docker push tulikasah689/dockima:${BUILD_NUMBER}"
                }
            }
        }    
      }
    }  
  }
