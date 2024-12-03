
# **Deploy a Static Website with Docker and GitHub Actions**

This project demonstrates how to build, deploy, and test a static website using **Docker** and **GitHub Actions**. It includes a simple NGINX-based static website containerized with Docker and automated CI/CD using GitHub Actions.

---

## **Features**
- Containerized static website using Docker.
- Automated build and deployment using GitHub Actions.
- Basic continuous integration (CI) pipeline with `curl` to test the deployment.

---

## **Project Structure**
```
<project-directory>/
├── index.html           # Static website homepage
├── Dockerfile           # Docker configuration for building the image
└── .github/
    └── workflows/
        └── deploy.yml   # GitHub Actions workflow for CI/CD
```

---

## **Prerequisites**
- [Docker](https://www.docker.com/) installed locally.
- A GitHub repository for hosting the project.
- Basic understanding of Docker and GitHub Actions.

---

## **Getting Started**

### **1. Clone the Repository**
Clone the repository to your local machine:
```bash
git clone <repository-url>
cd <repository-directory>
```

### **2. Build and Run Locally**
1. **Build the Docker Image**:
   ```bash
   docker build -t static-website .
   ```
2. **Run the Docker Container**:
   ```bash
   docker run -d -p 8080:80 static-website
   ```
3. **Access the Website**:
   Open `http://localhost:8080` in your browser.

---

## **Automated CI/CD with GitHub Actions**

This project uses GitHub Actions to automate the testing of the Dockerized website.

### **Workflow File: `.github/workflows/deploy.yml`**
- **Triggers**: Runs on every push to the `main` branch.
- **Steps**:
  1. Check out the repository.
  2. Build the Docker image.
  3. Start a Docker container.
  4. Wait for the container to initialize.
  5. Test the container with `curl` to ensure the website is up.

### **How to Enable the Workflow**
1. Push your project to a GitHub repository.
2. The workflow will run automatically on every push to the `main` branch.
3. You can monitor the workflow in the **Actions** tab of your GitHub repository.

---

## **Dockerfile Details**

The `Dockerfile` is configured to use NGINX as the web server for serving the static content.

```dockerfile
# Use the official NGINX base image
FROM nginx:alpine

# Copy static website files to NGINX's default serving directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
```

---

## **GitHub Actions Workflow**

Here’s the complete `deploy.yml` file:

```yaml
name: Deploy Static Website with Docker

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Build Docker Image
        run: docker build -t static-website .

      - name: Run Docker Container
        run: |
          docker run -d -p 8080:80 static-website
          sleep 10

      - name: Check Running Containers
        run: docker ps

      - name: Output Container Logs
        run: docker logs $(docker ps -q -f ancestor=static-website)

      - name: Test Docker Container
        run: |
          curl -v http://127.0.0.1:8080 || exit 1
```

---

## **Troubleshooting**

1. **Error: `curl: (56) Recv failure: Connection reset by peer`**
   - Ensure enough time for the container to initialize by adding a `sleep` step in the workflow.

2. **Container Fails to Start**:
   - Check the container logs:
     ```bash
     docker logs <container_id>
     ```

3. **Port Binding Issues**:
   - Ensure port `8080` is available on the host system.

---

## **Next Steps**
- Customize the `index.html` to add your own static content.
- Extend the workflow to deploy the container to a cloud platform like AWS, Azure, or GCP.
- Integrate additional tests for the website in the CI pipeline.

---

## **License**
This project is open source and available under the [MIT License](LICENSE).

---

