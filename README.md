# DevOps CI/CD Pipeline with Jenkins, GitHub, Maven, SonarQube, Nexus, Docker, Kubernetes, and Email Notifications

This repository demonstrates the setup and configuration of a full DevOps CI/CD pipeline utilizing various tools including Jenkins, GitHub, Maven, SonarQube, Nexus, Docker, Kubernetes, and email notifications for job success or failure.

## Architecture Overview
![Pipeline Architecture](https://github.com/user-attachments/assets/4a9f9705-4be8-4520-b636-717ca6bc0af3)

## Note

All the necessary code for setting up Jenkins and Kubernetes, including configuration files and scripts, are provided in this repository. Please check the relevant folders for detailed setup instructions.

This code was sourced from publicly available repositories on GitHub for use in this DevOps project. Unfortunately, the exact source and user from whom it was taken are unknown. If you recognize the code, please feel free to reach out so I can properly credit the original author.

Thank you.


## Credentials
The following credentials are needed throughout the setup and integration process:

### Jenkins Credentials
![Jenkins Credentials](https://github.com/user-attachments/assets/4b67ed35-9dbb-41ff-975a-002794ee7949)

### Kubernetes Token for Jenkins
The Kubernetes token generated for the `jenkins` service account in Kubernetes is required for Jenkins to communicate with the Kubernetes cluster:
![Jenkins Kubernetes Token](https://github.com/user-attachments/assets/0d240faf-9bd5-47d8-95cd-92279d8131df)

## Setting Up SonarQube and Nexus with Docker
We use Docker to set up both SonarQube and Nexus. The following images show the configuration and interfaces.

### SonarQube and Nexus ran using docker at specified port
![SonarQube Docker Setup](https://github.com/user-attachments/assets/5de82e63-b843-461b-85ef-f5411827b843)

### SonarQube Web Interface
![SonarQube Webpage](https://github.com/user-attachments/assets/dbbb349c-3642-4879-83a8-4c6674d5d07b)

### SonarQube Token
A SonarQube token is required for Jenkins to access SonarQube and perform scans. This token has been added to Jenkins' credentials:
![SonarQube Token](https://github.com/user-attachments/assets/e4045b73-c110-4ee8-bf46-c3d319f4a7d4)

### Nexus Setup
Here are the screenshots for configuring Nexus as a repository manager for your Maven builds:
![Nexus Setup 1](https://github.com/user-attachments/assets/b0deee29-96a5-4e38-9360-25e2127894fc)
![Nexus Setup 2](https://github.com/user-attachments/assets/995d629a-e6fe-4ee8-ac17-2afd45ae2f74)

## Jenkins Configuration for Nexus Access
Create a managed file in Jenkins to allow Maven to access Nexus. The code for the managed file will be provided in the repository.
![Managed File for Maven 1](https://github.com/user-attachments/assets/2d6e37af-7bfa-4649-adfd-d70332c2a026)
![Managed File for Maven 2](https://github.com/user-attachments/assets/996dd2b2-167f-4af2-a57e-a52372ba7330)
![Managed File for Maven 3](https://github.com/user-attachments/assets/46f9f6eb-1814-4bea-9155-812a969efed2)
![Managed File for Maven 4](https://github.com/user-attachments/assets/b6543e77-00fe-4718-ab54-b2a8bc2e2b4e)

## Kubernetes Setup

### Create Kubernetes Resources
To enable Jenkins to authenticate with Kubernetes, apply the following YAML files:
1. Create the `webapps` namespace.
2. Create the `jenkins` service account.
3. Assign roles and role bindings for Jenkins.
4. Create a secret to generate a token that will authenticate Jenkins with Kubernetes.

The Kubernetes role, service account, and role binding will look like the following:
![Kubernetes Role and Service Account](https://github.com/user-attachments/assets/bd5d88c2-7e6c-4d6e-808f-52ec3d91d627)

```bash
## Important Notes
[token4.yml]
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: mysecretname
  namespace: webapps
  annotations:
    kubernetes.io/service-account.name: jenkins #jenkins 

apiVersion: Specifies the API version of the Kubernetes resource. In this case, it is set to v1.

kind: Indicates the type of resource being defined. Here, it is a Secret.

type: This specifies the type of secret. For service accounts, it is typically kubernetes.io/service-account-token, which is used to store a token that allows accessing the Kubernetes API.

metadata: Contains metadata about the secret:

name: The name of the secret, here it is mysecretname.
namespace: The Kubernetes namespace where the secret is created, which is webapps in this case.
annotations: Additional metadata that is key-value pairs. Here, it includes:
kubernetes.io/service-account.name: The name of the service account associated with this token, specified as jenkins.

```
In Kubernetes, a Service Account is an account for processes running in a Pod. By annotating this secret with the service account name jenkins, it indicates that this token is generated for the Jenkins service account. Jenkins, often used for continuous integration and continuous deployment (CI/CD), may require access to the Kubernetes API to manage deployments, pods, or other Kubernetes resources as part of its automation processes. The token stored in this secret would be used to authenticate Jenkins to the Kubernetes cluster.

### Verify Kubernetes Setup
You can verify the role and service account creation by running:<br>
$ kubectl get role -n webapps <br>
$ kubectl get sa -n webapps
![kubectl get role sa](https://github.com/user-attachments/assets/1e833fe6-c145-450a-b8df-09b882c5cbee)

## Jenkins Job Execution

After several trials and errors, the Jenkins job ran successfully. Below are the screenshots showing the process:

### Job Execution Trials
Here’s a look at the trial-and-error process as the job was executed:

![Trial and Error 1](https://github.com/user-attachments/assets/e439bd74-062f-4877-b425-68d4b26e4b31)
![Trial and Error 2](https://github.com/user-attachments/assets/a11efce5-dee7-4714-bc52-7160a4bc82f0)

### Successful Docker Image Build and Upload
The Docker image was successfully built and uploaded to Docker Hub:

![Docker Hub Upload](https://github.com/user-attachments/assets/fad08469-1d21-4897-9fb9-a1631acbbd63)

### SonarQube Scanner Execution
The SonarQube scanner ran successfully and performed the code analysis:

![SonarQube Scanner](https://github.com/user-attachments/assets/8f44a18d-c811-428c-a0c6-53eaa3f30d1f)

### Nexus Repository Integration
The artifact was successfully uploaded and received by the Nexus repository:

![Nexus Repository](https://github.com/user-attachments/assets/51dd43cd-3337-4281-835e-c243db167a42)

## Email Notifications

After each job execution, email notifications are sent out to notify the team about the result of the job (success or failure). Below are the screenshots showing the email notifications:

### Success Email Notification
![Success Email](https://github.com/user-attachments/assets/6b43a07d-9fb6-48e4-a832-485ea56b2531)

### Failure Email Notification
![Failure Email](https://github.com/user-attachments/assets/f3199891-43ec-4a98-80dd-874d26266ee5)

### General Gmail Notification
![Gmail Notification](https://github.com/user-attachments/assets/e1e0642d-0792-4a98-b8da-0210c9335acb)

## Webpage Deployment

The webpage was successfully deployed and is now live. Since I’m using a Kind cluster, port forwarding was set up to access the webpage.

### Kubernetes Resources and Port Forwarding
Here are the Kubernetes resources (pod, deployment, and service) along with the port forwarding:

![Kubernetes Resources and Port Forwarding](https://github.com/user-attachments/assets/2a0c5787-6069-4ab0-9401-ceb3b97f0a68)

### Webpage Home
Finally, the homepage of the application was successfully loaded and is accessible:

![Webpage Home](https://github.com/user-attachments/assets/2b6da549-5b1f-4fab-b1ae-4fbc4dc5bccb)




# BoardgameListingWebApp

## Description

**Board Game Database Full-Stack Web Application.**
This web application displays lists of board games and their reviews. While anyone can view the board game lists and reviews, they are required to log in to add/ edit the board games and their reviews. The 'users' have the authority to add board games to the list and add reviews, and the 'managers' have the authority to edit/ delete the reviews on top of the authorities of users.  

## Technologies

- Java
- Spring Boot
- Amazon Web Services(AWS) EC2
- Thymeleaf
- Thymeleaf Fragments
- HTML5
- CSS
- JavaScript
- Spring MVC
- JDBC
- H2 Database Engine (In-memory)
- JUnit test framework
- Spring Security
- Twitter Bootstrap
- Maven

## Features

- Full-Stack Application
- UI components created with Thymeleaf and styled with Twitter Bootstrap
- Authentication and authorization using Spring Security
  - Authentication by allowing the users to authenticate with a username and password
  - Authorization by granting different permissions based on the roles (non-members, users, and managers)
- Different roles (non-members, users, and managers) with varying levels of permissions
  - Non-members only can see the boardgame lists and reviews
  - Users can add board games and write reviews
  - Managers can edit and delete the reviews
- Deployed the application on AWS EC2
- JUnit test framework for unit testing
- Spring MVC best practices to segregate views, controllers, and database packages
- JDBC for database connectivity and interaction
- CRUD (Create, Read, Update, Delete) operations for managing data in the database
- Schema.sql file to customize the schema and input initial data
- Thymeleaf Fragments to reduce redundancy of repeating HTML elements (head, footer, navigation)

## How to Run

1. Clone the repository
2. Open the project in your IDE of choice
3. Run the application
4. To use initial user data, use the following credentials.
  - username: bugs    |     password: bunny (user role)
  - username: daffy   |     password: duck  (manager role)
5. You can also sign-up as a new user and customize your role to play with the application! 😊
