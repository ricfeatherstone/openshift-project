def name = env.NAME
def buildSuffix = env.BUILD_SUFFIX
def nonProductionSuffixes = env.NON_PROD_SUFFIXES
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
    suffixes = nonProductionSuffixes.split(',') + buildSuffix
    for(suffix in suffixes) {
        names.add("${name}-${suffix}")
    }

    names
}