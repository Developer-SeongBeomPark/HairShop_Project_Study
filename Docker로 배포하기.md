## Docker를 활용한 배포



로컬에서 잘 실행되는 Spring Boot 프로젝트를 Naver Cloud Platform(NCP) 서버에서 실행시켜 보려고 한다.



#### 작업 순서

1. Local에서 Docker에 Container와 Image 만들기
2. DockerHub에 Image push하기
3. 원격 서버에서 Image pull하기<br>





##### Local에서 Docker에 Container와 Image 만들기

---

먼저 프로젝트 내의 설정을 변경해주어야 한다.<br>



- build.gradle 에서 다음과 같은 코드를 추가한다.


![image-20220726144812225](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/8bd762b8-0fb3-48c0-a49c-41e4454ee8a3)



- 프로젝트 바로 아래 Dockerfile을 생성해준다.(이름이 꼭 Dockerfile 이어야 한다.)

![image-20220726145618871](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/b71924b1-1ecc-429c-b011-93ba1a97581e)



- application.properties 설정을 변경해준다.

![image-20220726145523457](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/7bdac1d8-f992-47c9-933f-158c748d573c)

여기서 주의할 점이 ![image-20220726145716727](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/b4cca662-cb2b-4ae9-ad25-7794913471ab)

이 부분이다. "mysql" 은 추후에 생성할 mysql docker image의 이름이다. <br>

또, ```useSSL=false&allowPublicKeyRetrieval=true``` 이 부분이 빠진다면 DB 연결 실패 오류가 발생할 것이다.

<br><br>



이제 war 파일을 만들어 주면 된다.

![image-20220726150213167](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/54e94d54-ae19-4c96-a1a3-8a6efc9e4f21)



war 파일이 잘 만들어졌는지는 다음과 같이 확인하면 된다.

![image-20220726150355227](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/d513098e-40f1-480f-a6bd-5b4584f9a9d9)

위 사진처럼 만들어놓은 Dockerfile의 위치를 변경한다.

<br><br><br>



