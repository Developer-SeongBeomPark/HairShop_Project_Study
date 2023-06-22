use beom;

select * from user;
delete from certification;

CREATE TABLE category (
       cateno               int NOT NULL		  auto_increment,
       catename             varchar(20) NOT NULL,
       PRIMARY KEY (cateno)
);

insert into category(catename) value('컷');
insert into category(catename) value('펌');
insert into category(catename) value('클리닉');
select * from category;

CREATE TABLE designer (
       did                  varchar(50) NOT NULL, 
       dpw                  varchar(10) NOT NULL, 
       dname                varchar(20) NOT NULL, 
       birth                varchar(6) NOT NULL, 
       demail               varchar(50) NOT NULL, 
       dphone               varchar(20) NOT NULL, 
       hairshop				 varchar(20) NOT NULL, 
       address1             varchar(60) NOT NULL, 
       address2             varchar(60) NOT NULL, 
       dzipcode             varchar(20) NOT NULL, 
       validation           boolean  DEFAULT  false  NULL 
                                   CHECK  (validation IN (false, true)),
       likecnt              int DEFAULT 0 NULL,
       dfilename            varchar(60) default 'default.jpg',
	   introduction			 varchar(200) null,
       PRIMARY KEY (did),
       UNIQUE (
              demail
       )
);
alter table designer add hairshop varchar(20) not null;
alter table designer modify column dfilename varchar(60) default 'default.jpg';


select did, dname, validation
		from designer
		where did = 'test';

insert into designer values('test', '1234', '910709', 'user1@gmail.com', '010-1234-5678', '서울시 종로구', '대왕빌딩 602호', '152342', true, 0 , 'default.jpg', '홍길동');
insert into designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode,dfilename,validation,introduction) 
values('test','1234','김길동','930709','user2@gmail.com','010-1414-1414','서울시 종로구','대왕빌딩 601호','123412','designer.jpg',
false,'미용사(일반) 자격증 보유 -레이어드컷 / 단발 레이어드컷 / 태슬컷 -레이어드컷 / 단발 레이어드컷 / 태슬컷');

select * from designer;
update designer
	set validation = true
	where did = 'test';
delete from designer;





use beom;
select * from designer;

CREATE TABLE hairmenu (
       menuno               int NOT NULL auto_increment,
       price                int NOT NULL,
       menu                 varchar(20) NOT NULL,
       did                  varchar(50) NOT NULL,
       cateno               int NOT NULL,
       hgender              varchar(10) not null CHECK(hgender IN('FEMALE','MALE')),
       PRIMARY KEY (menuno), 
       FOREIGN KEY (cateno)  REFERENCES category(cateno), 
       FOREIGN KEY (did) REFERENCES designer(did) on delete cascade
);

select * from review;

use beom;
delete from hairmenu where menuno = 4;
insert into hairmenu(did,price,menu,cateno,hgender) values('test','40000','두피스케일링커트',1,'남자');
insert into hairmenu(did,price,menu,cateno,hgender) values('test','20000','일반펌',2,'여자');

insert into hairmenu(did,price,menu,cateno) values('designer1','50000','남성 펌',2);
insert into hairmenu(did,price,menu,cateno) values('designer1','30000','여성 디자인컷',1);
insert into hairmenu(did,price,menu,cateno) values('designer1','10000','여성 펌',2);

select * from enroll;


CREATE TABLE enroll (
       enrollno             int NOT NULL	 auto_increment,
       enrolldate           varchar(20) NOT NULL,
       enrolltime           varchar(20) NOT NULL,
       eprice				  int not null,
       emenu				  varchar(20) not null,
       menuno               int NOT NULL,
       did                  varchar(50) NOT NULL,
       PRIMARY KEY (enrollno), 
       FOREIGN KEY (menuno)
                             REFERENCES hairmenu(menuno), 
       FOREIGN KEY (did)
                             REFERENCES designer(did) on delete cascade
);

drop table enroll;

