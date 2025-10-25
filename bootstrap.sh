#!/bin/bash
set -e  # Exit immediately if a command fails
echo "🚀 Starting full DevOps pipeline execution..."

# Step 1: Terraform Provisioning
echo "🔹 Running Terraform..."
cd terraform
terraform init -input=false
terraform apply -auto-approve
cd ..

# Step 2: Ansible Configuration
echo "🔹 Running Ansible..."
cd ansible
ansible-playbook -i inventory.ini playbook.yml \
  --private-key ~/.ssh/terraform-key.pem -u ubuntu
cd ..

# Step 3: Deploy Docker Swarm Stack
echo "🔹 Deploying Docker stack..."
cd django_app
docker stack deploy -c docker-compose.yml myapp
docker service ls
cd ..

echo "✅ Deployment completed successfully!"
