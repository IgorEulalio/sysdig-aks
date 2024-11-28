# Set the default goal to deploy-all
.DEFAULT_GOAL := deploy-all

# Terraform directories
KUBERNETES_CLUSTER_DIR=kubernetes
SYSDIG_SECURE=sysdig-secure
FALCO_FOLDER=falco

# Helper function to check if .env file exists and load it
define load_env
	@if [ ! -f .env ]; then \
		echo ".env file not found!"; \
		exit 1; \
	else \
		echo "Sourcing .env file"; \
		set -a; source .env; set +a; \
	fi
endef

# Deploy all environments
deploy-all: deploy-kubernetes deploy-sysdig-secure

############################################
##### Deploy environments individually #####
############################################
destroy-all: destroy-kubernetes destroy-sysdig-secure

deploy-kubernetes:
	@$(load_env) && cd $(KUBERNETES_CLUSTER_DIR) && terraform init && terraform apply -auto-approve

deploy-sysdig-secure:
	@$(load_env) && cd $(SYSDIG_SECURE) && terraform init && terraform apply -auto-approve

############################################
##### Destroy environments individually #####
############################################

destroy-kubernetes:
	@$(load_env) && cd $(AKS_DIR) && terraform init && terraform destroy -auto-approve

destroy-sysdig-secure:
	@$(load_env) && cd $(SYSDIG_SECURE) && terraform init && terraform destroy -auto-approve