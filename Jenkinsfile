try {
    node {
        ansiColor('xterm') {
            stage("checkout") {
                checkout scm
                sh "env"
            }
            stage("build") {
                withEnv([
                    "DOCKER_BUILDKIT=1",
                    "PHP_TAG=" + getGitBranchName()
                ]) {
                    sh "make build"
                }
            }
            stage("publish") {
                docker.withRegistry("", "dockerhub-korekontrolrobot") {
                    sh "docker image ls"
                }
            }
            stage("finish") {
                notifySuccessful()
            }
        }
    }
} catch (err) {
    notifyError(err)
    throw(err)
}

def notifySuccessful() {
    withCredentials([usernamePassword(credentialsId: 'slack_team_token', passwordVariable: 'slack_token', usernameVariable: 'slack_team')]) {   
        slackSend (
            channel: '#p1',
            color: getSlackColor(),
            message: "${env.JOB_NAME}: build #${env.BUILD_NUMBER} succeeded\n${BUILD_URL}\n```" + getGitChangelog() + " ```",
            teamDomain: slack_team,
            token: slack_token
        )
    }
}

def notifyError(log) {
    withCredentials([usernamePassword(credentialsId: 'slack_team_token', passwordVariable: 'slack_token', usernameVariable: 'slack_team')]) {
        slackSend (
            channel: '#ci',
            color: getSlackColor(),
            message: "${env.JOB_NAME}: build #${env.BUILD_NUMBER} failed\n${BUILD_URL}\n`Error: ${log}`\n```" + getGitChangelog() + " ```",
            teamDomain: slack_team,
            token: slack_token
        )
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
def getGitBranchName() {
    return scm.branches.first().getExpandedName(env.getEnvironment())
}

@NonCPS
def getGitChangelog() {
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
