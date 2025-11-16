# webapp
Automated CI/CD Pipeline for a Containerized Web Application on AWS

This simple Node.js webapp demonstrates a CI/CD flow: GitHub → Jenkins → Docker → ECR → Ansible → EC2.

## Run locally
1. `npm install`
2. `node server.js`
3. Open http://localhost:3000 or the port you set.

## Docker
Build: `docker build -t webapp-repo .`
Run: `docker run -p 80:80 webapp-repo`
