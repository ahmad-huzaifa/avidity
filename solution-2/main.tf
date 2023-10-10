# main.tf

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_container" "postgresql" {
  name  = "postgresql"
  image = "postgres:13"

  command = [
    "postgres",
    "-c", "max_connections=100",
    "-c", "shared_buffers=256MB",
    # Add more custom PostgreSQL configurations as needed
  ]

  ports {
    internal = 5432
    external = 5432
  }
}

# resource "docker_container" "redis" {
#   name  = "redis"
#   image = "redis:6"
#   # Add custom Redis configurations if needed
# }

# resource "docker_container" "nginx" {
#   name  = "nginx"
#   image = "nginx:1.10"
#   # Add custom Nginx configurations if needed
#   ports {
#     internal = 80
#     external = 80
#   }
# }

# resource "docker_container" "web_app" {
#   name  = "web_app"
#   image = "your_git_repository:latest" # Update with your actual Git repository
#   ports {
#     internal = 8000
#     external = 8000
#   }
#   depends_on = [
#     docker_container.postgresql,
#     docker_container.redis,
#     docker_container.nginx,
#   ]
# }

