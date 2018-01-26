
stage('Create Projects') {
    openshift.withCluster() {
        openshift.withProject( 'project-provisioning' ) {
            echo "Hello from project ${openshift.project()} in cluster ${openshift.cluster()}"
        }
    }
}
