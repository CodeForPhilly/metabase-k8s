# metabase-k8s
Set up Metabase in a Kubernetes cluster with a Postgres backend.

## Up and Running

If you want to stand up an example of Metabase locally you can do so just after you install:

- [kind](https://kind.sigs.k8s.io/docs/user/quick-start#installation) - Uses Docker to create a Kubernetes control plane and worker nodes on your local machine.
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) - The Kubernetes command line tool.

After you've installed these two tools, you can stand up a properly configured kind cluster by running:

```
bash local/start_kind.sh
```

This command creates a local kind cluster with HTTP ingress (see `local/kind_config.yml` for more details), using [Contour](https://projectcontour.io/) (see `local/start_kind.sh` for more details).

After the kind cluster is up and running, you can simple execute:

```
kubectl apply -f manifests/local
```

This will create environment variables for the Postgres and Metabase containers, expose Postgres and Metabase as services, and make Metabase available to you at `127.0.0.1`. You can check the status of your pods with `kubectl get pods`.

Metabase comes with a sample data set out of the box, so you can skip configuring your own data sources if you so choose.

## Breakdown

When you are done with your cluster, you can run the following to delete your resources:

```
kubectl delete -f manifests/local
```

Finally, you can delete your cluster with:

```
kind delete cluster
```

## Moving to Cloud

The local manifests are set up to be easy to run, and you should to be able to point at a remote k8s control plane (that is configured for HTTP ingress) and achieve the same results, however you may want to create a PersistentVolume for the Postgres database to ensure your Postgres backend is truly persistent.

## Why Metabase?

Metabase is very easy to deploy, all you need to do is point a Metabase container at a Postgres database and then start using the Metabase GUI! It very much horizontally scalable, since every Metabase container simply needs to be pointed at the Postgres backend.

Additionally, Metabase has a full REST API, which can be very useful for programmatically setting up user access, database hooks, table documentation, and more.
