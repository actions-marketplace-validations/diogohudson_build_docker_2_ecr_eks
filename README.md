# AWS ECR 2 EKS Action

This Action allows you to create a Docker image, push it into an ECR repository and execute `kubectl` commands against a EKS cluster.

This action, wouldn't exist without the excellent work made by the community in the [aws-ecr-action ](https://github.com/kciter/aws-ecr-action) and [eks-kubectl-action](https://github.com/ianbelcher/eks-kubectl-action) repos.

## Parameters



| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `access_key_id` | `string` | | Your AWS access key id (used for push image to ECR, and config kubeconfig) |
| `secret_access_key` | `string` | | Your AWS secret access key (used for push image to ECR, and config kubeconfig) |
| `account_id` | `string` | | Your AWS Account ID (used for push image to ECR, and config kubeconfig) |
| `repo` | `string` | | Name of your ECR repository (You can specify an existant or not) |
| `region` | `string` | | Your AWS region (used for push image to ECR, and config kubeconfig) |
| `create_repo` | `boolean` | `false` | Set this to true to create the repository if it does not already exist |
| `set_repo_policy` | `boolean` | `false` | Set this to true to set a IAM policy on the repository |
| `repo_policy_file` | `string` | `repo-policy.json` | Set this to repository policy statement json file. only used if the set_repo_policy is set to true |
| `image_scanning_configuration` | `boolean` | `false` | Set this to True if you want AWS to scan your images for vulnerabilities |
| `tags` | `string` | `latest` | Comma-separated string of ECR image tags (ex latest,1.0.0,) |
| `dockerfile` | `string` | `Dockerfile` | Name of Dockerfile to use |
| `extra_build_args` | `string` | `""` | Extra flags to pass to docker build (see docs.docker.com/engine/reference/commandline/build) |
| `cache_from` | `string` | `""` | Images to use as cache for the docker build (see `--cache-from` argument docs.docker.com/engine/reference/commandline/build) |
| `path` | `string` | `.` | Path to Dockerfile, defaults to the working directory |
| `prebuild_script` | `string` | | Relative path from top-level to script to run before Docker build |
| `registry_ids` | `string` | | A comma-delimited list of AWS account IDs that are associated with the ECR registries. If you do not specify a registry, the default ECR registry is assumed |
| `cluster_name` | `string` | | The name of the cluster (For now, it must reside on the same account as the ECR) |
| `kubectl_command` | `string` | | The command to be executed against the specified cluster, example: `deploy -f my_app.yaml` |


## Usage

```yaml
jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: docker://ghcr.io/kciter/aws-ecr-action:latest
      with:
        access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        account_id: ${{ secrets.AWS_ACCOUNT_ID }}
        repo: docker/repo
        region: ap-northeast-2
        tags: latest,${{ github.sha }}
        create_repo: true
        image_scanning_configuration: true
        set_repo_policy: true
        repo_policy_file: repo-policy.json
        cluster_name: my-great-cluster-name
        kubectl_command: deploy -f deployment/my_app.yaml        
```

If you don't want to use the latest docker image, you can point to any reference in the repo directly.

```yaml
  - uses: diogohudson/build_docker_2_ecr_eks@master
  # or
  - uses: diogohudson/build_docker_2_ecr_eks@0589ad88c51a1b08fd910361ca847ee2cb708a30
```

## License
The MIT License (MIT)

