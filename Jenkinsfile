try {
    node {
        ansiColor('xterm') {
            stage("checkout") {
                checkout scm
                env.GIT_BRANCH = "7.3-buster"
            }
            stage("build") {
                withEnv([
                    "DOCKER_BUILDKIT=1",
                    "PHP_TAG=" + env.GIT_BRANCH
                ]) {
                    sh "make build"
                }
            }
            stage("publish") {
                docker.withRegistry("", "dockerhub-korekontrolrobot") {
                    sh "docker push korekontrol/php:${env.GIT_BRANCH}"
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
            channel: '#ci',
            color: 'good',
            message: "${env.JOB_NAME}: build <${BUILD_URL}|#${env.BUILD_NUMBER}> suceeded.\n\nChangelog:\n```" + getGitChangelog() + "```",
            teamDomain: slack_team,
            token: slack_token
        )
    }
}

def notifyError(log) {
    withCredentials([usernamePassword(credentialsId: 'slack_team_token', passwordVariable: 'slack_token', usernameVariable: 'slack_team')]) {
        slackSend (
            channel: '#ci',
            color: 'danger',
            message: "${env.JOB_NAME}: build <${BUILD_URL}|#${env.BUILD_NUMBER}> failed.\n\n*Error:*\n```${log} ```\nChangelog:\n```" + getGitChangelog() + "```",
            teamDomain: slack_team,
            token: slack_token
        )
    }
}

@NonCPS
def getBuildLog() {
    return currentBuild.rawBuild.getLog(10)
}

@NonCPS
def getGitBranchName() {
    return scm.branches.first()
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
