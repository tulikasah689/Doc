pipeline {
    agent any
      environment
    {
        dockerImage = ''
        registry='tulikasah689/our-web-app'
        registryCredential='Docker_Hub'
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
                git url : "https://github.com/tulikasah689/FirstMavenApp.git"
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
    }
}
