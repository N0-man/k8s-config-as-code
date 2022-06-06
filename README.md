# Boiler plate for trying config as code for Helm

The problem statement was is to allow consumer to pass arbitary shell scripts to be executed against an RDBMS - 
such as creating DB / users etc.

>Using ConfigMap as code allows to pass values as code that can be mounted as shell script in a Pod
### [Using ConfigMaps as files from a Pod](https://kubernetes.io/docs/concepts/configuration/configmap/#using-configmaps-as-files-from-a-pod)

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
```

Test the k8s job with default db.script in values.yaml
```
helm upgrade bahmni-db-setup bahmni-db-setup/ --install --wait
```

You can override the db.script with `bahmni-db-setup/db-scripts.sh`
```
DB_SCRIPT=$(cat bahmni-db-setup/db-scripts.sh) && helm upgrade bahmni-db-setup bahmni-db-setup/ --set db.script=$DB_SCRIPT --install --wait
```

Uninstall
```
helm uninstall bahmni-db-setup
```

### To connect to your database:
The DB is running on 
Primary: mysql.default.svc.cluster.local:3306
Username: root

You can get the master password using
```
kubectl get secret --namespace default mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d
```
1. Export root password
```
MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d)
```
2. Run a pod that you can use as a client:

```
  kubectl run mysql-client --rm --tty -i --restart='Never' --image  docker.io/bitnami/mysql:5.7 --namespace default --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --command -- bash
```
3. To connect to primary service (read/write):

```
  mysql -h mysql.default.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"
```