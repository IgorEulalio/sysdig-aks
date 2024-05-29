kubectl create -n sysdig-cluster-shield secret docker-registry gar-cred \                                                          ✔  sysdig-aks/sysdig-cluster-shield ⎈  12:18:37 PM 
  --docker-server=us-docker.pkg.dev \
  --docker-username=oauth2accesstoken \
  --docker-password=$(gcloud auth print-access-token) \
  --docker-email=igor.eulalio@sysdig.com