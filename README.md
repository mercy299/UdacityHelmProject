# My Kubernetes Cluster Documentation

Welcome to the documentation for my Kubernetes cluster! This document provides detailed information about the configuration of the cluster and the deployment process for applications.
I want you to note that every command that was written with my detail can be changed, so you don't have complications. Thanks!

## Introduction

This Kubernetes cluster is used to deploy and manage applications in a production environment. It consists of multiple nodes running on AWS EC2 instances and is managed using Amazon EKS.

## Cluster Configuration

- Kubernetes version: 1.21
- Number of nodes: 3
- Node types: t3.medium
- Networking: Calico for network policy enforcement
- Additional configuration: Cluster autoscaler for automatic scaling of nodes

## Deployment Process

Applications are deployed to the Kubernetes cluster using the following process:

1. Applications are packaged as Docker containers and pushed to a Docker registry.
N/B: You can build with `docker build udacity_pproject .`
     You can push with `docker run -e DB_USERNAME=postgres -e DB_PASSWORD=ioFKD31skC udacity_project`

     - You can authenticate with these push commands  when trying to push the created image to amazon ecr  `aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 196116466484.dkr.ecr.us-east-1.amazonaws.com`
     
     - You can tag with this command `docker tag udacity_project:latest 196116466484.dkr.ecr.us-east-1.amazonaws.com/udacity_project:latest`

     - You can push to amazon ecr with this command `docker push 196116466484.dkr.ecr.us-east-1.amazonaws.com/udacity_project:latest` 

     - Don't forget to run a codebuild with your aws account.

2. Kubernetes resources (e.g., Deployments, Services) are defined in YAML manifest files.
3. Manifest files are applied to the cluster using `kubectl apply -f k8s/deployment.yml`; `kubectl apply -f k8s/configmap.yml`; `kubectl apply -f k8s/secrets.yml`.
4. Rolling updates are performed using `kubectl set image` to update container images.

## Accessing the Cluster

To access the Kubernetes cluster, follow these steps:

1. Install the AWS CLI and configure credentials.
2. Install `kubectl` and configure it to use the cluster.
3. Use `kubectl` commands to interact with the cluster, such as `kubectl get pods`, `kubectl describe deployment`, etc.


N/B: When you have an error that says `Error: INSTALLATION FAILED: Kubernetes cluster unreachable: Get "http://localhost:8080/version": dial tcp [::1]:8080: connect: connection refused`.
You simply have to make sure that you have correctly connected your cluster from eks. 

Helm postgres also require a min of 10G on the persistent volume for it to automatically bind and run correctly.

- When you try toconnect your cluster and you get a `Can't create directory for writing: [Errno 13] Permission denied: '/etc/rancher'`. This simply means you should try to export the kubeconfig, Just run this command `export KUBECONFIG=~/.kube/config`. 

## Troubleshooting

If you encounter any issues with the Kubernetes cluster, you can use the following troubleshooting steps:

1. Check pod status: `kubectl get pods`
2. View pod logs: `kubectl logs `
3. Describe deployments: `kubectl describe deployment <deployment-name>`
4. Diagnose networking: `kubectl get svc`, `kubectl describe svc`



#kubectl port-forward --namespace default svc/helmproject-postgresql 5432:5432 &
   #PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432

# kubectl run helmproject-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:16.2.0-debian-12-r6 --env="PGPASSWORD=$POSTGRES_PASSWORD" \
#       --command -- psql --host helmproject-postgresql -U postgres -d postgres -p 5432

# PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5433

#PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5433 < db/1_create_tables.sql

#PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5433 < db/2_seed_users.sql

#PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5433 < db/3_seed_tokens.sql

## Contributing

This project is open source and contributions are welcome! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Make your changes.
3. Submit a pull request.

## Additional Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Calico Documentation](https://docs.projectcalico.org/)
{}


