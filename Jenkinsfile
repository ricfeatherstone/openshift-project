def name = 'test'
def buildSuffix = 'cicd'
def nonProductionSuffixes = ['sandpit']
def projectNames = []

stage('Create Projects') {
    openshift.withCluster() {
        projectNames = listProjectNames(name, buildSuffix, nonProductionSuffixes)

        for(projectName in projectNames) {
            echo "Creating project - ${projectName}"
            sh "oc new-project ${projectName}"
        }
    }
}

def listProjectNames(name, buildSuffix, nonProductionSuffixes) {
    names = [name]
    for(suffix in nonProductionSuffixes + buildSuffix) {
        names.add("${name}-${suffix}")
    }

    names
}
