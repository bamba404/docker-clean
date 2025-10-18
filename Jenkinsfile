pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
    DOCKER_IMAGE = "bamba/my-node-app"
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
        script {
          docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
            docker.image("${DOCKER_IMAGE}").push('latest')
          }
        }
      }
    }

    stage('Déployer sur le serveur') {
      steps {
        sshagent(['ssh-credentials-id']) {
          sh '''
            ssh user@ip-du-serveur "docker pull bamba/my-node-app:latest && docker stop app || true && docker rm app || true && docker run -d --name app bamba/my-node-app:latest"
          '''
        }
      }
    }
  }
}