insert into enroll(did,menuno,enrolldate,enrolltime,eprice,emenu) values('test','2','2022-07-17','14:34','20000','디자인컷');
insert into enroll(did,menuno,enrolldate,enrolltime,eprice,emenu) values('test','5','2022-07-17','14:34','40000','두피스케일링커트');
insert into enroll(did,menuno,enrolldate,enrolltime) values('test','3','2022-07-15','10:20');



select * from enroll;


CREATE TABLE user (
       uid                  varchar(20) NOT NULL,
       upw                  varchar(20) NOT NULL,
       uemail               varchar(50) NOT NULL,
       uname                varchar(20) NOT NULL,
       uphone               varchar(20) NOT NULL,
       grade                varchar(5) DEFAULT 'C' NOT NULL
                                   CHECK (grade IN ('A', 'C')),
       PRIMARY KEY (uid),
       UNIQUE (
              uemail
       )
);
-- alter table user add UNIQUE (
--               uemail
--        );

insert into user(uid,upw,uemail,uname,uphone) values('user1','1234','test@mail.com','박길동','010-4141-2312');
insert into user(uid,upw,uemail,uname,uphone) values('user2','1234','test2@mail.com','고길동','010-5141-2312');
insert into user(uid,upw,uemail,uname,uphone) values('admin','1234','admin@mail.com','관리자','010-6134-9361');

use dbtest;
delete from user
	where uid = 'user1';

select * from user;


CREATE TABLE reserve (
       reserveno            int NOT NULL	 auto_increment,
       uid                  varchar(20) NOT NULL,
       message              varCHAR(100) NULL,
       enrollno             int NOT NULL,
       rconfig				 boolean default false check(rconfig in (false, true)),
       PRIMARY KEY (reserveno), 
       FOREIGN KEY (enrollno)
                             REFERENCES enroll(enrollno), 
       FOREIGN KEY (uid)
                             REFERENCES user(uid) on delete cascade
);

alter table reserve add rconfig boolean DEFAULT false
                                   CHECK (rconfig IN (false, true));
delete from reserve;

insert into reserve(enrollno, uid, message) values(2,'user1','안녕하세요');
insert into reserve(enrollno, uid, message) values(1,'user2','안녕하세요 반갑습니다');
insert into reserve(enrollno, uid, message) values(1,'user1','안녕하세요 ㅎㅇㅎㅇ');

delete from reserve where uid = 'user1';
select * from reserve;


CREATE TABLE certification (
       did                  varchar(50) NOT NULL,
       licenseno            varchar(50) NULL,
       licensedate          varchar(20) NULL,
       uniquecode1          varchar(50) NULL,
       uniquecode2          varchar(50) NULL,
       PRIMARY KEY (did), 
       FOREIGN KEY (did)
                             REFERENCES designer(did) on delete cascade
);

drop table certification;

insert into certification(did, licenseno, licensedate,uniquecode1) values('test','12345678901A','20050101','0901234567');
insert into certification(did, uniquecode2) values('test1','0909873165');

use dbtest;
select * from certification;


CREATE TABLE style (
imageno int NOT NULL AUTO_INCREMENT, -- 정렬할때 사용
imagetype VARCHAR(30) NOT NULL,      -- 이미지 타입
imagecode LONGBLOB NOT NULL,         -- 이미지 바이너리 코드저장 
did VARCHAR(50) NOT NULL,            -- 업로드한 디자이너 구분
gender VARCHAR(10) DEFAULT 'FEMALE' NOT NULL      -- 사진정렬시 여자 남자로 구분
    CHECK(gender IN('FEMALE','MALE')),
PRIMARY KEY (imageno),
FOREIGN KEY (did) REFERENCES designer(did) on delete cascade
);


insert into style(sfilename,did,gender,imgtype) values('style1.jpg','designer1','male','akdf812u91212o83');
insert into style(sfilename,did,gender,imgtype) values('style2.jpg','designer1','female','akdf812u91212o83');
insert into style(sfilename,did,gender,imgtype) values('style3.jpg','designer1','male','akdfqkwj1234t983');
use beom;
select * from style;


