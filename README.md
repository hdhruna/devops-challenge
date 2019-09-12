# Goal

Modify/extend this repo in such a way that the server running will autoscale when the number of requests go up/down. The goal is to reach 150 requests per second on the server side with an average response time of less than 100ms.


# Setup

You should have been provided with a `service-account.json` file, as well as a Google `project id`.

You will need to have the following installed:
* [`gcloud`](https://cloud.google.com/sdk/gcloud/)
* [`helm`](https://docs.helm.sh/using_helm/)
* [`terraform`](https://learn.hashicorp.com/terraform/)

Using the `service-account.json` file provided, the following commands will be useful in getting started.
**NOTE**: some of the steps along the way are designed to fail. You will need to fix the errors in order to continue:
```
# auth on gcloud
gcloud auth activate-service-account --key-file=service-account.json
# run Terraform
GOOGLE_APPLICATION_CREDENTIALS=service-account.json terraform apply -var 'k8s_project=<PROJECT ID>'
# get k8s credentials
gcloud container clusters get-credentials challenge --zone europe-west1-b --project <PROJECT ID>

helm install --name client helm/client
helm install --name server helm/server
```

## Details
* The client is a single threaded go APP that makes gRPC requests to the server side. Using the client replicas count and `waitTimeBetweenRequests` value of the client, you can change the number of client's requests.
* The metrics needed, are exported from the client (and server) in prometheus format.
    - `travelaudience_gserver_operations_ops`, number of requests per pod
    - `travelaudience_gserver_operations_ops_duration_count`, number of request duration's observations, per pod
    - `travelaudience_gserver_operations_ops_duration_sum`, sum of request duration's observations, per pod
* The server side should autoscale up/down based on whatever metrics you decide to be important for that.
* Wrap all your work as a tarball and mail it to us. Include any documentation, prometheus rules, or grafana dashboards that you feel are relevant to your solution.
