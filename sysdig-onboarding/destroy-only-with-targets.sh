#!/bin/bash

# Initialize a variable to hold the target options
target_options=""

# Loop through each resource listed in the Terraform state
for resource in $(terraform state list); do
  # Append each resource to the target options string
  target_options+="--target=${resource} "
done

# Execute terraform destroy with all target options
terraform destroy ${target_options}

