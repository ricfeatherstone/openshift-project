#!/usr/bin/env bash

oc login -u system:admin

oc delete project project-provisioning test-cicd test-sandpit test-test test
oc delete clusterrole project-provisioner