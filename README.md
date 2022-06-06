# Boiler plate for trying config as code for Helm

The problem statement was is to allow consumer to pass arbitary shell scripts to be executed against an RDBMS - 
such as creating DB / users etc.

>Using Config as code allows us to pass a shell and mount it to a Job for achieving the purpose

```
Before you begin, download and run mysql 5.7
> helm repo add bitnami https://charts.bitnami.com/bitnami

> helm install mysql bitnami/mysql --set auth.rootPassword=nimda --set image.tag=5.7

🔴 Output

NAME: mysql
LAST DEPLOYED: Mon Jun  6 18:13:52 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: mysql
CHART VERSION: 9.1.4
APP VERSION: 8.0.29

** Please be patient while the chart is being deployed **

Tip:

  Watch the deployment status using the command: kubectl get pods -w --namespace default

Services:

  echo Primary: mysql.default.svc.cluster.local:3306

Execute the following to get the administrator credentials:

  echo Username: root
  MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d)

To connect to your database:

  1. Run a pod that you can use as a client:

      kubectl run mysql-client --rm --tty -i --restart='Never' --image  docker.io/bitnami/mysql:5.7 --namespace default --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --command -- bash

  2. To connect to primary service (read/write):

      mysql -h mysql.default.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"
```

You can test the k8s job
```
helm upgrade bahmni-db-setup bahmni-db-setup/ --install --wait
```

You can uninstall using
```
helm uninstall bahmni-db-setup
```