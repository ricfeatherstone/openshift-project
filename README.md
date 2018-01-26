# openshift-project

## Setup 

```bash
oc new-project project-provisioning
oc new-build https://github.com/ricfeatherstone/openshift-project-provisioning.git#feature/create-projects --strategy=pipeline --name=test-pipeline
```
