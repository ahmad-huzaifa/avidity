# main.tf

# Declare the provider (assuming it's a Linux host with ssh access)
provider "ssh" {
  host = "your_host_ip"
  user = "your_ssh_user"
  private_key = file("path/to/your/private/key")
}

# Declare null_resource to execute commands on the host
resource "null_resource" "web_app_provisioner" {
  # Trigger provisioning when any of the configurations change
  triggers = {
    always_run = "${timestamp()}"
  }

  # Execute commands on the host
  provisioner "local-exec" {
    command = <<-EOT
      # Install PostgreSQL 13
      sudo apt-get update
      sudo apt-get install -y postgresql-13

      # Customize PostgreSQL configuration (replace with your actual configuration)
      echo 'Your PostgreSQL Configuration' |  
      sudo systemctl restart postgresql

      # Install Redis 6
      sudo apt-get install -y redis-server

      # Customize Redis configuration (replace with your actual configuration)
      echo 'Your Redis Configuration' | sudo tee -a /etc/redis/redis.conf
      sudo systemctl restart redis-server

      # Install Nginx 1.10
      sudo apt-get install -y nginx

      # Customize Nginx configuration (replace with your actual configuration)
      echo 'Your Nginx Configuration' | sudo tee -a /etc/nginx/nginx.conf
      sudo systemctl restart nginx
    EOT
  }
}
