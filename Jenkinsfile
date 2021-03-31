pipeline{

    checkout scm

    docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {

        def customImage = docker.build("shilpabains/webapp1")

        /* Push the container to the custom Registry */
        customImage.push()
    }
}