env.DOCKER_REGISTRY = 'indradock'
env.DOCKER_IMAGE_NAME = 'landingpage-app'
pipeline {
    agent any
#    triggers {
 #       pollSCM(env.GIT_BRANCH == 'main' ? '* * * * *': '')
  #  }
    triggers { pollSCM '* * * * *' }
    stages {
        stage('versi') {
            steps {
                sh('sed -i "s/versi/$BUILD_NUMBER/g" index.html')
                }
            }
        stage('docker build image') {
            steps {
                sh "docker build --build-arg APP_NAME=$DOCKER_IMAGE_NAME -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$BUILD_NUMBER ."
                }
           }
        stage('Docker push image') {
            steps {                
                sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$BUILD_NUMBER"
                }
           }
        stage('versi image') {
            steps {
                sh('sed -i "s/versi/$BUILD_NUMBER/g" landing.yml')
                }
           }
        stage('change namespace') {
            steps {
                sh('sed -i "s/default/production/g" landing.yml')
                }
           }
        stage('set domain') {
            steps {
                sh('sed -i "s/landing.indraku.online/landing.indraku.online/g" landing.yml')
                }
           }
        stage('deploy ke kubernetes') {
            steps {
                sh('kubectl apply -f landing.yml')
                }
           }
        stage('remove image docker') {
            steps {
                sh "docker rmi $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$BUILD_NUMBER"
                }
           }
         stage('show ingress') {
            steps {
                sh('kubectl get ingress -n=production')
                }
           }        
      }
}

