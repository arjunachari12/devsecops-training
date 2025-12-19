OWASP Juice Shop – Step-by-Step Setup Guide (Docker)
This document provides step-by-step instructions to set up and run OWASP Juice Shop using Docker. It is intended for students and trainers performing security labs based on the OWASP Top 10.

What is OWASP Juice Shop?
OWASP Juice Shop is an intentionally vulnerable web application developed by OWASP. It is used for security training, awareness, demonstrations, and Capture-The-Flag (CTF) style exercises covering the OWASP Top 10 risks.
Prerequisites
- Windows, macOS, or Linux system
- Docker installed and running
- Internet access
- Modern web browser (Chrome / Firefox)

Step 1: Verify Docker Installation
Open a terminal or command prompt and run:

docker --version

If Docker is installed correctly, version information will be displayed.
Step 2: Pull OWASP Juice Shop Docker Image
Run the following command to download the Juice Shop image:

docker pull bkimminich/juice-shop

Step 3: Run OWASP Juice Shop Container
Start the Juice Shop container using:

docker run -d --name juice-shop -p 3000:3000 bkimminich/juice-shop

This command runs the container in the background and exposes it on port 3000.
Step 4: Verify Container is Running
Run the following command:

docker ps

You should see a running container named 'juice-shop'.
Step 5: Access the Application
Open a browser and navigate to:

http://localhost:3000

Step 6: Stop and Start the Container
To stop the container:
docker stop juice-shop

To start it again:
docker start juice-shop

Step 7: Remove the Container (Optional)
To remove the container after use:

docker rm -f juice-shop

Optional: Unsafe Mode for Training
Unsafe mode enables additional vulnerable features:

docker run -d --name juice-shop -p 3000:3000 -e NODE_ENV=unsafe bkimminich/juice-shop

Troubleshooting
- Ensure Docker is running
- Ensure port 3000 is free
- Use docker logs juice-shop for errors

Next Steps
You can now proceed with OWASP Top 10 hands-on exercises using Juice Shop.
