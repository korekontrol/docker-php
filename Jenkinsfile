pipeline {
    stages {
        stage("checkout") {
            steps {
                checkout scm
            }
        }
        stage("build") {
            steps {
                sh "DOCKER_BUILDKIT=1 PHP_TAG=${BRANCH_NAME} make build"
            }
        }
        stage("publish") {
            steps {
                docker.withRegistry("", "dockerhub-korekontrolrobot") {
                    sh "docker image ls"
                }
            }
        }
    }
    post {
        success {
            notifySuccessful()
        }
        failure {
            notifyError()
        }
    }
}


def notifySuccessful() {
    withCredentials([usernamePassword(credentialsId: 'slack_team_token', passwordVariable: 'slack_token', usernameVariable: 'slack_team')]) {
        slackSend (channel: '#p1', color: getSlackColor(), message: "${env.JOB_NAME}: build and deploy #${env.BUILD_NUMBER} succeeded\n```" + getChangeString() + " ```", teamDomain: $slack_team, token: $slack_token)
    }
}

def notifyError() {
    withCredentials([usernamePassword(credentialsId: 'slack_team_token', passwordVariable: 'slack_token', usernameVariable: 'slack_team')]) {
        slackSend (channel: '#p1', color: getSlackColor(), message: "${env.JOB_NAME}: build and deploy #${env.BUILD_NUMBER} failed\n`Error: ${getBuildLog}`\n```" + getChangeString() + " ```", teamDomain: $slack_team, token: $slack_token)
    }
}

def getSlackColor() {
  def SLACK_COLOR_MAP = ['SUCCESS': 'good', 'FAILURE': 'danger', 'UNSTABLE': 'danger', 'ABORTED': 'danger']
  return SLACK_COLOR_MAP[currentBuild.currentResult]
}

@NonCPS
def getBuildLog() {
    return currentBuild.rawBuild.getLog(10)
}

@NonCPS
def getChangeString() {
    MAX_MSG_LEN = 100
    def changeString = ""
    echo "Gathering SCM changes"
    def changeLogSets = currentBuild.changeSets
    for (int i = 0; i < changeLogSets.size(); i++) {
        def entries = changeLogSets[i].items
        for (int j = 0; j < entries.length; j++) {
            def entry = entries[j]
            truncated_msg = entry.msg.take(MAX_MSG_LEN)
            changeString += " * ${truncated_msg} [${entry.author}]\n"
        }
    }
    if (!changeString) {
        changeString = " - No new changes"
    }
    return changeString
}
