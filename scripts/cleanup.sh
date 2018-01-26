#!/usr/bin/env bash

oc login -u system:admin

oc delete project project-provisioning example-cicd example-sandpit example-test example
oc delete clusterrole project-provisioner