## HTTP --> HTTPS 변경

- nginx 컨테이너

```docker run -d -p 80:80 -p  443:443  --name nginx --network springnetwork -v /certbot/conf:/etc/letsencrypt -v /certbot/www:/var/www/certbot  nginx```

위 코드로 nginx 컨테이너를 실행한다.

<br>

- certbot으로 ssl 인증서 받기

```docker run -it --rm --name certbot -v /certbot/conf:/etc/letsencrypt -v /certbot/www:/var/www/certbot --network springnetwork certbot/certbot certonly  -d beomhair.shop --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory```<br>

위 코드를 실행하면 다음과 같은 결과를 얻을 수 있다.

![image-20220811102512210](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/94009091-422d-4356-b0d2-4cb8230eab6d)



"slqQSBrs4rToROM7LyEeBVvI92YXi3JJ-RK6S5OBKNc" --> 이 부분을 DNS TXT 레코드에 등록한다.

![image-20220811102818274](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/bf726fef-126e-4f50-9224-a871b5e9f0f6)

TXT 레코드 등록 후 1분 정도 기다렸다가 Enter를 눌러준다.<br>

![image-20220811103020569](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/1c18c39f-bad6-4871-af08-b186d5542db4)

이와 같은 형식의 ssl 인증서를 성공적으로 다운받은 것을 알 수 있다.

``` /etc/letsencrypt/live/{도메인 이름}/fullchain.pem```

```/etc/letsencrypt/live/{도메인 이름}/privkey.pem```

<br><br>





- nginx server 설정 변경

nginx 컨테이너 내부 :

```
docker exec -it nginx bash

apt-get update
apt-get install vim

cd /etc/nginx/conf.d
vim default.conf
```

![image-20220811104028906](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/92be5f28-4918-4b06-b01c-5c51ddf50a73)

ESC + ":wq" + Enter를 통해 변경 내용을 저장한다.

<br>

```docker restart nginx``` 후에 다음과 같은 결과가 나온다.

![image-20220811104224950](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/e551913e-be40-4fac-955a-b01674eea76a)

<br>

결과 : ![image-20220811104333547](https://github.com/Developer-SeongBeomPark/HairShop_Project_Study/assets/63636555/b16391fc-1673-431b-92b1-005006e9acaf)
