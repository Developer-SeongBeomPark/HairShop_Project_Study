## Server, Web Server 그리고 Web Application Server(WAS)



프로젝트를 복기하던 중, 이것도 서버고 저것도 서버인데 뭐가 뭔지 너무 헷갈린다고 느껴서 다시 공부하려한다.



##### Server

- 내가 만든 프로젝트가 올라가 있는 컴퓨터라고 볼 수 있다.
- ex) AWS EC2, GCP, NCP 등



##### Web Server

- Http 프로토콜을 기반으로 하여 클라이언트의 요청을 서비스하는 기능을 담당한다.

- 정적인 컨텐츠(Static Pages)를 제공한다.
- ex) Apache HTTP, Nginx



##### Web Application Server(WAS)

- 알고리즘, 비즈니스 로직, DB조회 등 클라이언트 요청에 따라 동적인 컨텐츠를 제공한다.
- 동적인 컨텐츠(Dynamic Pages)를 제공한다.
- ex) Apache Tomcat



1.

![img](https://blog.kakaocdn.net/dn/tmkV7/btqUhAga0Wj/iwmIrkS2BqYhiWESjTk5m1/img.png)



2.

![img](https://blog.kakaocdn.net/dn/7hM6j/btqUpaNX83T/ucrd6i34xMdiX38otb1hAK/img.png)



1번 그림처럼 WAS = Web Server + Web Container 로 이해하는 사람도 있고 2번 그림처럼 WAS = Web Server와 APP 간의 미들웨어라고 하는 사람도 있고 WAS = WAS + APP 이라고 해서 한번에 모든 기능을 한다고 하는 사람도 있다. 하지만 대부분의 경우, 1번 그림처럼 설명한다.



###### 그렇다면 Web Container는 무엇인가?

- 웹 서버가 보낸 JSP,PHP,ASP.net 등의 파일들을 실행하고 수행결과(알고리즘, DB 연결 등)를 다시 웹 서버로 보내주는 역할을 한다.





---



#### 의문점1 : 그렇다면 왜 이렇게 세분화 시켜놨는가?

1. 기능을 분리하여 서버가 받는 부하를 나눌 수 있다.

- WAS는 DB 조회, 다양한 로직을 수행하기 바쁘기 때문에 정적 컨텐츠는 Web Server에서 빠르게 클라이언트에 제공하는 것이 좋다.
- 정적 컨텐츠까지 WAS에서 수행하게 되면 동적 컨텐츠 처리까지 지연돼 전체 수행능력이 떨어진다.



2. 여러 대의 WAS를 연결해 로드 밸런싱 용도로 사용할 수 있다.

- Failover, Failback 처리에 유리하다.
- WAS에서 오류가 발생했을 경우, 같은 세팅의 다른 WAS를 사용하게 함으로써 무중단 운영을 할 수 있다.



3. 여러 언어의 웹 애플리케이션 서비스가 가능하다.

- 하나의 서버에서 PHP Application, Java Application을 함께 사용하는 등, 여러 웹 애플리케이션의 활용이 가능하다.







#### 의문점 2 : Web Server와 WAS는 포트가 다른가? 포트는 정확히 뭐지?

웹서버의 기본 포트는 http의 경우 80번 포트를 사용하고 https의 경우 443번 포트를 사용한다.

WAS는 위와 다른 포트를 사용한다. ex) Apahce Tomcat의 경우 기본 포트로 8080포트를 사용한다. 

- ##### 포트는 무엇인가?

  - "논리적인 접속장소"
  - 서버의 IP는 하나인데 제공하는 서비스가 다양하기 때문에 그 서비스를 구분하기 위해서 사용하는 기능
  - 아래의 그림처럼 역할 별 서버들이 포트 각각에 논리적으로 연결되어있다.

  ![img](https://blog.kakaocdn.net/dn/cJBm6U/btq99m8riuW/g967BzlcJkbpW7udKlRogK/img.jpg)







