setup:
	terraform apply
	mkdir -p var
	terraform output kubeconfig > var/kubeconfig.yaml
	terraform output config_map_aws_auth > var/configmap.yaml

eksctl-setup:
	eksctl create cluster ${AWS_CLUSTER_NAME}

eksctl-teardown:
	eksctl delete cluster ${AWS_CLUSTER_NAME}

connect-eksctl:
	aws eks update-kubeconfig --name ${AWS_CLUSTER_NAME} --region us-east-1

disconnect-eks:
	cp var/original.yaml ~/.kube/config

destroy:
	terraform destroy
