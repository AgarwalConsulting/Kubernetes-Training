setup:
	terraform apply
	mkdir -p var
	terraform output kubeconfig > var/kubeconfig.yaml
	terraform output config_map_aws_auth > var/configmap.yaml

connect-eks:
	cp ~/.kube/config var/original.yaml
	cp var/kubeconfig.yaml ~/.kube/config
	kubectl apply -f var/configmap.yaml

disconnect-eks:
	cp var/original.yaml ~/.kube/config

destroy:
	terraform destroy
