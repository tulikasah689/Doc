pipeline {
    agent any   
    environment {
                    registry = "shilpabains/dock"
                    registryCredential = 'DockerHub'
                    dockerImage = ''
                 }
    stages {
        stage('Fetch')
        {
            steps
            {
                git url : "https://github.com/Shilpa40/MavenappSourceCode.git"
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
                    serverId: 'Artifactory',
                    releaseRepo: 'example-repo-local',
                    snapshotRepo: 'example-repo-local'
                )
                rtMavenRun (
                pom: 'pom.xml',
                goals: 'clean install',
                deployerId: 'deployer-unique-id'
                )
                rtPublishBuildInfo (
                    serverId: 'Artifactory'
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
        bat "docker run --name assignmentdevcontainer -d -p 9056:8080 dockim:${BUILD_NUMBER}"
        }
       }
        stage ("Pushing the image to dockerhub"){
            steps{
                script{
                        docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') { 
                            bat "docker login -u shilpabains -p quahfm637320!"
                            bat "docker tag dockim:${BUILD_NUMBER}  shilpabains/dockim:${BUILD_NUMBER}"
                            bat "docker rmi dockim:${BUILD_NUMBER}"
                            bat "docker push shilpabains/dockim:${BUILD_NUMBER}"
                }
            }
        }    
      }
    }  
  }