[Docker 설치](https://www.docker.com/get-started/) --> DockerHub 계정을 생성하고 Docker Desktop을 OS에 맞게 설치한다.<br>

이제 cmd or windows powershell을 이용해 docker image를 만들 것이다.<br>



```cd build/libs``` : 폴더 위치 이동

```docker login``` : docker 계정과 연결한다.

<br>

```docker network create [이름]``` --> ```docker network ls``` ![image-20220726153719449](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/0420171b-ad95-40a8-ad98-b8995ba8d51e)

(내가 만든 network는 "springnetwork")

```docker volume create [이름]``` --> ```docker volume ls``` ![image-20220726153753642](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/6df58955-55c7-4491-b4b4-18d9a137e192)



```docker pull mysql ``` : mysql image 생성

```docker run -d --name [mysql container 별명] -e MYSQL_ROOT_PASSWORD=[root 계정 비밀번호] -p 3306:3306 --network [network id] -v [volume name]:/var/lib/mysql mysql``` : mysql container 생성 및 실행![image-20220726154423831](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/347cee29-1570-4b51-8cc2-ecc0b514b2db)



```docker build -t [war파일 이름] .``` : 프로젝트 image 생성 ![image-20220726154604262](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/14f3d15a-6290-42b3-a05e-bcc0d7ec6dc3)

```docker run -it --name [프로젝트 container 별명] --network [network id] -p 8000:8000 [war파일 이름] bash``` : 프로젝트 container 생성 및 실행 ![image-20220726155134468](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/854917ad-0dce-49e7-9e34-64b22b4e80a3)

<br><br><br>



##### DockerHub에 Image push하기

---



![image-20220726155321916](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/21b8bc47-5a40-4ee5-85a9-d95c15bdb8b9)

DockerHub에 접속해 다음과 같이 두 개의 repository를 create한다.



```docker tag [이미지 별명] [repository 이름]``` : tag를 이용해 DockerHub로 Push하기 위한 연결과정을 실행한다.

```docker push [repository 이름]``` : DockerHub로 Push한다.

![image-20220726155948264](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/8b1ef451-ee82-4ed0-b9ed-c01bc109ffeb)

![image-20220726160019209](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/5b44a503-a258-42f4-8287-b5b8fadf4f3d)

![image-20220726160046092](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/8ce86a71-579f-4eed-9150-9149beeb9bc2)

![image-20220726160059472](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/887f9e8c-9b7f-4817-8e64-d7b51859435f)



![image-20220726160151789](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/6ce8adbf-2bee-470d-ac0f-9b8130d75ec5)

성공적으로 push 됐다면 위 사진처럼 repositories가 보일 것이다.

<br><br><br>



##### 원격 서버에서 Image pull하기

---

![image-20220726160901995](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/4809b71d-d218-42c3-9e65-361402290a31)

putty를 이용해 할당 받은 서버로 원격 접속한다.<br>

Docker를 설치한다.<br>

```
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt install docker-ce
```

[sudo 없이 사용하기](https://subicura.com/2017/01/19/docker-guide-for-beginners-2.html) 해당 링크를 이용하면 sudo를 생략할 수 있다.



```docker login``` : 본인의 계정으로 로그인한다.<br>

```docker pull [DockerHub Respository name]``` : DockerHub에 올려둔 이미지를 pull 받는다.

![image-20220726162429213](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/aac90e8a-689b-4c31-b6e4-1d1eecd6c41c)

![image-20220726162444716](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/81e05448-c7f2-4321-bb30-59e78cdb7881)

<br>

```docker images``` : 받아온 image들의 목록 출력

![image-20220726162543669](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/1c90710b-c8bf-4c73-b8db-709bc5617589)

<br>



```docker network create [network 별명]```<br>

```docker volume create [volume 별명]```<br>

```docker run -d  --name [mysql container 별명] -e MYSQL_ROOT_PASSWORD=[root 계정 비밀번호] -p 3306:3306 --network [network id] -v [volume id]:/var/lib/mysql [mysql repository name]``` : mysql container 생성 및 실행<br>

![image-20220726164603896](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/51a22e55-4843-4a4d-89ee-7dc97ed27120)

<br>

<br>

######  TimeZone 설정 추가

![image-20220811101637215](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/14141292-ef2f-4eec-aea7-d18f7d59307f)

```docker run --name [프로젝트 container 별명] -p 8000:8000 --network [network id] [프로젝트 repository name]``` : 프로젝트 container 생성 및 실행 

![image-20220726164802083](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/1a3550c1-a45a-48b2-bfe4-ef25e593371d)



```docker ps -a``` : 컨테이너 목록 확인

![image-20220726164849989](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/24b335ab-c549-48b6-b07d-a31e2a2a4642)

이와 같이 출력된다면 정상 작동하는 것이다.



![image-20220726164948300](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/f94f49c1-a40a-45e3-8304-b34724c28b12)

##### Putty 내에서 한글 적용

---

putty에서 mysql 접속해 select문으로 데이터를 출력하는 경우 한글이 "?" 로 출력될 수 있다.![image-20220729115112104](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/0c72b634-951e-4f4a-b8c4-0643b1eac0f2)

<br>

이때 ```show variables like 'char%';``` 를 이용해 인코딩 상태를 보면 다음과 같다. ![image-20220729115251432](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/4436d839-65e7-4893-8df7-94d0d6b2d883)

<br>

```set [Variable name] = [value]``` 를 이용해 value 값을 바꿔준다.

![image-20220729115449494](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/f60a4e80-2e41-41a5-acff-24aef2c9dfa8)



결과 :

![image-20220729115603876](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/325b7701-0a3e-4780-9763-89fc1025838e)





###### 로컬 서버에서 외부 서버로 파일 옮기는 법

```scp C:\default.jpg root@49.50.161.233:/root/deploy/designer```
