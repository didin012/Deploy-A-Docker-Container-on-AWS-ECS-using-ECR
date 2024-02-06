# Deploy-A-Docker-Container-on-AWS-ECS-using-ECR
A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application. It will be deployed in an AWS environment using ECS.

## Infrastructure

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/99ec96f7-ae34-4f2f-88ba-2664482748e6)

I have used to Python Flask to create the dynamic web app for the project. Then created an Docker image for this app and pushed it into the Amazon Elastic Container Repository to create an image inside AWS.
After deploying to ECR we will have to create a cluster on Amazon Elastic Container Service. Inside the clpuster creation, I have selected the container I pushed on the ECR then specify the network settings of the launch type which will be an EC2 instance.
Create a task definition for the container be able to expose the host port then use the public IPv4 of the EC2 instance to be able to access the web app.


## Check if the app will run locally
1. Open a virtualenv by installing<br>
	```$ pip install --user virtualenv```<br>
   Run this on a preferred directory <br>
	```$ python -m virtualenv venv``` <br>
3. Run virtualenv<br>
	```$ source ./Scripts/activate```
## Note: If you wanna run python in gitbash
  ```echo "alias python='winpty python.exe'" >> ~/.bashrc```<br>
3. run the app<br>
   	 ```$ python catapp.py```

## To run using Docker: Create an image for your Docker
1. Install docker first
2. Build image using git, should be inside the directory where Dockerfile located.<br>
    	```$ docker image build -t catapp .```
3. list images <br>
    	```$ docker image ls``` 
4. Run (The image should be running before proceeding to the problem encountered part) <br>
    	```$ docker run -p 8888:5000 -d catapp```
5. when it is time to stop <br>
    	```$ docker stop <id>```
6. Prune, for stopped containers <br>
    	```$ docker system prune```
   
## Common problem you may encounter: You can’t use Push commands from ECR because of CLI authentication
To solve:
1.	Open your AWS CLI then login <br>
```aws configure```<br>
```AWS Access Key ID []:{PUT UR CREDS}```<br>
```AWS Secret Access Key []:{PUT UR CREDS}```<br>
```Default Region name []: <put-your-preferred-region>```<br>
```Default output format []: json``` 
2.	To authenticate make sure you have MFA in your IAM User, You will need a smartphone for authentication since you should find the codes in the phone (download Google Authenticator)

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/13241ad9-5e1e-4fce-bd7f-4540c90a1a27)

3.	To generate an AccessKey, SecretKey and SessionToken enter this command below<br>
```aws sts get-session-token --serial-number <arn-of-the-mfa-device> --token-code <code-generated-by-MFA-device>```
4.	Copy all contents in a notepad and make sure to remember where it is stored.
5.	Run AWS Configure again and login using the given AccessKey and SecretKey
6.	Run this command below then copy the session token in the end<br>
```aws configure set aws_session_token <SESSIONTOKEN>```
7.	You should be able to login in an ECR push commands from now on.

## Amazon Elastic Container Registry
1.	**Create a Repository**, obviously my name is already in use since I have already made the repo.

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/d5d37de9-b590-4725-8918-28aa30398c06)

2.	Then click for **View push commands** then copy the login then paste it on the CLI

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/fbd3ed3b-8933-4a64-9324-aa46f6cafb75)

3.	Run this command to put a tag in your repo in the command on #3 just like in the picture 
4.	Run the docker push command on #4 in the picture
5.	Copy the URI of your image in ECR.

## Amazon Elastic Container Service

1.	**Create a Cluster**
2.	Inside the creation copy the specified settings set here (name your own cluster of course)

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/39f46e6b-c0b2-4f47-bab7-0131b6a3fc54)
![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/b0c40339-e507-4a63-ae33-9f146d812d24)
![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/6dfc58d8-2530-45e9-b488-9528d096b078)

3.	Proceed to **Create Cluster**, you should see something like this after creation

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/58f121f0-94b8-4b27-ba29-106e00478e8c)

Checking up CloudFormation

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/2df3652f-834c-4e72-91a4-7969c980b575)

Checking running EC2 instance

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/d8cc1e4a-ab39-4c2e-8b00-0357a055d1c7)

4.	Click on task definitions on the left panel of the site then **Create Task Definitions**

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/e7827c61-04ab-463a-9c2d-c703efb3db49)

5.	Copy all the contents below except for the name and the **URI** of the container (you have your own URI on ECR)

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/e5f0efd1-7e66-4310-a0fc-f42f89331ef1)
![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/0b94c6c2-9076-4991-b755-99770174b591)
![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/a140ca6f-4df5-46a0-86de-0b01656bf738)

6.	Open up the cluster you created then run a task

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/187d0079-5940-495f-9396-49440fd49507)

7.	Follow along with these settings

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/e6bce0d1-8d7f-4d69-90b3-786a012ea98f)
![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/11eb8279-85ff-44a9-bc61-c9db3f05e6d2)

8.	**Open up the EC2 instance** created by the cluster then go to its **security group**

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/c0b0ba8d-177e-45af-b985-b0d84cba6d53)

9.	**Edit the Inbound Rules** add for the port 5000 on IPv4 and IPv6 then **Save changes**

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/ebb33fcb-7504-4326-a4ff-c84a2daaa413)

10.	Make sure you have selected the right task definition **revision number**

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/84d1afc8-85b3-4421-a841-d2d0a1ee58d0)
![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/7dd7a628-d474-4511-9e1e-699cbdc951d8)

11.	Then run your app using the Public URL of the EC2 instance followed by :8888 at the end

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/d4755adc-5567-48c5-94e2-2d5b391bfcfd)

12.	You have successfully imported your Docker image into ECS-EC2 instance

![image](https://github.com/didin012/Deploy-A-Docker-Container-on-AWS-ECS-using-ECR/assets/104528282/2df302ef-ac0e-4a8e-b5fd-a1eeb93bb3d8)


