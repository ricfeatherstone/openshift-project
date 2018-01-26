# Openshift Project Provisioning

Use [Openshift Pipelines](https://docs.openshift.com/container-platform/3.7/dev_guide/openshift_pipeline.html) to 
provision projects for your CICD pipeline.

Given a project name, this will create:

* A CICD project containing Jenkins to run the builds called <name>-<buildSuffix>
* For all non production environments a project called <name>-<environment>
* A production environment called <name>

## Setup 

1. Create the project provisioning namespace

```bash
oc new-project project-provisioning
```

2. Bootstrap Jenkins to include the [OpenShift Client DSL](https://github.com/openshift/jenkins-client-plugin)

```bash
oc new-build jenkins:2~https://github.com/ricfeatherstone/openshift-jenkins-bootstrap.git \
    --name=jenkins-bootstrap
```

3. Launch Jenkins using the persistent template

```bash
oc new-app jenkins-persistent \
    -p NAMESPACE=$(oc project -q) \
    -p JENKINS_IMAGE_STREAM_TAG=jenkins-bootstrap:latest
```

4. As Cluster Admin, allow the Jenkins service account to create project requests

```bash
oc create -f - <<EOF
apiVersion: v1
kind: ClusterRole
metadata:
    name: project-provisioner
rules:
- apiGroups:
  - ""
  - project.openshift.io
  attributeRestrictions: null
  resources:
  - projectrequests
  verbs:
  - create
EOF
oc adm policy add-cluster-role-to-user project-provisioner system:serviceaccount:project-provisioning:jenkins
```

5. Create the project provisioning pipeline

```bash
oc new-build https://github.com/ricfeatherstone/openshift-project-provisioning.git#feature/create-projects \
    --strategy=pipeline \
    --name=test-pipeline
```