CREATE TABLE review (
       rno                  int NOT NULL	 auto_increment,
       rtitle               varchar(20) NOT NULL,
       rcontent             varchar(200) NOT NULL,
       rdate                varchar(20) NOT NULL,
       star                 int DEFAULT 5 not NULL,
       rfilename            varchar(50) NULL,
       uid                  varchar(20) NOT NULL,
       did                  varchar(50) NOT NULL,
       PRIMARY KEY (rno), 
       FOREIGN KEY (did)
                             REFERENCES designer(did) on delete cascade, 
       FOREIGN KEY (uid)
                             REFERENCES user(uid) on delete cascade
);
alter table review modify rcontent varchar(200);
drop table review;
insert into review(rtitle,rcontent,rdate,rfilename,uid,did) values('최고에요!','맘에 들어요~',sysdate(),'photo1.jpg','user1','test');
insert into review(rtitle,rcontent,rdate,rfilename,uid,did) values('최고에요!','맘에 들어요~',sysdate(),'photo5.jpg','user1','test');
insert into review(rtitle,rcontent,rdate,rfilename,uid,did) values('최고에요!','맘에 들어요~',sysdate(),'photo3.jpg','user2','designer1');

delete from review where uid = 'user1';
select * from review;


CREATE TABLE notice ( #공지사항
       noticeno             int NOT NULL auto_increment, -- 공지번호
       uid                  varchar(20) NOT NULL, -- 작성자아이디
       ntitle               varchar(30) NOT NULL, -- 제목
       viewcnt              int DEFAULT 0 NULL, -- 조회수
       ndate                varchar(20) NOT NULL, -- 작성날짜
       ncontent             text NOT NULL, -- 내용
       PRIMARY KEY (noticeno), 
       FOREIGN KEY (uid) REFERENCES user(uid) on delete cascade
);

CREATE TABLE heart (     #하트테이블
       heartno               int NOT NULL auto_increment, -- 분류번호
       uid                  varchar(20) NOT NULL, -- 분류명
    did                  varchar(50) NOT NULL,
    heart_chk                int default 0,

     FOREIGN KEY (uid) REFERENCES user(uid) on delete cascade, 
       FOREIGN KEY (did) REFERENCES designer(did) on delete cascade,
       PRIMARY KEY (heartno)
);

insert into notice(uid,ntitle,ndate,ncontent) values('admin','공지사항입니다',sysdate(),'공지사항 내용입니다.');

select * from heart;
select * from designer;

delete from heart where did = 'test2';

update designer set likecnt = 0 where did = 'test';
update heart set heart_chk = 0 where heartno = 1;
use beom;

select * from designer;

-- 예약 등록 시간 list
    
select  e.enrolldate, e.enrolltime, e.emenu, h.hgender ,e.eprice
	from  hairmenu h
    left join enroll e
    on e.menuno = h.menuno
    where e.did = 'test';
    
    
use beom;
select u.uname, h.hgender, e.enrolldate, e.enrolltime, e.emenu, e.eprice, r.message, r.rconfig
 from reserve r
 left join user u
 on r.uid = u.uid	
 left join enroll e
 on r.enrollno = e.enrollno
 left join hairmenu h
 on h.menuno = e.menuno
 where e.did = 'test';
 
use beom;
select * from reserve;


select * from designer;

select * from user;
insert into user values('admin', '1234', 'admin@mail.com', '관리자', '010-1111-1111','A');

delete from user
	where uname = '관리자';
    

select * from review;

select menuno
	from hairmenu
    where did = 'test' and menu = '일반 컷';
    
use beom;

select * from designer;

select u.uid, u.uname, u.uemail, e.enrolldate, e.enrolltime, e.emenu, e.eprice
from reserve r
left join user u
on r.uid = u.uid
left join enroll e
on r.enrollno = e.enrollno
where reserveno = 4;


delete from reserve;

update reserve
set rconfig = 0;

use beom;
drop table notice;

select * from certification;




    
    
    


