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
                                 bat "docker build -t assignmentdevimage:${BUILD_NUMBER} ."
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
        bat "docker run --name assignmentdevcontainer -d -p 9050:8080 assignmentdevimage:${BUILD_NUMBER}"
        }
       }
 
    
 stage('Pushing the Image')
        {
               steps
               {
                  bat "docker login -u shilpabains -p quahfm637320!"
                  
                   bat "docker push shilpabains/assignmentdevimage:${BUILD_NUMBER}"
               }
           }
           
           
   



     }
    }
