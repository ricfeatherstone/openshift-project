#!/usr/bin/env bash

oc new-project project-provisioning
oc new-build jenkins:2~https://github.com/ricfeatherstone/openshift-jenkins-bootstrap.git \
    --name=jenkins-bootstrap
oc new-app jenkins-persistent \
    -p NAMESPACE=$(oc project -q) \
    -p JENKINS_IMAGE_STREAM_TAG=jenkins-bootstrap:latest
oc new-build https://github.com/ricfeatherstone/openshift-project-provisioning.git#feature/create-projects \
    --strategy=pipeline \
    --name=create-projects
oc start-build create-projects \
    -e NAME=example \
    -e BUILD_SUFFIX=cicd \
    -e NON_PROD_SUFFIXES=sandpit,test
oc login -u system:admin
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
