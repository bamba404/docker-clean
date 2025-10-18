pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
    DOCKER_IMAGE = "adminfull/my-node-app"
  }

  stages {
    stage('Installer les dépendances') {
      steps {
        sh 'npm install'
      }
    }

    stage('Lancer les tests') {
      steps {
        sh 'npm test'
      }
    }

    stage('Construire l’image Docker') {
      steps {
        script {
          docker.build("${DOCKER_IMAGE}")
        }
      }
    }

 stage('Pousser sur Docker Hub') {
  steps {
    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', usernameVariable: 'adminfull', passwordVariable: 'adminfull')]) {
      sh """
        echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
        docker push ${DOCKER_IMAGE}:latest
      """
    }
  }
}

    stage('Déployer sur le serveur') {
      steps {
        sshagent(['ssh-credentials-id']) {
          sh '''
            ssh user@ip-du-serveur "docker pull adminfull/my-node-app:latest && docker stop app || true && docker rm app || true && docker run -d --name app adminfull/my-node-app:latest"
          '''
        }
      }
    }
  }
}
