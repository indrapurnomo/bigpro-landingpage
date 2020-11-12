pipeline {
  agent any 
  triggers {
        pollSCM(env.GIT_BRANCH == 'main' ? '* * * * *' : env.GIT_BRANCH == 'staging' ? '* * * * *' : '')
    }
  stages {
      stage('Checkout SCM') {
        steps{
          checkout scm
          sh "ls"
          sh "git --version"
          echo "Deployment TO ${env.GIT_BRANCH}"
          script {   env.DOCKER_REGISTRY = 'indradock'
                     env.DOCKER_IMAGE_NAME = 'landingpage-app'
                     //Change env DOCKER_IMAGE_APPS
                     //env.DOCKER_IMAGE_APPS = 'landpage' 
          }
        }
      }
      stage('Build Docker Image') {
        steps{
          script {
            if ( env.GIT_BRANCH == 'staging' ){
              sh "docker image build . -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:staging_${BUILD_NUMBER}"
              sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:staging_${BUILD_NUMBER}"
             // echo "Docker Image ${BUILD_NUMBER} Build For Server Stagging ${currentBuild.currentResult}"
            }  
            else if ( env.GIT_BRANCH == 'main' ){
              sh "docker image build . -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:production_${BUILD_NUMBER}"
              sh "docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:production_${BUILD_NUMBER}"
            //  echo "Docker Image ${BUILD_NUMBER} Build For Server Production ${currentBuild.currentResult}"
            }
          }  
        }
      }
  //  stage('Docker Image Delete'){
    //    steps{
      //    script {
        //    if ( env.GIT_BRANCH == 'staging' ){
          //    sh "docker image rm -f $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:staging_${BUILD_NUMBER}"
            //  echo "Docker Image ${BUILD_NUMBER} Delete For Server Stagging ${currentBuild.currentResult}"
          //  }
           // else if ( env.GIT_BRANCH == 'main' ){
            //  sh "docker image rm -f $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:production_${BUILD_NUMBER}"
             // echo "Docker Image ${BUILD_NUMBER} Delete For Server Production ${currentBuild.currentResult}"
         //   }
         // }  
      //  }
     // }
      stage('Deploy TO K8S'){
        steps{
          script {
            if ( env.GIT_BRANCH == 'staging' ){
              //Change url wget
              sh 'wget https://raw.githubusercontent.com/indrapurnomo/bigpro-landingpage/staging/landing-stag.yml'
              sh 'sed -i "s/versi/$BUILD_NUMBER/g" landing-stag.yml'
              sh 'kubectl apply -f landing-stag.yml'
              sh 'rm -rf *'
              echo "Deploy ${BUILD_NUMBER} To Server Staging ${currentBuild.currentResult}"
            }
            else if ( env.GIT_BRANCH == 'main' ){
              //Change url wget
              sh 'wget https://github.com/indrapurnomo/bigpro-landingpage/blob/main/landing.yml'
              sh 'sed -i "s/versi/$BUILD_NUMBER/g" landing.yml'
              sh 'kubectl apply -f landing.yml'
              sh 'rm -rf *'
              echo "Deploy ${BUILD_NUMBER} To Server Production ${currentBuild.currentResult}"
            }
          }  
        }
      }
    }
//  post {
  //      always {
    //      script {
      //      if ( env.GIT_BRANCH == 'staging' ){
        //      echo "DEPLOY NUMBER ${BUILD_NUMBER} TO SERVER STAGING ${currentBuild.currentResult}"
          //    slackSend message: "DEPLOY  NUMBER ${BUILD_NUMBER} TO SERVER STAGING ${currentBuild.currentResult}"

          //  }
       //     else if ( env.GIT_BRANCH == 'main' ){
         //     echo "DEPLOY NUMBER ${BUILD_NUMBER} TO SERVER STAGING ${currentBuild.currentResult}"
           //   slackSend message: "DEPLOY NUMBER ${BUILD_NUMBER} TO SERVER PRODUCTION ${currentBuild.currentResult}"
   //         }
    //      }  
  //      }
//  }  
}

