drop table member cascade constraints;
drop table member_detail cascade constraints;
drop table nonmember cascade constraints;
drop table product cascade constraints;
drop table product_image cascade constraints;
drop table product_detail cascade constraints;
drop table order_info cascade constraints;
drop table cart cascade constraints;
drop table review cascade constraints;
drop table review_image cascade constraints;
drop table review_reply;
drop table refund;
drop table q_notice;

DROP SEQUENCE SEQ_MEMBER_ID;
DROP SEQUENCE SEQ_NONMEMBER_ID;
DROP SEQUENCE SEQ_PRODUCT_ID;
DROP SEQUENCE SEQ_PRODUCT_DETAIL_ID;
DROP SEQUENCE SEQ_PRODUCT_IMAGE_ID;
DROP SEQUENCE SEQ_ORDER_ID;
DROP SEQUENCE REVIEW_SEQ;
DROP SEQUENCE REVIEW_IMAGE_SEQ;
DROP SEQUENCE SEQ_REVIEW_REPLY;
DROP SEQUENCE SEQ_REFUND_ID;
DROP SEQUENCE SEQ_NOTICE_QNA_ADMIN_ID;
DROP SEQUENCE QNOTICE_SEQ;

CREATE SEQUENCE SEQ_MEMBER_ID START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE; 
CREATE SEQUENCE SEQ_NONMEMBER_ID START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE SEQ_PRODUCT_ID START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE SEQ_PRODUCT_DETAIL_ID START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE SEQ_PRODUCT_IMAGE_ID START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE SEQ_ORDER_ID START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE REVIEW_SEQ START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE REVIEW_IMAGE_SEQ START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE SEQ_REVIEW_REPLY START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE SEQ_REFUND_ID START WITH 0 INCREMENT BY 1 MAXVALUE 10000 MINVALUE 0 NOCYCLE;
CREATE SEQUENCE SEQ_NOTICE_QNA_ADMIN_ID START WITH 9000 INCREMENT BY 1 MINVALUE 9000 NOCYCLE;
create SEQUENCE qnotice_seq start with 1 increment by 1 maxvalue 10000 minvalue 0 nocycle;

----------------------------------------------------------------------------


create table member(
member_code number(10) primary key,
member_id   varchar2(30) not null,
member_pwd   varchar2(100) not null,
member_pwd_lock   varchar2(100) not null,
member_pwd_q   varchar2(60) null,
member_pwd_a   varchar2(60) null,
member_name   varchar2(15) not null,
member_gender   varchar2(10) not null,
member_cp1   varchar2(6) not null,
member_cp2   varchar2(8) not null,
member_cp3   varchar2(8) not null,
member_hp1   varchar2(6) ,
member_hp2   varchar2(8) ,
member_hp3   varchar2(8) ,
member_cp_yn   varchar2(2) not null,
member_email1   varchar2(20) not null,
member_email2   varchar2(20) not null,
member_email_yn   varchar2(2) not null,
member_addr1   varchar2(10) not null,
member_addr2   varchar2(50) not null,
member_addr3   varchar2(150) not null,
member_addr4   varchar2(400) not null,
member_birth_y   varchar2(8) not null,
member_birth_m   varchar2(4) not null,
member_birth_d   varchar2(4) not null,
member_birth_SL   varchar2(4) not null,
member_cre_date   date DEFAULT sysdate,
member_point   number(10) not null,
member_rank   varchar2(10) not null,
member_lately_date date DEFAULT sysdate,
member_total_login number(20) default 0,
member_total_buy number(38)default 0 ,
member_total_order number(30) default 0,
member_saving number(20)
); 

--비회원정보테이블
create table nonmember(
nonmember_code  number(10) primary key,
nonmember_id  varchar2(30) not null,
nonmember_pwd  varchar2(100) not null,
nonmember_pwd_lock  varchar2(100) not null,
nonmember_hp1  varchar2(6) ,
nonmember_hp2  varchar2(8) ,
nonmember_hp3  varchar2(8) ,
nonmember_cp1  varchar2(6) not null,
nonmember_cp2  varchar2(8) not null,
nonmember_cp3  varchar2(8) not null,
nonmember_addr1  varchar2(10) not null,
nonmember_addr2  varchar2(50) not null,
nonmember_addr3  varchar2(150) not null,
nonmember_addr4  varchar2(400) not null);

--멤버디테일
create table member_detail (
member_code number(10) ,
discount_per number(10),
discount_won number(10),
cpon_name varchar2(30),
cpon_cre_date date default sysdate,
cpon_del_date date default to_date(to_char(sysdate),'YY-MM-DD')+30,
constraint fk_member_code2 foreign key(member_code) references member(member_code) on delete cascade);

--상품정보테이블
create table product(
pro_code    number(20) primary key,
pro_name    varchar2(50) not null,
pro_price   number(10) not null,
pro_sale    number(5) ,
pro_salesrate    number(20) default 0 null,
pro_status   varchar2(20) not null,
pro_count    number(20) default 0 null,
pro_country varchar2(20) null,
pro_category    varchar2(20) not null,
pro_input_date    date default sysdate,
pro_content    varchar2(3000) not null,
pro_grade    number(20) default 0 null,
pro_material    varchar2(50) not null,
pro_prec    varchar2(1000) );

--상품정보디테일 테이블
create table product_detail(
pro_detail_code number(20) primary key,
pro_size varchar2(20),
pro_color varchar2(20),
pro_quantity number(10),
pro_category_detail  varchar2(40) not null, 
pro_restocked_date date null,
pro_restocked_yn char(1) default 0,
pro_code number(20) not null,
constraint fk_pro_code2 foreign key(pro_code) references product(pro_code) on delete cascade
);

--상품이미지테이블
create table product_image(
 pro_image_code number(20) not null primary key,
 pro_imageFileName varchar2(50),
 pro_imageFileType varchar2(20),
 pro_register varchar2(20),
 pro_image_cre_date date default sysdate,
 pro_code number(20) not null,
 constraint fk_pro_code foreign key(pro_code) references product(pro_code) on delete cascade
);

--주문테이블

create table order_info(
 order_code number(20) not null , --확인
 order_member_id varchar2(20) not null,--확인
 order_member_name varchar2(20) null,--확인
 order_pro_quantity number(20) not null, --확인
 order_price number(30) not null, --확인
 order_discount number(20) null, --확인
 receiver varchar2(20) not null, --확인
 receiver_hp1 varchar2(10) not null,--확인
 receiver_hp2 varchar2(10) not null,--확인
 receiver_hp3 varchar2(10) not null,--확인
 receiver_tel1 varchar2(10)  null,--확인
 receiver_tel2 varchar2(10)  null,--확인
 receiver_tel3 varchar2(10)  null,--확인
 delivery_addr1   varchar2(10) not null,--확인
 delivery_addr2   varchar2(50) not null,--확인
 delivery_addr3   varchar2(150) not null,  --확인
 delivery_addr4   varchar2(400) not null,--확인
 delivery_how varchar2(50) not null,--확인
 delivery_status varchar2(50) not null,--확인
 request_to_delivery varchar2(150) not null,--
 how_pay varchar2(50)  null,--확인
 who_pay varchar2(20)  null,--확인
 which_bank varchar(30)  null,--확인
 company_name_of_card varchar2(50) null,--확인
 card_split varchar2(20) null,  --확인
 date_pay date default sysdate, --확인
 order_pro_detail_code number(20) not null,
 order_member_code number(20) null, --확인
 order_nonmember_code number(20) null, --확인
 constraints fk_order_pro_detail_code foreign key (order_pro_detail_code) references product_detail(pro_detail_code) on delete cascade,
 constraints fk_order_member_code foreign key(order_member_code) references member(member_code)  on delete cascade,
 constraints fk_order_nonmember_code foreign key(order_nonmember_code) references nonmember(nonmember_code)  on delete cascade
);

--장바구니 테이블
create table cart(
cart_pro_code number(20),
cart_pro_detail_code number (20),
cart_member_code number(20),
cart_nonmember_code number(20),
cart_pro_quantity number(10),
cart_pro_color varchar2(20),
cart_pro_size varchar2(15),
cart_pro_price number(10),
constraints fk_cart_pro_code foreign key (cart_pro_code) references product(pro_code) on delete cascade,
constraints fk_cart_pro_detail_code foreign key (cart_pro_detail_code) references product_detail(pro_detail_code) on delete cascade,
constraints fk_cart_member_code foreign key (cart_member_code) references member(member_code) on delete cascade,
constraints fk_cart_nonmember_code foreign key (cart_nonmember_code) references nonmember(nonmember_code) on delete cascade
);


--qna 테이블
create table q_notice(
q_index number(4),
q_title varchar2(50) not null,
q_option varchar2(35),
member_id varchar2(50),
q_content varchar2(4000),
q_file varchar2(1000),
q_hit number(4) default 0,
q_date date DEFAULT sysdate,
q_group number(4),
q_step number(4),
q_indent number(4),
q_admin number(1)
);

--Review 테이블
create table review(
pro_code number(20), 
review_num number(5) primary key,
pro_name varchar2(50), 
member_id varchar2(30) not null,
review_title varchar(100) not null, 
review_content varchar(1000) not null, 
review_date Date default sysdate,
review_hit number(5) default 0,
review_replyCount NUMBER(4), 
review_star number(1) not null,
constraints fk_cart_pro_code3 foreign key (pro_code) references product(pro_code) on delete cascade
); 


--Review image테이블
create table review_image (
pro_code number(20), --foreign key
review_num number(20), --foreign key
review_image_code number(20),
review_imageFileName varchar2(50),
review_image_cre_date date default sysdate,
constraints fk_pro_code4 foreign key(pro_code) references product(pro_code) on delete cascade,
constraints fk_review_num foreign key(review_num) references review(review_num) on delete cascade
);

--리뷰 댓글 테이블
create table review_reply(
review_num number(20),
member_id varchar2(30),
review_reply_code number(20),
review_replyContent varchar2(1000) not null,
review_replyDate date default sysdate
);


--반품테이블
create table refund(
refund_code number(20) primary key,
refund_name varchar2(20),
refund_reason varchar(500) null,
refund_accept_YN varchar(20) default 'n',
refund_accept_date date default sysdate,
refund_date date default sysdate,
how_refund varchar2(50),
pro_detail_code number(20) not null,
order_code number(20) not null,
constraints fk_pro_detail_code foreign key(pro_detail_code) references product_detail(pro_detail_code) on delete cascade
);






insert into member values(seq_member_id.nextval,'dkxlffps','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C','예전에 살던 동네는?','왕십리','김지훈','남자','02','2245','1237','010','3684','0768','N','dkxlffps','naver.com','Y','01449','노해로','(도봉구)','한양아파트 6동 408호','1996','9','16','양력','16/3/13','25500','이사',sysdate,10,500000,1,0); 
insert into member values(seq_member_id.nextval,'aaooj','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C','요새 재밌는 일은?','샤코','강동현','남자','02','4132','1237','010','6475','0704','Y','rkdehdgus','daum.net','Y','40558','강남로 92','(도봉구)','아침빌라 802호','1988','6','12','양력','19/10/1','5500','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'rlawlgns96','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'김주현','여자','02','6123','1237','010','0456','6571','N','rlawngus','naver.com','N','06000','부산 해운대로','(도봉구)','8동206호','1994','4','26','양력','19/8/15','15500','과장',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'hehwaheki','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'김가연','여자','02','1523','1237','010','6321','6657','N','rlarkdus','naver.com','Y','07803','서울강남구','(군포)','48-22','1980','6','11','양력','18/5/9','15500','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'zizongosu','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'이예진','여자','02','8623','1237','010','7951','0705','N','dldPwls','naver.com','N','06875','중앙로 49','(수원시)','수원빌라 20-8','1971','7','16','음력',default,'1500','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'BOSS','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'이재희','여자','02','6134','5723','010','6455','6468','N','dlwogml','naver.com','N','01554','세종대로 209','(고양시)','세종저택 29','1987','4','15','양력','16/2/1','15500','신입',sysdate,0,0,0,20000); 
insert into member values(seq_member_id.nextval,'Tester','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C','가장 소중한 물건은?','프라모델','김우주','남자','062','1234','1417','010','6432','1148','Y','poramo','naver.com','Y','97511','판교역로 241','(성동구)','판교중국집','1993','1','25','양력','17/3/9','6750','사장',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'Bighand','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C','신체의 특이한 부분은?','손','박태수','남자','031','6254','7823','010','6899','4612','Y','ichinokata','naver.com','Y','35666','강남대로 41','(용인시)','강남비싼아파트 208호','1996','2','13','양력','19/2/22','1320','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'wlwnwlwn','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'김현아','여자','02','7245','5234','010','2975','3162','Y','wlwnwlwn','naver.com','Y','46656','한남대로 28','(파주시)','한파아파트 208호','1997','9','16','양력','19/1/25','18000','사장',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'rnldyal','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C/d09dsf8l1jlasiAX',null,null,'한아름','여자','02','7242','1357','010','4751','1412','N','dkfmadl','naver.com','N','40800','누리길 22','(양천구)','누리저택 90-2','1996','4','25','양력','19/9/9','8000','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'znektkdl','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'박지현','여자','02','1623','6751','010','0017','3897','Y','wlgus0413','google.com','N','10011','하왕로 012','(영등포구)','영등아파트 1동 202호','1996','7','1','양력','18/12/27','1000','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'Harbu','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C','자신의 성격은?','매우 더럽다','이지수','남자','02','3432','3723','010','2345','0176','N','dlqnsdlaos','daum.net','Y','01445','석불로 202','(고양시)','석불불고기집','1997','9','16','양력','19/8/8','18000','사장',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'DHname','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'정태한','남자','02','1237','6845','010','2288','4687','Y','rkdgksska','naver.com','Y','10866','장신로 22','(양천구)','장신만사는집 208-1','1989','8','17','양력','19/6/4','750','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'Codename','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'최승우','남자','02','6548','3453','010','6213','0345','Y','tmddnsms','naver.com','N','01558','둔산대로 82','(영등포구)','늘푸른 저택 89-2','2000','10','22','양력','19/8/6','1800','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'zero','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'를르슈','남자','02','9984','6542','010','4123','7234','N','bebritania','naver.com','N','08666','계백로','(동작구)','동작그만 202호','1999','5','11','양력','17/12/20','690','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'Bewhy','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'비와이','남자','02','4456','2312','010','6254','7253','Y','qldhkdl','naver.com','Y','08466','사직로 158','(노원구)','사직면집','1991','11','27','양력','19/2/28','15500','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'Czam','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'씨잼','남자','02','6895','4458','010','4264','7353','Y','CEzam','naver.com','Y','04655','송내대로 699','(도봉구)','서울빌라 802호','1992','12','5','양력','19/4/10','8800','대리',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'madCrown','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'매드크라운','남자','02','8458','1277','010','6345','7245','N','madcrown99','naver.com','N','10587','국회대로','(서초구)','청와대','1980','4','18','양력','19/7/20','150','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'drfish','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'이광수','남자','02','1236','6458','010','7584','3164','Y','dlrhkdtn','naver.com','N','20585','상계로','(성북구)','의사당대로','1997','2','10','양력',default,'940','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'saleser','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'최승아','남자','02','5568','9561','010','5123','8555','Y','tmddkWkd','naver.com','N','89545','구리로','(노원구)','노원빌라 207호','1998','6','16','양력','19/9/16','1200','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'hansome','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'장동건','남자','02','3608','0140','010','5132','5552','N','ehdrjsqq','naver.com','Y','01878','노해로','(동대문구)','노원빌라 208호','1995','7','18','음력','17/2/6','1600','대리',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'supergay','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'홍석천','남자','02','0407','6568','010','0856','6236','N','tjrcjsgay','naver.com','N','06899','건대로 27','(종로구)','폴리스','1994','4','19','양력','18/10/20','18000','사장',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'lilermarz','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'릴러말즈','남자','02','3143','0147','010','1237','7802','N','flffkaaq','naver.com','Y','07444','군자로 135','(관악구)','양지마트 2층당구장','1989','11','20','음력',default,'6600','대리',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'penomeco','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'페노메코','남자','02','2315','0287','010','0856','1234','N','vpshapzh80','korea.co.kr','Y','06795','아차산로 33','(은평구)','아차산 깊은 숲속','2000','1','25','양력','19/4/8','900','신입',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'nafla','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'나플라','남자','02','6486','3238','010','0909','1784','N','nafla4432','google.com','Y','06355','성덕로 66','(강평구)','서울빌라 6동 101호','1990','5','13','음력','19/3/2','200','대리',sysdate,0,0,0,0); 
insert into member values(seq_member_id.nextval,'changmo','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'창모','남자','02','0185','3684','010','0567','7455','Y','ckdah94','naver.com','N','01445','가로수길 13','(성동구)','가로수80호 옆 지하실','1980','4','16','양력','18/1/18','8900','과장',sysdate,0,0,0,0);  
insert into member values(seq_member_id.nextval,'admin','A665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3','$2a$10$vhDoqS3SEPd1FWP2J.KQGOrpFBBzBvZoz09elt7wvSMtT8i7lvW4C',null,null,'관리자','남자','02','0185','3684','010','0567','7455','Y','ckdah94','naver.com','N','01445','가로수길 13','(성동구)','가로수80호 옆 지하실','1980','4','16','양력','18/1/18','8900','관리자',sysdate,0,0,0,0); 

insert into nonmember values(0,'1','1','1','1','1','1','1','1','1','1','1','1','1');

--1번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.nextval,'
클래식 핀턱 베이지 트렌치코트',89000,25,100,'onSale',100,'한국','코트'
                            ,sysdate,'런더너의 프렌치 감성을 고스란히 담아 본 트렌치코트입니다.
적당 기장에 클래식한 실루엣이 고급스럽게 드러납니다.
박시하지 않은 기본 일자핏 라인으로 그냥 걸치기만 해도 핏이 자연스럽게 잡힙니다.
뒤에 들어간 긴 케이프는 스트랩까지 착용했을 때 허리라인을 슬림하게 살려주고 있습니다.
드라마틱한 핀턱 주름 디테일은 시티룩에도 잘 어울리는 아이템입니다.',0,'면','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다'
);
--2번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'
클래식 핀턱 트렌치코트',49000,25,0,'onSale',0,'한국','코트'
                            ,sysdate,'런더너의 프렌치 감성을 고스란히 담아 본 트렌치코트입니다.
적당 기장에 클래식한 실루엣이 고급스럽게 드러납니다.
박시하지 않은 기본 일자핏 라인으로 그냥 걸치기만 해도 핏이 자연스럽게 잡힙니다.
뒤에 들어간 긴 케이프는 스트랩까지 착용했을 때 허리라인을 슬림하게 살려주고 있습니다.
드라마틱한 핀턱 주름 디테일은 시티룩에도 잘 어울리는 아이템입니다.',0,'면','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다'
);
--3번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'더블 맥시 트렌치코트',49000,45,0,'onSale',0,'중국','코트'
                            ,sysdate,'편안하고 박시한 핏의 맥시 더블 버튼 트렌치코트입니다.
코트에 달린 버튼은 각 컬러에 어울리는 컬러감으로 맞추어 조화를 이루고 있습니다.
뒤트임 비조로 포인트를 주었고, 양 사이드에 튤립 형태로 들어간 트임으로 편안하게 착용 가능합니다.
특별히 셀렉하여 넣은 카키그레이 컬러는 어디서도 볼 수 없는 세련된 컬러입니다',0,'면','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다'
);
--4번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'모나코 더블 트렌치코트',59000,10,0,'onSale',0,'중국','코트'
                            ,sysdate,'편안하고 박시한 핏의 맥시 더블 버튼 트렌치코트입니다.
코트에 달린 버튼은 각 컬러에 어울리는 컬러감으로 맞추어 조화를 이루고 있습니다.
뒤트임 비조로 포인트를 주었고, 양 사이드에 튤립 형태로 들어간 트임으로 편안하게 착용 가능합니다.
특별히 셀렉하여 넣은 카키그레이 컬러는 어디서도 볼 수 없는 세련된 컬러입니다.',0,'면','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다'
);

--5번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'
피렌체 맥시 트렌치코트',43000,14,0,'onSale',0,'한국','코트'
                            ,sysdate,'기본 베이직핏 보다 더 편하고 루즈하게 나온 박시핏 트렌치코트입니다.
어깨 견장도 박시핏에 맞게 기장이 길고, 품과 소매통 등 전체적인 기장에 여유를 주어 편안하게 착용하실 수 있습니다.
총 7가지로 각자에게 어울리는 컬러로 고르시는 걸 추천합니다.',0,'면','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다'
);

--6번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'런던 트렌치코트',35000,5,0,'onSale',0,'중국','코트'
                            ,sysdate,'자체적인 무드에, 별다른 아이템 없어도
스타일리시해 보이는 트렌치 코트입니다.
트렌치의 정석적인 디테일들은 기본이고.
품, 소매, 어깨, 벨트 등의 사소한 디테일까지 차별화된 퀄리티를 갖춘 코트입니다.
약간은 바스락 거리는 소재감에 핏 잡힌 유연함으로
편하고 예쁜 핏으로 몸에 알맞게 착용됩니다.
오래 착용 가능할 수 있도록, 튼튼하고 두께감이 느껴지는 단단한 원단을 사용했습니다.',0,'면','소재 특성상 반복적이거나 심한 마찰로 인한 열화현상으로 제품 표면에 보풀 또는 옷감의 번들거림이 발생할 수 있습니다.'
);

--7번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'
모나코 맥시 트렌치코트',34000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'편안하고 박시한 핏의 맥시 더블 버튼 트렌치코트입니다.
코트에 달린 버튼은 각 컬러에 어울리는 컬러감으로 맞추어 조화를 이루고 있습니다.
뒤트임 비조로 포인트를 주었고, 양 사이드에 튤립 형태로 들어간 트임으로 편안하게 착용 가능합니다.
특별히 셀렉하여 넣은 카키그레이 컬러는 어디서도 볼 수 없는 세련된 컬러입니다.',0,'폴리에스테르','소재 특성상 반복적이거나 심한 마찰로 인한 열화현상으로 제품 표면에 보풀 또는 옷감의 번들거림이 발생할 수 있습니다.'
);


--8번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'런던 트렌치코트',88000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'자체적인 무드에, 별다른 아이템 없어도
스타일리시해 보이는 트렌치 코트입니다.
트렌치의 정석적인 디테일들은 기본이고.
품, 소매, 어깨, 벨트 등의 사소한 디테일까지 차별화된 퀄리티를 갖춘 코트입니다.
약간은 바스락 거리는 소재감에 핏 잡힌 유연함으로
편하고 예쁜 핏으로 몸에 알맞게 착용됩니다.
오래 착용 가능할 수 있도록, 튼튼하고 두께감이 느껴지는 단단한 원단을 사용했습니다.',0,'폴리에스테르','건조 시에는 햇빛을 피하여 통풍이 잘 되는 그늘에서 옷걸이를 이용하여 건조하시기 바랍니다.'
);

--9번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스탠다드 더블 롱 트렌치코트',49000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'바디에 흐르면서 가볍게 떨어지는 디자인이 특징인 트렌치코트입니다.
모델 175cm 기준으로 무릎 아래로 떨어지는 롱 기장이며,
일자로 툭 떨어지는 스트레이트 핏입니다.
자연스러운 레글런 슬리브와 케이프와 함께 더블 버튼 여밈입니다.
베이직한 트렌디 디자인의 디테일을 살려주었습니다.',0,'폴리에스테르','늘어날 수 있으므로 착용 시 과다하게 잡아당기지 마십시오. 신체사이즈에 맞는 제품을 착용하십시오'
);
--10번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스탠다드 트리플 롱 트렌치코트',88000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'바디에 흐르면서 가볍게 떨어지는 디자인이 특징인 트렌치코트입니다.
모델 175cm 기준으로 무릎 아래로 떨어지는 롱 기장이며,
일자로 툭 떨어지는 스트레이트 핏입니다.
자연스러운 레글런 슬리브와 케이프와 함께 더블 버튼 여밈입니다.
베이직한 트렌디 디자인의 디테일을 살려주었습니다.',0,'폴리에스테르','건조 시에는 햇빛을 피하여 통풍이 잘 되는 그늘에서 옷걸이를 이용하여 건조하시기 바랍니다.'
);

--11번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'오버핏 케이프 트렌치코트',38000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'바디에 흐르면서 가볍게 떨어지는 디자인이 특징인 트렌치코트입니다.
모델 175cm 기준으로 무릎 아래로 떨어지는 롱 기장이며,
오버사이즈 핏이지만, 어벙한 느낌 없이 툭 떨어지는
조화가 매력적인 디자인이며, 자연스러운 레글런 슬리브와 케이프와 함께 더블 버튼 여밈 입니다.
베이직한 트렌디 디자인의 디테일을 살려주었습니다.',0,'폴리에스테르','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다.'
);

--12번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'오버 케이프 트렌치코트',33000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'바디에 흐르면서 가볍게 떨어지는 디자인이 특징인 트렌치코트입니다.
모델 175cm 기준으로 무릎 아래로 떨어지는 롱 기장이며,
오버사이즈 핏이지만, 어벙한 느낌 없이 툭 떨어지는
조화가 매력적인 디자인이며, 자연스러운 레글런 슬리브와 케이프와 함께 더블 버튼 여밈 입니다.
베이직한 트렌디 디자인의 디테일을 살려주었습니다.',0,'폴리에스테르','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다.'
);

--13번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'클래식 오버핏 트렌치코트',75000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'오버핏으로 툭 떨어지는 실루엣이 굉장히 멋스러운 트렌치코트입니다.
어깨, 손목, 허리 벨트 세 가지를 통합 시킨 포인트 디테일은 메이썸에서 직접 선별한 부자재로 고급스러움을 한층 높였습니다.
무릎을 덮는 맥시한 기장감으로 트렌치코트 리얼라이즈를 그대로 느낄 수 있습니다.
자연스럽고 소프트한 5가지의 컬러감으로 어떤 이너와 입어도 자연스러운 연출이 가능합니다',0,'폴리에스테르','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다.'
);


--14번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'
클래식 오버 트렌치코트',66000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'오버핏으로 툭 떨어지는 실루엣이 굉장히 멋스러운 트렌치코트입니다.
어깨, 손목, 허리 벨트 세 가지를 통합 시킨 포인트 디테일은 메이썸에서 직접 선별한 부자재로 고급스러움을 한층 높였습니다.
무릎을 덮는 맥시한 기장감으로 트렌치코트 리얼라이즈를 그대로 느낄 수 있습니다.
자연스럽고 소프트한 5가지의 컬러감으로 어떤 이너와 입어도 자연스러운 연출이 가능합니다.',0,'폴리에스테르','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다.'
);

--15번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'더블 케이프 스탠다드 트렌치코트,',35000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'앞뒤로 볼륨을 더해주는 더블 케이프로 된 트렌치코트입니다.
더블버튼과 빅사이즈로 달린 브라운톤의 버클 장식으로 트렌치코트의 색감을 더 부각시켜주었습니다.
카라 안쪽에 훅앤아이가 있어 실용적이고, 뒤트임이 길게 있어 편합니다.
벨트를 묶었을 땐 원피스 같고, 풀었을 땐 자켓 같은 매력 넘치는 트렌치코트랍니다.
',0,'면','사용 후에는 가급적 빨리 세탁 및 건조하여 보관해 주시기 바랍니다.'
);

--16번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'
플레인 숏 트렌치코트',49000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'디테일이 살아있는 트렌디한 숏 기장의 트렌치코트입니다.
특별히 카라 바로 밑 넥커버와 한 쪽만 포인트 된 케이프, 뒤트임 비조로 디자인 퀄리티를 향상시켰습니다.
힙을 살짝 덮어주는 기장이라 벨트를 했을 때 허리핏은 살리고, 하체는 굉장히 길어보이게 만드는 효과가 있습니다.
슬랙스 또는 데님과 함께 편안한 데일리룩으로 착용하는 것을 추천드립니다.',0,'폴리에스테르','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--17번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'소피아 오버핏 더블 트렌치코트',87000,0,0,'newseller',0,'한국','코트'
                            ,sysdate,'핏 하나로 승부하는 더블 버튼 트렌치코트를 소개합니다.
어깨에 길게 달린 견장과 소매 스트랩, 벨트의 조화로 트렌치의 완성도를 높였습니다.
뒤트임이 있어 활동하기 편하고, 뒤쪽에 달린 케이프에도 트임을 넣어 디테일을 추가했습니다.
특별히 손목 스트랩과 벨트를 끝까지 조여서 착용하면, 전체적인 실루엣에 볼륨을 살릴 수 있습니다.',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--18번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'브라이턴 싱글 라글란 트렌치코트',85000,10,0,'onSale',0,'중국','코트'
                            ,sysdate,'윗버튼이 깔끔하게 포인트 오픈된 싱글버튼 트렌치코트입니다.
시원하게 퍼진 와이드 카라와 종아리 밑까지 내려오는 적당한 기장감으로 투박한듯 멋스럽게 착용 가능하답니다.
라글란디자인이라 떨어지는 어깨선이 예뻐보이고, 소매 스트랩은 고정 가능한 버튼형식이라 굉장히 편합니다.
컬러는 크림과 베이지로 가장 부드러운 두 컬러만 셀렉하여 각자에게 어울리는 톤으로 초이스하시는 걸 추천드립니다!',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--19번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'오드리 트렌치코트,',35000,5,0,'onSale',0,'중국','코트'
                            ,sysdate,'자체적인 무드에 별다른 아이템 없이도 스타일리시해 보이는 트렌치 코트 보여드립니다.
넥 라인에 돋보이는 케이프 디테일은, 꽉 차 보이는 디자인으로 완성시켜줍니다.
몸이 폭 감싸지는 라인으로, 스타일리시함이 배로 살아나며,
언뜻 보면 원피스처럼 디자인되어 투웨이 연출이 가능합니다.
핏이 벌어지지 않도록 단추가 안쪽에 위치하며,
전체적으로 일자로 슬림하게 떨어져 안정감있는 실루엣이 연출됩니다.
또한 백 슬릿으로 내추럴한 멋을 더해, 편안함을 갖춘 부담없는 코트로 완성시켰습니다.
오래도록 착용 가능할 수 있도록, 튼튼하고 두께감이 느껴지는 단단한 원단을 사용했습니다.',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--20번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'오버핏 트렌치코트',54000,3,0,'onSale',0,'중국','코트'
                            ,sysdate,'오버핏으로 툭 떨어지는 실루엣이 굉장히 멋스러운 트렌치코트입니다.
어깨, 손목, 허리 벨트 세 가지를 통합 시킨 포인트 디테일은 메이썸에서 직접 선별한 부자재로 고급스러움을 한층 높였습니다.
무릎을 덮는 맥시한 기장감으로 트렌치코트 리얼라이즈를 그대로 느낄 수 있습니다.
자연스럽고 소프트한 5가지의 컬러감으로 어떤 이너와 입어도 자연스러운 연출이 가능합니다.',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--21번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스탠다드 싱글 후디 트렌치코트',54500,10,0,'onSale',0,'중국','코트'
                            ,sysdate,'캔버스의 분위기가 담긴 싱글 버튼 트렌치코트입니다.
클래식한 스트레이트 핏의 미디엄 롱 기장으로 제작되어 편안함을 표현하였습니다.
자연스러운 레글런 슬리브와 카라와 함께 싱글 버튼 여밈 입니다.
후드는 숨은 버튼이 있어 탈부착이 가능하며 양 사이드 포켓은 핏에 방해되지 않게 깔끔한 마무리가 인상적입니다.',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--22번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'드라마틱 플리츠 로브 코트',75000,10,0,'onSale',0,'한국','코트'
                            ,sysdate,'흐르는 듯 유려한 라인에 사이드 플리츠가 돋보이는 롱 기장의 트렌치코트입니다.
주름 플리츠로 조화를 이루며 우아함이 극대화되는 감성을 선사합니다.
레글런 소매와 테일러드 카라 디테일이 롱 자켓으로도 활용 가능하게 해주며, 안쪽 스냅 더블 버튼으로 오픈클로징을 하는 깔끔한 디테일입니다.
또한 타이 벨트로 전체적인 실루엣을 감싸주어 클래시컬하게 떨어지는 스타일로 연출할 수 있습니다.',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--23번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'더블버튼 롱 자켓',77000,25,0,'onSale',0,'중국','코트'
                            ,sysdate,'유니크한 브라운 체크패턴의 오버사이즈 핏이 멋스러움을 연출합니다.
시그니처 오버사이즈 핏에서 중성적인 느낌과 과하지 않은 적당한 핏이 적절하게 믹스된 코트입니다.
테일러드 칼라와 더블 버튼 그리고 타이 벨트가 프론트 디테일이며, 벨트 고리가 위쪽에 있어 허리선을 강조하는 디테일입니다.',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--24번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'로에 트렌치코트',65000,15,0,'onSale',0,'중국','코트'
                            ,sysdate,'탄탄한데 유연함은 잃지 않은 깔끔한 트렌치코트입니다.
두께감이 적당하여 가뿐히 걸쳐 입기 좋고, 기장은 종아리 중간까지 덮는 롱 기장이라 간절기에 착용하기 좋습니다.
프론트 부분 양쪽에 케이프 라인의 디테일과 스트랩까지, 클로징 했을 때 더 깔끔한 룩이 연출됩니다.',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--25번
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'맥시 트렌치코트',74000,10,0,'onSale',0,'한국','코트'
                            ,sysdate,'부드럽고 가벼운 코튼 혼방 소재 길게 떨어지는 롱카라로 세련됨을 더합니다. 활용도 높은 빅포켓 디테일, 박시함을 살린 어깨 라인, 밋밋함을 덜어줄 손목 벨트 포인트까지 잔잔함에 더해진 포인트들이 이지하게 스타일링 할 수 있답니다.',0,'면','세탁 시에 함께 세탁하는 다른 의류나 물품에 의하여 또는 세탁기의 상태에 따라 올 뜯김이나 보풀이 발생할 수 있음으로 반드시, 세탁 망을 이용하시거나 손빨래를 해주십시오.'
);

--26~50
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'페이크 레더 숏 트렌치자켓',73000,40,0,'onSale',0,'중국','코트'
                            ,sysdate,'모던한 이미지를 연출하는 페이크 레더 자켓입니다.
무겁고 투박하기만 한 라이더자켓에서 조금 더 유연하고 자켓처럼 착용하실 수 있는 디자인입니다.
익숙한 트렌치코트의 디자인이 가미 되어 숏 기장의 페미닌한 분위기가 연출됩니다.
허리 타이 벨트가 포함 되어으며, 소매에는 벨트를 장식해 여성스러운 분위기를 나타내는 페이크 레더 자켓입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);


INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'베이직 미디움 블랙 자켓',49000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'미디움 기장과 오버핏으로 매니시함이 돋보이는 자켓입니다.
적당한 두께의 어깨 패드와 플랩 포켓 포인트로 모던한 실루엣을 보여줍니다.
구김이 없는 부드러운 신소재로 제작되어 부담 없이 착용하실 수 있는 데일리 아이템입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);


INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'오버핏 더블버튼 스트랩 자켓',49000,30,0,'onSale',0,'중국','코트'
                            ,sysdate,'어깨 패드로 오버핏의 실루엣을 살린 더블 버튼 자켓입니다.
라운드로 된 버클이 달린 스트랩을 착용하면 허리핏을 살려주는 풍성한 실루엣이 완성됩니다.
가볍고 부드러운 원단이라 착용하기에 전혀 부담이 없는 자켓입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);


INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'어텀컬러 베이직 투버튼 자켓',39000,20,0,'onSale',0,'중국','코트'
                            ,sysdate,'4가지 컬러로 구성된 투버튼 자켓',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);


INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'글랜 하우스 더블 롱 자켓',71000,0,0,'bestseller',0,'중국','코트'
                            ,sysdate,'클래식한 체크 패턴으로 이루어진 롱 더블 버튼 자켓입니다.
편안한 폴리+레이온 혼방 소재로 전체 안감을 덧대어 만들어졌으며,
무릎 아래로 떨어지는 트렌디한 기장의 테일러드 슬림핏입니다.
앞면 스냅 포켓과 피크드 라펠은 베이직한 느낌을 전달해주며,
뒷면에 슬릿이 있어 활동 시 편안함을 줍니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);


INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'2버튼 싱글 자켓',59000,0,0,'steadyseller',0,'중국','코트'
                            ,sysdate,'깔끔한 카라와 2버튼 디테일이 들어간 오버핏 싱글 자켓입니다.
포켓과 소매 단추 디테일, 탄탄한 어깨 패드 또한 들어가서 전체적인 핏을 멋스럽게 살려주고 있습니다.
세트로 스커트 또는 슬랙스와 함께 착용하면 퀄리티 높은 수트 세트가 완성됩니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);


INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'클래식 롱 라인 자켓',73000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'자켓과 트렌치코트를 연상케 하는 더블 버튼 디테일의 Long 자켓입니다.
어깨 패드와 스트랩은 슬림한 실루엣을 만들어 주고, 6개의 일정한 더블 버튼으로 안정감 있는 디자인이 완성되었습니다.
자켓 밑으로 드러나는 팬츠 또는 스커트와 매치하여 레이어드하여 착용하여도 좋습니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스티치 더블 자켓',59000,0,0,'newseller',0,'독일','코트'
                            ,sysdate,'클래식 더블 버튼 디자인의 블레이저 자켓을 소개합니다.
독창적인 버튼 디테일이 포인트가 되어 유니크한 자켓을 탄생시켰습니다.
뒷 슬릿 포인트로 트렌디한 디테일을 가미했으며, 정교한 테일러링으로 세련된 무드를 연출할 수 있습니다.
노치 라펠과 앞면 포켓이 한층 정돈된 디자인을 완성하여 슬림핏 팬츠 세트와 함께 중성적인 매력이 더해지는 아이템입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'더블버튼 롱 자켓',99000,0,0,'buy_out',0,'중국','코트'
                            ,sysdate,'유니크한 브라운 체크패턴의 오버사이즈 핏이 멋스러움을 연출합니다.
시그니처 오버사이즈 핏에서 중성적인 느낌과 과하지 않은 적당한 핏이 적절하게 믹스된 코트입니다.
테일러드 칼라와 더블 버튼 그리고 타이 벨트가 프론트 디테일이며, 벨트 고리가 위쪽에 있어 허리선을 강조하는 디테일입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'더블버튼 테일러드 블랙 자켓',47000,10,0,'onSale',0,'중국','코트'
                            ,sysdate,'테일러드 카라와 더블 버튼이 돋보이는 자켓입니다.
오픈했을 땐 오버핏처럼 편하고, 클로징 했을 땐 슬림해 보이는 효과가 있습니다.
적당하 두께감의 어깨 패드가 들어가서 전체적인 핏을 멋스럽게 살린 자켓입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'프렌치무드 브라운 자켓',47000,10,0,'bestseller',0,'베트남','코트'
                            ,sysdate,'각 있는 테일러드 카라가 돋보이는 노버튼 스트랩 자켓입니다.
포켓과 소매 버튼 디테일을 넣어 완성도를 높였고, 스트랩에 달린 원형의 버클로 유니크함을 더했습니다.
세련된 프렌치 무드가 느껴지는 자켓으로 여러 룩을 탄생시켜 보시길 바랍니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'웰메이드 라이더자켓',77000,10,0,'onSale',0,'중국','코트'
                            ,sysdate,'내추럴하게 멋을 낼 수 있는 라이더 자켓입니다.
지퍼와 포켓 디테일 등 디자인에 심혈을 기울였습니다.
각이 잘 잡히는 리얼 같은 탄탄한 소재에, 소매는 편하게 지퍼로 열 수 있어서 실용적인 라이더 자켓입니다.',0,'레이온','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'프리미엄 하프 린넨 자켓',29000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'100% 린넨 소재로 제작된 하프 자켓입니다.
어깨에는 얇은 패드가 들어가 있어 과하지 않으면서도 핏을 고급스럽게 잡아줍니다.
허리 스트랩이 포함되어 있어 오버핏과 타이트한 핏 모두 연출할 수 있습니다.
가격 대비 퀄리티가 매우 뛰어나서 화이트, 블랙 모두 소장하시기 좋은 상품입니다.',0,'텐셀','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스탠다드 더블 자켓',39000,0,0,'newseller',0,'미국','코트'
                            ,sysdate,'테일러드 카라로 각선미 넘치는 더블버튼 린넨 긴팔 자켓입니다.
오버핏의 디자인으로 멋을 더했고 립모양의 포켓으로 깔끔함을 더했습니다.
세트인 린넨 팬츠와 함께 착용하면 매니쉬한 수트세트 느낌을 연출할 수 있습니다.',0,'면','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스탠다드 싱글 린넨 자켓',39900,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'착용했을 때 깔끔함을 자랑하는 싱글 버튼 린넨 자켓입니다.
총 3개의 포켓 디테일로 자켓의 멋스러움을 추가하였습니다.
가벼운 린넨 소재라 부담 없이 봄, 여름, 가을까지 시원하게 즐겨 입으실 수 있습니다.',0,'면','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);


INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'홀리데이 싱글 버튼 자켓',67000,40,0,'onSale',0,'미국','코트'
                            ,sysdate,'은은한 파스텔 컬러감으로 매끄러운 소재를 자랑하는 싱글 버튼 자켓입니다.
어깨패드로 전체적인 핏을 잡아주고, 동일한 소재로 감싸진 2버튼은 자켓의 가장 퀄리티 있는 디테일이라 할 수 있습니다.
다양한 컬러와 소재를 가진 하의와 매치하여 입기 좋은 아이템입니다.',0,'면','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'멀티플 롤업 슬리브 싱글버튼 자켓',63000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'롤업한 커프스의 배색 디테일이 돋보이는 Over Size 싱글 자켓입니다.
카라와 어깨 패드 및 버튼 디테일에서 매니시한 무드가 느껴지고, 깔끔한 포켓으로 스탠다드 자켓이 완성되었습니다.
더 박시한 느낌의 핏을 원하시면 소매 커프스를 펴서 연출하는 것을 추천드립니다.',0,'면','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'크롭 싱글 자켓',39900,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'짧은 기장이 돋보이는 싱글 브레스트 블레이저를 만나보세요.
숄더 라인은 자연스럽게 떨어지는 패드를 더해 웨이스트를 슬림하게 강조했습니다.
다트 디테일을 더해 정교하게 완성했으며, 숏 기장으로 슬랙스 수트 세트와 함께 모던한 테일러드 룩을 완성할 수 있습니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'박시핏 노버튼 스트랩 자켓',39000,10,0,'onSale',0,'중국','코트'
                            ,sysdate,'클래식 더블 버튼 디자인의 블레이저 자켓 보여드립니다.
독창적인 버튼 디테일이 자켓의 포인트가 되어 독특한 느낌을 나타냅니다.
뒷 슬릿 포인트로 트렌디한 디테일을 가미했으며, 정교한 테일러링으로 단독으로도 우아한 감성을 표현하는 디자인입니다.
노치 라펠과 앞면 포켓이 한층 정돈된 디자인을 완성하여 슬림핏 팬츠 세트와 함께 중성적인 매력이 더해지는 상품입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'블랙 포켓 라이더자켓',73000,0,0,'buy_out',0,'러시아','코트'
                            ,sysdate,'레더 자켓 고유의 담백한 매력을 한껏 살린 메이썸메이드 페이크 레더 자켓을 소개합니다.
부드러운 텍스처로 리얼 레더와 비교해도 전혀 손색 없는 퀄리티의 원단입니다.
편안하면서도 슬림하게 맞는 스타일로 여러 개의지퍼 포켓과 실버 톤 하드웨어가 돋보이는 디자인입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'오버핏 커프스 롱 자켓',49000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'유니크함이 느껴지는 오버핏의 롱슬리브 자켓입니다.
전체적으로 큰 실루엣으로 디자인되어 소매 버튼과 롤업했을 때 보이는 안감이 포인트입니다.
스트랩을 묶어서 연출하면 하체가 길어 보이는 멋스러운 자켓입니다.',0,'레이온','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'보테 숏 트렌치코트',57000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'트렌치 코트',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스탠다드 3버튼 자켓',39000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'테일러링 기법으로 세련된 라인이 돋보이는 자켓입니다.
3버튼 포인트에 힙이 가려지는 미디엄 기장입니다.
적당한 어깨 패드가 있어 모던한 실루엣이 돋보이는 데일리 자켓입니다.',0,'아크릴','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'모던 매니쉬 롱 코트',57000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'안정감이 느껴지는 테일러드 카라 디테일입니다.
고급스러운 무광 스냅 버튼과 허리 부분에 있는 양쪽 포켓으로 모던함을 주었습니다.
소매에 달린 4개의 버튼 디테일로 클래식 또한 느껴지는 코트입니다.',0,'폴리에스테르','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'내추럴 롱 니트가디건',29000,0,0,'newseller',0,'중국','코트'
                            ,sysdate,'카라와 라펠 디테일이 들어간 롱 니트 가디건입니다.
착용감이 가볍고 포켓 디테일도 있어 실용적입니다.
환절기 때 입기 가장 좋은 아우터로 아이보리와 블랙 하나씩 소장하시는 걸 추천드립니다.',0,'아크릴','세탁법 / 드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)'
);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'매니쉬 더블 맥스 코트',79000,10,0,'onSale',0,'한국','코트'

                            ,sysdate,'6개의 Double Button 디테일이 돋보이는 롱 코트입니다.

핏은 살리되, 입었을 땐 편하도록 어깨라인부터 밑단까지 적당하게 루즈한 패턴으로 만들어진 코트입니다.

양 사이드 플랩 포켓과 웰트 포켓이 포인트가 되었고, 컬러는 러블리한 인디핑크와 모던한 블랙이 있습니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'맥시 실루엣 롱 코트',79000,20,0,'onSale',0,'한국','코트'

                            ,sysdate,'칼라 스트랩과 소매 스트랩이 들어간 맥시한 롱 코트입니다.

빅 사이즈의 칼라와 손끝까지 오는 긴 소매 기장은 이 코트의 아이덴티티를 살렸습니다.

칼라를 올려 버튼으로 스트랩 고정이 가능하고, 소매에 있는 버튼뿐만 아니라 원 버튼으로만 스트랩과 클로징할 수 있는 디자인이 돋보이는 코트입니다.',0,'폴리에스테르',

'본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'무스탕 롱 코트',79000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'칼라에 들어간 퍼 디테일이 눈에 띄는 Vintage 감성의 롱 코트입니다.

8개의 버튼으로 클로징 할 수 있으며, 칼라를 끝까지 세워 넥 스트랩으로 고정하여 따뜻함을 유지시킬 수 있습니다.

전체적으로 여유로운 핏이라 두께감 있는 이너와 함께 따뜻하게 착용할 수 있습니다.',0,'가죽','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'캔버스 오버핏 더블 코트',77000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'칼라에 들어간 퍼 디테일이 눈에 띄는 Vintage 감성의 롱 코트입니다.

8개의 버튼으로 클로징 할 수 있으며, 칼라를 끝까지 세워 넥 스트랩으로 고정하여 따뜻함을 유지시킬 수 있습니다.

전체적으로 여유로운 핏이라 두께감 있는 이너와 함께 따뜻하게 착용할 수 있습니다.',0,'가죽','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'캔버스 오버핏 더블 코트 브라운',77000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'칼라에 들어간 퍼 디테일이 눈에 띄는 Vintage 감성의 롱 코트입니다.

8개의 버튼으로 클로징 할 수 있으며, 칼라를 끝까지 세워 넥 스트랩으로 고정하여 따뜻함을 유지시킬 수 있습니다.

전체적으로 여유로운 핏이라 두께감 있는 이너와 함께 따뜻하게 착용할 수 있습니다.',0,'가죽','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'캔버스 오버핏 더블 코트 코코아',77000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'와이드 카라와 포인트 포켓으로 귀여움을 더한 오버핏의 코트입니다.

벌룬핏 실루엣인 F사이즈로 제작되 이너를 두께감 있이 착용하거나 레이어드로 매치해도 문제 없습니다.

더블 버튼 디자인으로 다 잠궜을 때 볼륨있는 핏이 완성됩니다.

컬러는 따뜻한 브라운, 코코아, 블랙 세 가지로 각자에게 맞는 톤으로 픽해보세요.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'리얼 오버핏 맥시 코트',79000,0,0,'steadyseller',0,'한국','코트'

                            ,sysdate,'유니크하면서도 러블리한 핏, 색감이 돋보이는 코트입니다.

모델이 한눈에 반할 정도로 핑크 컬러 색감이 정말 예쁘게 나온 제품이며,

한겨울에 멋스럽게 하나만 포인트로 걸쳐주기 딱 좋은 코트입니다.

여느 코트들과는 확연히 다르게 박시한 핏입니다.

스트랩을 사용해 로브 코트로 착용해도 멋스러운 제품입니다.',0,'폴리에스테르','본 제품 블랙 색상은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'에덴 싱글 코트 아이보리',83000,0,0,'steadyseller',0,'한국','코트'

                            ,sysdate,'모델이 한눈에 반할 정도로 핑크 컬러 색감이 정말 예쁘게 나온 제품이며,

한겨울에 멋스럽게 하나만 포인트로 걸쳐주기 딱 좋은 코트입니다.

여느 코트들과는 확연히 다르게 박시한 핏입니다.

스트랩을 사용해 로브 코트로 착용해도 멋스러운 제품입니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'에덴 싱글 코트 핑크',83000,0,0,'steadyseller',0,'한국','코트'

                            ,sysdate,'모델이 한눈에 반할 정도로 핑크 컬러 색감이 정말 예쁘게 나온 제품이며,

한겨울에 멋스럽게 하나만 포인트로 걸쳐주기 딱 좋은 코트입니다.

여느 코트들과는 확연히 다르게 박시한 핏입니다.

스트랩을 사용해 로브 코트로 착용해도 멋스러운 제품입니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

); 

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'에덴 싱글 코트 브라운',83000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'일자로 슬림하게 툭- 떨어지는 핏의 롱 코트입니다.

더블 버튼, 해링본 원단으로 고급스럽게 입기 좋은 디자인입니다.

하이 퀄리티의 아우터로 그 어떤 곳에서도 쉽게 접하시기 힘든 합리적인 가격의 제품입니다.

코트 특유의 구김이 잘 가거나, 먼지가 눈에 띄는 소재가 아니기 때문에 처음 상태로 오래오래 착용하실 수 있습니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);



--60

 

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'후드 롱 슬릿 더플 코트',79000,20,0,'onSale',0,'한국','코트'

                            ,sysdate,'기존의 스쿨룩 스러운 더플 코트와는 달리, 단정하고 멋스러운 롱- 기장이 자체로 포인트 되는 아이템입니다.

하이 퀄리티 아우터로 그 어떤 곳에서도 쉽게 접하시기 힘든 합리적인 가격의 제품이랍니다.

소매통도 여유로운 편이라 겨울에는 도톰한 이너와 함께 해도 좋으며, 스트랩 없이도 허리 라인이 부해보이지 않는 것 또한 장점입니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'헤링본 울 롱 코트',89000,0,0,'steadyseller',0,'한국','코트'

                            ,sysdate,'일자로 슬림하게 툭- 떨어지는 핏의 롱 코트입니다.

더블 버튼, 해링본 원단으로 고급스럽게 입기 좋은 디자인입니다.

하이 퀄리티의 아우터로 그 어떤 곳에서도 쉽게 접하시기 힘든 합리적인 가격의 제품입니다.

코트 특유의 구김이 잘 가거나, 먼지가 눈에 띄는 소재가 아니기 때문에 처음 상태로 오래오래 착용하실 수 있습니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'노보 더블 롱 코트 블랙',74000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'고급스러운 디테일이 세밀하게 들어간 더블 버튼 코트입니다.

허리 쪽에 들어간 절개선은 허리 곡선을 살리는데 한몫하였고, 뒤트임이 들어가서 움직임에도 전혀 불편함이 없습니다.

전체적으로 안정된 일자 핏이라서 무난하게 착용하실 수 있습니다.

바디 실루엣을 잘 살리기 위해 제작된 퀄리티 높은 코트입니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'노보 더블 롱 코트 코코아',74000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'고급스러운 디테일이 세밀하게 들어간 더블 버튼 코트입니다.

허리 쪽에 들어간 절개선은 허리 곡선을 살리는데 한몫하였고, 뒤트임이 들어가서 움직임에도 전혀 불편함이 없습니다.

전체적으로 안정된 일자 핏이라서 무난하게 착용하실 수 있습니다.

바디 실루엣을 잘 살리기 위해 제작된 퀄리티 높은 코트입니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'헤이글 더블 울 코트 레드브라운',83000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'벨트 디테일에 가장 심혈를 기울인 더블 버튼 코트입니다.

두 개의 버튼과 촘촘한 스티치가 들어간 벨트로 코트의 퀄리티를 높여주었습니다.

각선미를 살린 테일러드 카라로 코트를 클로징했을 때 목선이 길어 보이고, 벨트를 맸을 때와 풀었을 때 드러나는 다른 매력의 실루엣으로 두 가지 연출이 가능합니다.',0,'폴리에스테르',

'본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'헤이글 더블 울 코트 카멜',83000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'벨트 디테일에 가장 심혈를 기울인 더블 버튼 코트입니다.

두 개의 버튼과 촘촘한 스티치가 들어간 벨트로 코트의 퀄리티를 높여주었습니다.

각선미를 살린 테일러드 카라로 코트를 클로징했을 때 목선이 길어 보이고, 벨트를 맸을 때와 풀었을 때 드러나는 다른 매력의 실루엣으로 두 가지 연출이 가능합니다.',0,

'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'브레드 오버핏 더블 울 코트',59000,0,0,'steadyseller',0,'한국','코트'

                            ,sysdate,'고급스러운 디테일이 세밀하게 들어간 더블 버튼 코트입니다.

허리 쪽에 들어간 절개선은 허리 곡선을 살리는데 한몫하였고, 뒤트임이 들어가서 움직임에도 전혀 불편함이 없습니다.

전체적으로 안정된 일자 핏이라서 무난하게 착용하실 수 있습니다.

바디 실루엣을 잘 살리기 위해 제작된 퀄리티 높은 코트입니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'블랙 윈터 트렌치 코트',59000,0,0,'steadyseller',0,'한국','코트'

                            ,sysdate,'맥시한 트렌치 무드로 착용하기 좋은 코트입니다.

전체적인 디테일이 트렌치코트에서 모티브를 얻어,

손목이나 프론트 부분 디테일로 특유의 세련미를 더했습니다.

컬러는 클래식한 블랙 원 컬러입니다.

담백한 프렌치 디자인을 좋아하시는 분들은 더할 나위 없이 선호하실 것으로 예상되며,

유행에 구애받지 않아 데일리 위드 아이템으로 추천드립니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'밀라노 스트랩 롱 코트',82000,20,0,'onSale',0,'한국','코트'

                            ,sysdate,'모던하고 세련된 클래식 룩을 연출할 수 있는 롱 코트입니다.

각자 바디에 맞는 포멀핏으로 착용했을 때 슬림해 보이는 효과가 있습니다.

포켓 디테일과 바로 밑 버튼이 포인트가 되어 스트랩을 묶었을 때 허리가 가늘어 보이고 하체가 길어 보입니다.

컬러는 무난하게 입기 좋은 카멜, 블랙 두 가지가 준비되어 있습니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'소프르 해링본 더블 롱 코트',85000,20,0,'onSale',0,'한국','코트'

                            ,sysdate,'모던하고 세련된 클래식 룩을 연출할 수 있는 롱 코트입니다.

각자 바디에 맞는 포멀핏으로 착용했을 때 슬림해 보이는 효과가 있습니다.

포켓 디테일과 바로 밑 버튼이 포인트가 되어 스트랩을 묶었을 때 허리가 가늘어 보이고 하체가 길어 보입니다.

컬러는 무난하게 입기 좋은 카멜, 블랙 두 가지가 준비되어 있습니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

 

--70

 

 

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'칠리 하프 울 코트 블랙',74000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'모던하고 세련된 클래식 룩을 연출할 수 있는 롱 코트입니다.

각자 바디에 맞는 포멀핏으로 착용했을 때 슬림해 보이는 효과가 있습니다.

포켓 디테일과 바로 밑 버튼이 포인트가 되어 스트랩을 묶었을 때 허리가 가늘어 보이고 하체가 길어 보입니다.

컬러는 무난하게 입기 좋은 카멜, 블랙 두 가지가 준비되어 있습니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'칠리 하프 울 코트 카멜',74000,0,0,'newseller',0,'한국','코트'

                            ,sysdate,'풍성한 소매 퍼프로 볼륨감과 우아함을 동시에 자랑하는 코트입니다.

어깨와 소매 끝에 자연스럽게 잡힌 주름과 트임있는 커프스로 입체적인 핏을 만들어주었습니다.

전체적으로 볼륨이 있기 때문에 벨트를 고정했을 때 보다 더 잘록한 허리핏이 나온답니다.

코트 하나만 착용해도 여성스러운 원피스를 연상케 할 수 있으니, 러블리 아이템으로 꼭 추천드립니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'벌룬 슬리브 코트',85000,20,0,'onSale',0,'한국','코트'

                            ,sysdate,'풍성한 소매 퍼프로 볼륨감과 우아함을 동시에 자랑하는 코트입니다.

어깨와 소매 끝에 자연스럽게 잡힌 주름과 트임있는 커프스로 입체적인 핏을 만들어주었습니다.

전체적으로 볼륨이 있기 때문에 벨트를 고정했을 때 보다 더 잘록한 허리핏이 나온답니다.

코트 하나만 착용해도 여성스러운 원피스를 연상케 할 수 있으니, 러블리 아이템으로 꼭 추천드립니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'모던 플레어 코트',85000,10,0,'onSale',0,'한국','코트'

                            ,sysdate,'훌륭한 핏과 실루엣을 나타내기 위해 공들여 제작된 더블 버튼 코트입니다.

눈으로 보기만 해도 반들반들한 소재가 느껴지고, 만졌을 때 텍스처는 굉장히 소프트합니다.

착용하였을 때 허리 양 사이드에 들어간 절개 곡선을 따라 허리라인이 잘록하게 살아납니다.

오버핏 외에 여성스러운 핏감을 찾으시는 분들께 꼭 추천드립니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

insert into product values (SEQ_PRODUCT_ID.NEXTVAL,'오버핏 소프트 더블 코트',49000,0,0,'steadyseller',0,'한국','코트'

                            ,sysdate,'훌륭한 핏과 실루엣을 나타내기 위해 공들여 제작된 더블 버튼 코트입니다.

눈으로 보기만 해도 반들반들한 소재가 느껴지고, 만졌을 때 텍스처는 굉장히 소프트합니다.

착용하였을 때 허리 양 사이드에 들어간 절개 곡선을 따라 허리라인이 잘록하게 살아납니다.

오버핏 외에 여성스러운 핏감을 찾으시는 분들께 꼭 추천드립니다.',0,'폴리에스테르','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.'

);

--핸드메이드 ~75

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'울 블렌드 핸드메이드 코트크롭 싱글 롱슬리브',99000,0,0,
'newseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'울 블렌드 핸드메이드 코트스탠다드 더블',159000,0,0,
'newseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'울 블렌드 핸드메이드 코트 스탠다드 더블 하프',129000,0,0,
'newseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'울 블렌드 핸드메이드 코트 트렌치 더블 맥시',159000,0,0,
'newseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'울 블렌드 핸드메이드 코트 셔츠 루즈',149000,0,0,
'bestseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'울 블렌드 핸드메이드 코트 트렌치 루즈',159000,0,0,
'bestseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'울 블렌드 핸드메이드 코트 해중린 트렌치 루즈',159000,0,0,
'bestseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'울 블렌드 핸드메이드 코트 스탠다드 더블',159000,0,0,
'bestseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'해링본 핸드메이드 코트',219000,0,0,
'bestseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'논카라 로브 핸드메이드 코트',179000,0,0,
'steadyseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'미니멀 스프링 핸드메이드 코트',188000,0,0,
'steadyseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스트랩 로브 핸드메이드 코트',189000,0,0,
'steadyseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'로제 핸드메이드 코트',179000,0,0,
'steadyseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'피나산 로제 핸드메이드 코트',179000,0,0,
'steadyseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'핸드메이드 코트',160000,20,0,
'onSale',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'버튼 맥시 헨드메이드 코트',199000,40,0,
'onSale',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'맥시 헨드메이드 코트',199000,40,0,
'onSale',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'더블 트렌치 핸드메이드 코트',229000,40,0,
'onSale',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'럭셔리 트렌치 핸드메이드 코트',229000,30,0,
'onSale',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'스티치 핸드메이드 로브 코트',179000,30,0,
'onSale',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'핸드메이드 로브 코트',179000,0,0,
'buy_out',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'롱 플레어 핸드메이드 코트',179000,0,0,
'buy_out',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'쇼트 플레어 핸드메이드 코트',179000,0,0,
'newseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'쇼트 플레어 핸드메이드 코트',179000,0,0,
'newseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_ID.NEXTVAL,'숏 맥시 핸드메이드 코트',179000,0,0,
'newseller',0,'한국','코트',sysdate,'두께감 있는 숏 기장의 싱글 버튼 핸드메이드 코트입니다.깔끔한 카라와 싱글로 달린 사이즈 있는 버튼으로 귀여움을 더해주었습니다.두께감 있는 하의를 입었을 때, 롱 코트 보다는 편하게 매치하기 좋은 숏 코트를 추천합니다.'
,0,'울',null
);

--지훈 101 ~ 121 21개 category 무스탕 퍼

insert into product values(SEQ_PRODUCT_ID.nextval,'하이퀄리티 레더무스탕',59000,0,0,'bestseller'
                    ,0,'러시아','코트',default,'고급스러운 광택감이 돋보이는 레더 무스탕입니다.',0,'합성피혁','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');

insert into product values(SEQ_PRODUCT_ID.nextval,'리버시블 양털 무스탕',59000,0,0,'steadyseller'
                    ,0,'중국','코트',default,'스웨이드와 에코 퍼의 이중지 원단으로 만들어진 양면 자켓입니다.',0,'폴리 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');

insert into product values(SEQ_PRODUCT_ID.nextval,'클래식 양털 무스탕',59000,10,0,'onSale'
                    ,0,'중국','코트',default,'스웨이드와 에코 퍼의 이중지 원단으로 만들어진 양면 자켓입니다.',0,'폴리 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'리블 양털 무스탕',59000,10,0,'onSale'
                    ,0,'중국','코트',default,'스웨이드와 에코 퍼의 이중지 원단으로 만들어진 양면 자켓입니다.',0,'폴리 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'라쿤 야상점퍼',119000,0,0,'newseller'
                    ,0,'독일','코트',default,'메이썸 메이드 리얼 라쿤 야상 점퍼 입니다.',0,'퍼 - 라쿤 100%, 겉감 - 코튼 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'폭시 야상점퍼',128000,0,0,'newseller'
                    ,0,'독일','코트',default,'메이썸 메이드 리얼 폭시 야상 점퍼 입니다.',0,'퍼 - 폭시 100%, 겉감 - 코튼 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'더블 포켓 야상 코트',160000,20,0,'onSale'
                    ,0,'독일','코트',default,'더블 포켓으로 편리함을 주는 야상 코트입니다.',0,'퍼 - 라쿤 50%, 폭시 50%, 겉감 - 코튼 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'테디베어 더블 코트',79000,0,0,'newseller'
                    ,0,'한국','코트',default,'더블 버튼과 오픈 포켓 디테일로 안정감을 잡았고, 와이드한 카라로 귀여움을 더해주었습니다.',0,'폴리 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'테디스노우베어 더블 코트',180000,20,0,'onSale'
                    ,0,'한국','코트',default,'에코퍼의 부드러운 질감으로 테디스노우베어를 연상케 하는 코트입니다.',0,'폴리 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'스웨이드 2WAY 무스탕',89000,0,0,'bestseller'
                    ,0,'한국','코트',default,'밑단 분리가 가능하여 두 가지 연출이 가능한 무스탕입니다.',0,'폴리 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'양털 더블카라 자켓',47000,0,0,'newseller'
                    ,0,'중국','코트',default,'와이드한 카라와 라펠 디테일로 러블리한 무드를 연출하였습니다.',0,'폴리100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'양털 더블포켓 무스탕',88000,0,0,'steadyseller'
                    ,0,'일본','코트',default,'양 사이드에 포켓이 있어 편리하고, 부해 보이지 않는 핏이라 여러 룩으로 매치하여 입기 좋은 아이템입니다.',0,'폴리100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'논카라 페이크 퍼 자켓',110000,20,0,'onSale'
                    ,0,'태국','코트',default,'보기만 해도 고급스러운 에코퍼로 제작된 논카라 퍼 자켓입니다. 
                    카라가 없는 라운드넥 디테일로 목선을 길어 보이게 만들어줍니다.',0,'폴리100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'헤비 가죽 라이더 자켓',89000,0,0,'bestseller'
                    ,0,'한국','코트',default,'라이더 자켓과 같은 디자인으로 미니멀한 느낌이며,
적당한 광택감으로 부담스럽지 않게 입을 수 있는 제품입니다.',0,'합성피혁(PU)','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'매니쉬 박시 무스탕JK',38000,0,0,'newseller'
                    ,0,'중국','코트',default,'매니시함이 매력 있게 느껴지는 양털 무스탕입니다.
기존 무스탕 제품보다는 오버사이즈로 제작되었습니다.',0,'합성피혁(pu), 인조양퍼','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'초고퀄 스웨이드 무스탕JK',159000,40,0,'onSale'
                    ,0,'미국','코트',default,'살짝 박시한 핏에 군더더기 없는 깔끔한 실루엣인 무스탕 자켓입니다.
팔까지 덮인 부드러운 토끼털 느낌의 안감으로 겨울에도 따뜻하게 착용 가능합니다.',0,'합성피혁','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'레더 무스탕JK',129000,0,0,'buy_out'
                    ,0,'미국','코트',default,'시크한 무드를 더해주는 부드러운 무스탕점퍼입니다.
리얼가죽 못지 않은 깔끔하면서 고급스러운 레더 소재에 탄탄한 소재입니다.',0,'합성피혁(pu), 인조퍼','본 제품은 예약주문 상품으로, 주문시 7~10일의 상품 준비기간이 있습니다. 참고하여 구매 부탁드립니다.');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'하운드 체크 롱 무스탕',189000,0,0,'bestseller'
                    ,0,'러시아','코트',default,'무광택의 깔끔한 매력을 선사하는 롱 무스탕입니다.
카라와 소매, 전체 안감으로 들어간 소프트한 퍼로 디테일을 살렸습니다.',0,'폴리에스테르 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,' 더블카라 페이크 퍼 자켓',110000,20,0,'onSale'
                    ,0,'러시아','코트',default,'2중으로 된 더블 카라로 유니크함이 느껴지는 퍼 자켓입니다.
리얼 퍼라고 의심될 만큼 하이 퀄리티의 페이크 퍼로 제작되어 촉감은 물론, 보온성도 뛰어납니다.',0,'폴리에스테르 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'논카라 페이크 퍼 자켓',77000,0,0,'newseller'
                    ,0,'미국','코트',default,'보기만 해도 고급스러운 에코퍼로 제작된 논카라 퍼 자켓입니다.카라가 없는 라운드넥 디테일로 목선을 길어 보이게 만들어줍니다.',0,'폴리100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');
                    
insert into product values(SEQ_PRODUCT_ID.nextval,'양털 더블카라 자켓',54000,20,0,'onSale'
                    ,0,'한국','코트',default,'부드러운 질감의 에코퍼로 제작된 양털 더블 카라 자켓입니다.
와이드한 카라와 라펠 디테일로 러블리한 무드를 연출하였습니다.',0,'폴리 100%','드라이크리닝 또는 손세탁(이염 또는 물빠짐이 있을 수 있습니다.)');

--사이즈 S,M,L,FREE

--색상기록 : 오트밀, 블랙, 카멜, 그레이, 브라운 ,베이지,베이지 체크 ,핑크, 연핑크, 아이보리, 딥에메랄드, 와인, 크림
--스카이, 라벤더, 진베이지, 카키그레이, 화이트, 연베이지, 그레이베이지



--1번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','베이지',100,'트렌치코트',NULL,'0',1);
--2번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'트렌치코트',NULL,'0',2);
--3번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','진베이지',100,'트렌치코트',NULL,'0',3);
--4번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','카키그레이',100,'트렌치코트',NULL,'0',4);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','카키그레이',100,'트렌치코트',NULL,'0',4);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','카키그레이',100,'트렌치코트',NULL,'0',4);
--5번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','화이트',100,'트렌치코트',NULL,'0',5);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','연베이지',100,'트렌치코트',NULL,'0',5);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이베이지',100,'트렌치코트',NULL,'0',5);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','진베이지',100,'트렌치코트',NULL,'0',5);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','딥에메랄드',100,'트렌치코트',NULL,'0',5);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',100,'트렌치코트',NULL,'0',5);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'트렌치코트',NULL,'0',5);
--6번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이베이지',100,'트렌치코트',NULL,'0',6);
--7번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','네이비',100,'트렌치코트',NULL,'0',7);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','네이비',100,'트렌치코트',NULL,'0',7);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','네이비',100,'트렌치코트',NULL,'0',7);
--8번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'트렌치코트',NULL,'0',8);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'트렌치코트',NULL,'0',8);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'트렌치코트',NULL,'0',8);
--9번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지체크',100,'트렌치코트',NULL,'0',9);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지체크',100,'트렌치코트',NULL,'0',9);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지체크',100,'트렌치코트',NULL,'0',9);
--10번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지',80,'트렌치코트',NULL,'0',10);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지',80,'트렌치코트',NULL,'0',10);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지',80,'트렌치코트',NULL,'0',10);
--11번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지',80,'트렌치코트',NULL,'0',11);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지',80,'트렌치코트',NULL,'0',11);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지',80,'트렌치코트',NULL,'0',11);
--12번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','아이보리',90,'트렌치코트',NULL,'0',12);
--13번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','라이트 그레이',80,'트렌치코트',NULL,'0',13);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','라이트 그레이',80,'트렌치코트',NULL,'0',13);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','라이트 그레이',80,'트렌치코트',NULL,'0',13);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지',80,'트렌치코트',NULL,'0',13);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지',80,'트렌치코트',NULL,'0',13);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지',80,'트렌치코트',NULL,'0',13);
--14번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',80,'트렌치코트',NULL,'0',14);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',80,'트렌치코트',NULL,'0',14);
--15번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','연핑크',80,'트렌치코트',NULL,'0',15);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','연핑크',80,'트렌치코트',NULL,'0',15);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','연핑크',80,'트렌치코트',NULL,'0',15);
--16번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','베이지',90,'트렌치코트',NULL,'0',16);
--17번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','화이트',100,'트렌치코트',NULL,'0',17);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','연베이지',100,'트렌치코트',NULL,'0',17);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이베이지',100,'트렌치코트',NULL,'0',17);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','진베이지',100,'트렌치코트',NULL,'0',17);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','딥에메랄드',100,'트렌치코트',NULL,'0',17);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',100,'트렌치코트',NULL,'0',17);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'트렌치코트',NULL,'0',17);
--18번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','크림',80,'트렌치코트',NULL,'0',18);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','크림',80,'트렌치코트',NULL,'0',18);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','크림',80,'트렌치코트',NULL,'0',18);
--19번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지',80,'트렌치코트',NULL,'0',19);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지',80,'트렌치코트',NULL,'0',19);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지',80,'트렌치코트',NULL,'0',19);
--20번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지',80,'트렌치코트',NULL,'0',20);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지',80,'트렌치코트',NULL,'0',20);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지',80,'트렌치코트',NULL,'0',20);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','화이트',80,'트렌치코트',NULL,'0',20);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','화이트',80,'트렌치코트',NULL,'0',20);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','화이트',80,'트렌치코트',NULL,'0',20);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','그레이베이지',80,'트렌치코트',NULL,'0',20);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','그레이베이지',80,'트렌치코트',NULL,'0',20);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','그레이베이지',80,'트렌치코트',NULL,'0',20);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','진베이지',80,'트렌치코트',NULL,'0',20);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','진베이지',80,'트렌치코트',NULL,'0',20);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','진베이지',80,'트렌치코트',NULL,'0',20);
--21번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지',80,'트렌치코트',NULL,'0',21);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지',80,'트렌치코트',NULL,'0',21);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지',80,'트렌치코트',NULL,'0',21);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','화이트',80,'트렌치코트',NULL,'0',21);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','화이트',80,'트렌치코트',NULL,'0',21);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','화이트',80,'트렌치코트',NULL,'0',21);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','그레이베이지',80,'트렌치코트',NULL,'0',21);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','그레이베이지',80,'트렌치코트',NULL,'0',21);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','그레이베이지',80,'트렌치코트',NULL,'0',21);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','진베이지',80,'트렌치코트',NULL,'0',21);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','진베이지',80,'트렌치코트',NULL,'0',21);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','진베이지',80,'트렌치코트',NULL,'0',21);
--22번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'트렌치코트',NULL,'0',22);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'트렌치코트',NULL,'0',22);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'트렌치코트',NULL,'0',22);
--23번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'트렌치코트',NULL,'0',23);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'트렌치코트',NULL,'0',23);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'트렌치코트',NULL,'0',23);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','그레이베이지',80,'트렌치코트',NULL,'0',23);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','그레이베이지',80,'트렌치코트',NULL,'0',23);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','그레이베이지',80,'트렌치코트',NULL,'0',23);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','진베이지',80,'트렌치코트',NULL,'0',23);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','진베이지',80,'트렌치코트',NULL,'0',23);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','진베이지',80,'트렌치코트',NULL,'0',23);

--24번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'트렌치코트',NULL,'0',24);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'트렌치코트',NULL,'0',24);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'트렌치코트',NULL,'0',24);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','화이트',80,'트렌치코트',NULL,'0',24);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','화이트',80,'트렌치코트',NULL,'0',24);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','화이트',80,'트렌치코트',NULL,'0',24);

--25번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','화이트',100,'트렌치코트',NULL,'0',25);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','연베이지',100,'트렌치코트',NULL,'0',25);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이베이지',100,'트렌치코트',NULL,'0',25);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','진베이지',100,'트렌치코트',NULL,'0',25);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','딥에메랄드',100,'트렌치코트',NULL,'0',25);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',100,'트렌치코트',NULL,'0',25);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'트렌치코트',NULL,'0',25);

-----26~50 자켓 디테일------

--26번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',150,'자켓',NULL,'0',26);

--27번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',200,'자켓',NULL,'0',27);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',200,'자켓',NULL,'0',27);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',200,'자켓',NULL,'0',27);

--28번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','진베이지',100,'자켓',NULL,'0',28);

--29번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'자켓',NULL,'0',29);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',100,'자켓',NULL,'0',29);

--30번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','그레이',100,'자켓',NULL,'0',30);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','그레이',100,'자켓',NULL,'0',30);

--31번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','베이지',100,'자켓',NULL,'0',31);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카키그레이',100,'자켓',NULL,'0',31);

--32번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'자켓',NULL,'0',32);

--33번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','크림',100,'자켓',NULL,'0',33);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','카키그레이',100,'자켓',NULL,'0',33);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','크림',100,'자켓',NULL,'0',33);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','카키그레이',100,'자켓',NULL,'0',33);

--34번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이',0,'자켓',NULL,'0',34);

--35번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'자켓',NULL,'0',35);

--36번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','브라운',200,'자켓',NULL,'0',36);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','브라운',200,'자켓',NULL,'0',36);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','브라운',200,'자켓',NULL,'0',36);

--37번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','핑크',90,'자켓',NULL,'0',37);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이',90,'자켓',NULL,'0',37);

--38번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',90,'자켓',NULL,'0',38);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',90,'자켓',NULL,'0',38);

--39번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',90,'자켓',NULL,'0',39);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',90,'자켓',NULL,'0',39);

--40번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','진베이지',90,'자켓',NULL,'0',40);

--41번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','스카이',90,'자켓',NULL,'0',41);

--42번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이',90,'자켓',NULL,'0',42);

--43번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','베이지',90,'자켓',NULL,'0',43);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',90,'자켓',NULL,'0',43);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','화이트',90,'자켓',NULL,'0',43);

--44번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',90,'자켓',NULL,'0',44);

--45번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',0,'자켓',NULL,'0',45);

--46번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','그레이',100,'자켓',NULL,'0',46);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','그레이',100,'자켓',NULL,'0',46);

--47번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','아이보리',100,'자켓',NULL,'0',47);

--48번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'자켓',NULL,'0',48);

--49번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',100,'자켓',NULL,'0',49);

--50번
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'자켓',NULL,'0',50);

--51번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'울 코트',NULL,'0',51);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','핑크',100,'울 코트',NULL,'0',51);

 

--52번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'울 코트',NULL,'0',52);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'울 코트',NULL,'0',52);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',100,'울 코트',NULL,'0',52);

 

--53번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'울 코트',NULL,'0',53);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'울 코트',NULL,'0',53);

 

--54번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'울 코트',NULL,'0',54);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'울 코트',NULL,'0',54);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'울 코트',NULL,'0',54);

 

--55번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','브라운',100,'울 코트',NULL,'0',55);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','브라운',100,'울 코트',NULL,'0',55);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','브라운',100,'울 코트',NULL,'0',55);

 

--56번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','진베이지',100,'울 코트',NULL,'0',56);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','진베이지',100,'울 코트',NULL,'0',56);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','진베이지',100,'울 코트',NULL,'0',56);

 

--57번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'울 코트',NULL,'0',57);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','핑크',100,'울 코트',NULL,'0',57);

 

--58번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','아이보리',100,'울 코트',NULL,'0',58);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','아이보리',100,'울 코트',NULL,'0',58);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','아이보리',100,'울 코트',NULL,'0',58);

 

--59번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','핑크',100,'울 코트',NULL,'0',59);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','핑크',100,'울 코트',NULL,'0',59);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','핑크',100,'울 코트',NULL,'0',59);

 

--60번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','브라운',100,'울 코트',NULL,'0',60);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','브라운',100,'울 코트',NULL,'0',60);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','브라운',100,'울 코트',NULL,'0',60);

 

--61번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'울 코트',NULL,'0',61);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'울 코트',NULL,'0',61);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','네이비',100,'울 코트',NULL,'0',61);

 

--62번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'울 코트',NULL,'0',62);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'울 코트',NULL,'0',62);

 

--63번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'울 코트',NULL,'0',63);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'울 코트',NULL,'0',63);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'울 코트',NULL,'0',63);

 

--64번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지',100,'울 코트',NULL,'0',64);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지',100,'울 코트',NULL,'0',64);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지',100,'울 코트',NULL,'0',64);

 

--65번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','브라운',100,'울 코트',NULL,'0',65);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','브라운',100,'울 코트',NULL,'0',65);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','브라운',100,'울 코트',NULL,'0',65);

 

--66번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','카멜',100,'울 코트',NULL,'0',66);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','카멜',100,'울 코트',NULL,'0',66);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','카멜',100,'울 코트',NULL,'0',66);

 

--67번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'울 코트',NULL,'0',67);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'울 코트',NULL,'0',67);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카멜',100,'울 코트',NULL,'0',67);

 

 

--68번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'울 코트',NULL,'0',68);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'울 코트',NULL,'0',68);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'울 코트',NULL,'0',68);

 

--69번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','카멜',100,'울 코트',NULL,'0',69);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','카멜',100,'울 코트',NULL,'0',69);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','카멜',100,'울 코트',NULL,'0',69);

 

--70번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','브라운',100,'울 코트',NULL,'0',70);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','브라운',100,'울 코트',NULL,'0',70);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','브라운',100,'울 코트',NULL,'0',70);

 

--71번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'울 코트',NULL,'0',71);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'울 코트',NULL,'0',71);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'울 코트',NULL,'0',71);

 

--72번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','카멜',100,'울 코트',NULL,'0',72);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','카멜',100,'울 코트',NULL,'0',72);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','카멜',100,'울 코트',NULL,'0',72);

 

--73번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','와인',100,'울 코트',NULL,'0',73);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','와인',100,'울 코트',NULL,'0',73);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','와인',100,'울 코트',NULL,'0',73);

 

--74번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',100,'울 코트',NULL,'0',74);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'울 코트',NULL,'0',74);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'울 코트',NULL,'0',74);

 

--75번

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'울 코트',NULL,'0',75);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','베이지',100,'울 코트',NULL,'0',75);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',100,'울 코트',NULL,'0',75);

INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','네이비',100,'울 코트',NULL,'0',75);


INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','오트밀',100,'핸드메이드 코트',NULL,'0',76);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','오트밀',100,'핸드메이드 코트',NULL,'0',76);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','오트밀',100,'핸드메이드 코트',NULL,'0',76);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','오트밀',100,'핸드메이드 코트',NULL,'0',76);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카멜',100,'핸드메이드 코트',NULL,'0',77);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','카멜',100,'핸드메이드 코트',NULL,'0',77);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','카멜',100,'핸드메이드 코트',NULL,'0',77);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'S','카멜',100,'핸드메이드 코트',NULL,'0',77);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카멜',100,'핸드메이드 코트',NULL,'0',78);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',78);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'핸드메이드 코트',NULL,'0',78);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',100,'핸드메이드 코트',NULL,'0',78);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'핸드메이드 코트',NULL,'0',79);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',79);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',80);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',81);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'핸드메이드 코트',NULL,'0',82);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이',100,'핸드메이드 코트',NULL,'0',83);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',84);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카멜',100,'핸드메이드 코트',NULL,'0',84);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카멜',100,'핸드메이드 코트',NULL,'0',85);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이',100,'핸드메이드 코트',NULL,'0',86);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',87);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'핸드메이드 코트',NULL,'0',87);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','챠콜',100,'핸드메이드 코트',NULL,'0',87);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','핑크',100,'핸드메이드 코트',NULL,'0',88);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'핸드메이드 코트',NULL,'0',89);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',89);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'핸드메이드 코트',NULL,'0',90);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','베이지',100,'핸드메이드 코트',NULL,'0',91);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','아이보리',100,'핸드메이드 코트',NULL,'0',92);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',93);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',94);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',100,'핸드메이드 코트',NULL,'0',95);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',0,'핸드메이드 코트',NULL,'1',96);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'L','브라운',0,'핸드메이드 코트',NULL,'1',96);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',0,'핸드메이드 코트',NULL,'1',97);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운',100,'핸드메이드 코트',NULL,'0',98);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','스카이',100,'핸드메이드 코트',NULL,'0',99);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','라벤더',100,'핸드메이드 코트',NULL,'0',100);
INSERT INTO PRODUCT_DETAIL VALUES (SEQ_PRODUCT_DETAIL_ID.nextval,'M','라벤더',100,'핸드메이드 코트',NULL,'0',100);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','카멜',500,'무스탕 퍼',null,'0',101);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','카멜',500,'무스탕 퍼',null,'0',101);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',500,'무스탕 퍼',null,'0',101);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',500,'무스탕 퍼',null,'0',101);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','브라운',300,'무스탕 퍼',null,'0',102);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','브라운',300,'무스탕 퍼',null,'0',102);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','브라운',300,'무스탕 퍼',null,'0',102);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','오트밀',300,'무스탕 퍼',null,'0',102);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','오트밀',300,'무스탕 퍼',null,'0',102);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','오트밀',300,'무스탕 퍼',null,'0',102);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','카키그레이',200,'무스탕 퍼',null,'0',103);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','카키그레이',200,'무스탕 퍼',null,'0',103);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','딥에메랄드',200,'무스탕 퍼',null,'0',103);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','딥에메랄드',200,'무스탕 퍼',null,'0',103);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','아이보리',200,'무스탕 퍼',null,'0',103);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','아이보리',200,'무스탕 퍼',null,'0',103);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',100,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',200,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','카멜',300,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','카멜',200,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','와인',150,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','와인',120,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','연베이지',220,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','연베이지',250,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','그레이베이지',250,'무스탕 퍼',null,'0',104);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','그레이베이지',270,'무스탕 퍼',null,'0',104);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','스카이',270,'무스탕 퍼',null,'0',105);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','스카이',270,'무스탕 퍼',null,'0',105);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','스카이',270,'무스탕 퍼',null,'0',105);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','스카이',88,'무스탕 퍼',null,'0',106);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','스카이',20,'무스탕 퍼',null,'0',106);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','스카이',160,'무스탕 퍼',null,'0',106);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','진베이지',20,'무스탕 퍼',null,'0',106);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','진베이지',210,'무스탕 퍼',null,'0',106);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','진베이지',270,'무스탕 퍼',null,'0',106);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','그레이',120,'무스탕 퍼',null,'0',106);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','그레이',70,'무스탕 퍼',null,'0',106);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','그레이',270,'무스탕 퍼',null,'0',106);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','아이보리',270,'무스탕 퍼',null,'0',107);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','아이보리',270,'무스탕 퍼',null,'0',107);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','라벤더',270,'무스탕 퍼',null,'0',107);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','라벤더',270,'무스탕 퍼',null,'0',107);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',270,'무스탕 퍼',null,'0',107);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',270,'무스탕 퍼',null,'0',107);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',60,'무스탕 퍼',null,'0',108);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',66,'무스탕 퍼',null,'0',108);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지 체크',22,'무스탕 퍼',null,'0',108);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','베이지 체크',21,'무스탕 퍼',null,'0',108);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','핑크',39,'무스탕 퍼',null,'0',108);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','핑크',42,'무스탕 퍼',null,'0',108);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',12,'무스탕 퍼',null,'0',109);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',27,'무스탕 퍼',null,'0',109);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','딥에메랄드',36,'무스탕 퍼',null,'0',109);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','딥에메랄드',24,'무스탕 퍼',null,'0',109);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','핑크',21,'무스탕 퍼',null,'0',109);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','핑크',89,'무스탕 퍼',null,'0',109);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','화이트',102,'무스탕 퍼',null,'0',109);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','화이트',166,'무스탕 퍼',null,'0',109);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','오트밀',66,'무스탕 퍼',null,'0',110);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','오트밀',78,'무스탕 퍼',null,'0',110);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','카키그레이',32,'무스탕 퍼',null,'0',110);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','카키그레이',64,'무스탕 퍼',null,'0',110);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','카키그레이',32,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','카키그레이',17,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','카키그레이',19,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',20,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',4,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','블랙',21,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','크림',8,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','크림',40,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','크림',98,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','스카이',22,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','스카이',14,'무스탕 퍼',null,'0',111);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','스카이',88,'무스탕 퍼',null,'0',111);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',0,'무스탕 퍼',null,'1',112);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','딥에메랄드',44,'무스탕 퍼',null,'0',112);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','화이트',16,'무스탕 퍼',null,'0',112);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운 ',135,'무스탕 퍼',null,'0',112);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카키그레이',35,'무스탕 퍼',null,'0',113);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','체크 ',92,'무스탕 퍼',null,'0',113);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',65,'무스탕 퍼',null,'0',113);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','그레이베이지',53,'무스탕 퍼',null,'0',113);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',27,'무스탕 퍼',null,'0',113);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','화이트',38,'무스탕 퍼',null,'0',113);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙',28,'무스탕 퍼',null,'0',114);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙',78,'무스탕 퍼',null,'0',114);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','딥에메랄드',108,'무스탕 퍼',null,'0',114);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','딥에메랄드',27,'무스탕 퍼',null,'0',114);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','연베이지',22,'무스탕 퍼',null,'0',114);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','연베이지',50,'무스탕 퍼',null,'0',114);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카멜',0,'무스탕 퍼',null,'1',115);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','스카이',26,'무스탕 퍼',null,'0',115);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','진베이지',0,'무스탕 퍼',null,'1',115);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','라벤더',0,'무스탕 퍼',null,'1',115);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','오트밀',0,'무스탕 퍼',null,'1',115);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','핑크',88,'무스탕 퍼',null,'0',115);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','핑크',0,'무스탕 퍼',null,'1',116);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','핑크',0,'무스탕 퍼',null,'1',116);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','진베이지',0,'무스탕 퍼',null,'1',116);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','진베이지',0,'무스탕 퍼',null,'1',116);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','와인',78,'무스탕 퍼',null,'0',117);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','와인',64,'무스탕 퍼',null,'0',117);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','와인',12,'무스탕 퍼',null,'0',117);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','연베이지',0,'무스탕 퍼',null,'1',117);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','연베이지',46,'무스탕 퍼',null,'0',117);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','연베이지',44,'무스탕 퍼',null,'0',117);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','카멜',84,'무스탕 퍼',null,'0',117);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','카멜',68,'무스탕 퍼',null,'0',117);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','카멜',71,'무스탕 퍼',null,'0',117);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','딥에메랄드',74,'무스탕 퍼',null,'0',118);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','딥에메랄드',14,'무스탕 퍼',null,'0',118);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','연핑크',25,'무스탕 퍼',null,'0',118);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','연핑크',68,'무스탕 퍼',null,'0',118);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','와인',28,'무스탕 퍼',null,'0',119);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','오트밀',33,'무스탕 퍼',null,'0',119);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','블랙',0,'무스탕 퍼',null,'1',119);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','화이트',0,'무스탕 퍼',null,'1',119);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','카키그레이',36,'무스탕 퍼',null,'0',119);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','베이지 체크',27,'무스탕 퍼',null,'0',119);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','베이지',0,'무스탕 퍼',null,'1',119);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','브라운 ',7,'무스탕 퍼',null,'0',119);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'FREE','아이보리',0,'무스탕 퍼',null,'1',119);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','진베이지',24,'무스탕 퍼',null,'0',120);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','진베이지',68,'무스탕 퍼',null,'0',120);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','진베이지',15,'무스탕 퍼',null,'0',120);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','브라운 ',76,'무스탕 퍼',null,'0',120);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','브라운 ',68,'무스탕 퍼',null,'0',120);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'L','브라운 ',34,'무스탕 퍼',null,'0',120);

insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','블랙 ',16,'무스탕 퍼',null,'0',121);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','블랙 ',56,'무스탕 퍼',null,'0',121);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','화이트 ',45,'무스탕 퍼',null,'0',121);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','화이트 ',12,'무스탕 퍼',null,'0',121);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'S','베이지 ',78,'무스탕 퍼',null,'0',121);
insert into product_detail values(SEQ_PRODUCT_DETAIL_ID.nextval,'M','베이지 ',68,'무스탕 퍼',null,'0',121);




----------------------------------------------------------------------------------------------이미지

--1¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,1);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,1);
--2¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,2);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,2);
--3¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,3);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,3);
--4¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,4);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,4);
--5¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,5);
--6¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,6);
--7¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,7);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,7);
--8¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,8);
--9¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,9);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,9);
--10¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,10);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,10);
--11¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,11);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,11);
--12¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,12);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,12);
--13¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,13);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,13);
--14¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,14);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,14);
--15¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,15);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,15);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,15);
--16¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,16);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,16);
--17¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,17);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,17);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,17);
--18¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,18);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,18);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,18);
--19¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,19);
--20¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,20);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,20);
--21¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,21);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,21);
--22¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,22);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,22);
--23¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,23);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,23);
--24¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,24);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,24);
--25¹ø
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,25);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,25);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,26);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,26);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,27);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,27);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,28);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,28);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,29);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,29);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,30);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,30);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,30);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,31);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,31);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,31);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,32);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,32);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,32);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,33);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,33);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,34);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,34);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,34);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,35);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,35);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,36);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,36);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,37);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,37);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,38);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,38);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,39);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,39);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,40);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,40);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,41);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,41);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,41);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,42);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,42);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,42);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,43);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,43);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,44);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,44);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,44);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,45);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,45);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,46);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,46);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,47);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,47);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,48);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,48);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,49);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,49);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,50);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,50);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,51);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,51);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,51);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,52);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,52);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,52);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,53);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,53);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,53);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,54);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,54);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,54);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,55);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,55);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,55);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,56);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,56);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,56);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,57);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,58);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,58);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,58);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,59);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,59);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,59);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,60);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,60);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,60);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,61);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,62);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,63);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,63);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,63);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,64);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,64);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,64);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,65);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,65);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,65);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,66);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,66);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,66);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,67);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,68);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,69);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,69);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,69);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,70);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,70);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,70);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,71);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,71);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,71);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,72);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,72);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,72);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,73);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,73);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,73);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,74);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,74);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,74);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,75);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,76);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,76);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,77);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,77);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,78);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,78);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,79);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,79);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,80);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,80);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,81);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,81);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,82);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,82);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,83);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,83);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,84);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,84);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,85);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,85);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,86);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,86);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,87);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,87);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,88);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,88);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,89);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,89);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,90);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,90);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,91);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,91);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,92);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,92);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,93);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,93);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,94);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,94);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,95);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,95);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,96);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,96);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,97);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,97);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,98);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,98);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,99);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,99);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,100);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,100);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,101);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,101);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,102);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,102);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,102);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,103);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,103);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,103);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,104);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,104);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,104);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,105);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,105);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,106);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,106);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,107);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,107);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,108);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,108);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,108);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,109);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,109);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,109);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,110);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,110);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,111);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,111);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,111);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,112);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,112);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,112);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,113);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,113);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,113);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,114);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,115);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,116);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,116);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,117);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,118);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,118);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,119);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,119);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,119);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,120);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,120);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,120);

INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'main_image.jpg','main_image','admin',sysdate,121);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image1.jpg','detail_image1','admin',sysdate,121);
INSERT INTO PRODUCT_IMAGE VALUES(SEQ_PRODUCT_IMAGE_ID.nextval,'detail_image2.jpg','detail_image2','admin',sysdate,121);


INSERT INTO REVIEW VALUES(20, REVIEW_SEQ.nextval, '오버핏 트렌치코트', 'BOSS', '완전 편하고 최고!', '다리가 짧은 편이신 분들은 살짝 비추지만 전 좋았어요ㅎㅎ', SYSDATE, 0, 0, 5);
INSERT INTO REVIEW_IMAGE VALUES(20, 1, REVIEW_IMAGE_SEQ.nextval, 'review.png', SYSDATE);

INSERT INTO REVIEW VALUES(12, REVIEW_SEQ.nextval, '오버 케이프 트렌치코트', 'Tester', '쬐끔 불편하지만 괜찮네요', '날씨 좀 흐릴때 입으면 분위기 괜찮을 것 같아요 색은 아이보리만 있으니 참고하세요', SYSDATE, 0, 0, 4);
INSERT INTO REVIEW_IMAGE VALUES(12, 2, REVIEW_IMAGE_SEQ.nextval, 'review.png', SYSDATE);

INSERT INTO REVIEW VALUES(62, REVIEW_SEQ.nextval, '헤링본 울 롱 코트', 'drfish', '나름 쏘쏘한 코트', '차차 입어보면서 적응해야 할 것 같습니다 그래도 괜찮네요', SYSDATE, 0, 0, 3);
INSERT INTO REVIEW_IMAGE VALUES(62, 3, REVIEW_IMAGE_SEQ.nextval, 'review.png', SYSDATE);

INSERT INTO REVIEW VALUES(88, REVIEW_SEQ.nextval, '로제 핸드메이드 코트', 'zero', '환불 좀...', '배송시켰더니 오염이 묻어있습니다...', SYSDATE, 0, 0, 1);
INSERT INTO REVIEW_IMAGE VALUES(88, 4, REVIEW_IMAGE_SEQ.nextval, 'review.png', SYSDATE);

INSERT INTO REVIEW VALUES(20, REVIEW_SEQ.nextval, '오버핏 트렌치코트', 'Czam', '리뷰보고 샀습니다', '명불허전 골든키위ㅎㅎㅎ', SYSDATE, 0, 0, 5);
INSERT INTO REVIEW_IMAGE VALUES(20, 5, REVIEW_IMAGE_SEQ.nextval, 'review.png', SYSDATE);

INSERT INTO REVIEW VALUES(20, REVIEW_SEQ.nextval, '오버핏 트렌치코트', 'zero', '저는 좀...', '적당히 입을만한 정도?', SYSDATE, 0, 0, 3);
INSERT INTO REVIEW_IMAGE VALUES(20, 6, REVIEW_IMAGE_SEQ.nextval, 'review.png', SYSDATE);

INSERT INTO REVIEW VALUES(20, REVIEW_SEQ.nextval, '오버핏 트렌치코트', 'drfish', '착의샷을 좀 더 잘 찍어줬으면 좋겠습니다', '입어보니 다른 색 살 걸 그랬네요', SYSDATE, 0, 0, 3);
INSERT INTO REVIEW_IMAGE VALUES(20, 7, REVIEW_IMAGE_SEQ.nextval, 'review.png', SYSDATE);

--리뷰 댓글 샘플
INSERT INTO REVIEW_REPLY VALUES(1, 'admin', seq_review_reply.nextval, '리뷰 남겨주셔서 감사합니다. 앞으로도 멋진 제품들 준비하겠습니다!', sysdate);
INSERT INTO REVIEW_REPLY VALUES(1, 'Tester', seq_review_reply.nextval, '좋은 정보 얻고가요', sysdate);
INSERT INTO REVIEW_REPLY VALUES(5, 'BOSS', seq_review_reply.nextval, '우왕 혹시 제 리뷰 보신건가요?', sysdate);

update review set review_replyCount=(select count(*)from review_reply where review_num=1) where review_num=1;
update review set review_replyCount=(select count(*)from review_reply where review_num=5) where review_num=5;



--주문 샘플
insert into order_info values(seq_order_id.nextval,'dkxlffps','김지훈',5,100000,0,'김지훈','02','2245','1237',null,null,null,'01449','노해로','(도봉구)','한양아파트 6동 408호','일반배송','배송완료','문앞에 두고 가주세요','무통장입금','김지훈',null,null,'6개월',sysdate,60,1,null);

--qna 샘플
insert into q_notice values(qnotice_seq.nextval , '재입고 문의입니다.','상품문의','dkxlffps','내용','null.jpg',20,sysdate,qnotice_seq.currval , 0,0,0);
insert into q_notice values(qnotice_seq.nextval , '재입고 문의입니다.','상품문의','dkxlffps','내용','null.jpg',20,sysdate,1,1,1,0);
insert into q_notice values(seq_notice_qna_admin_id.nextval,'불건전한 닉네임 정지 목록','공지사항','admin','다들 주의해주시기 바랍니다.','null.jpg',455,sysdate,10,10,10,1);
insert into q_notice values(seq_notice_qna_admin_id.nextval,'새상품 입고 목록','공지사항','admin','많이 사가세요','null.jpg',786,sysdate,10,10,10,1);


--트리거
--create trigger product_salesrate
--after 
-- insert on order_info
-- for each row 
-- begin 
--    update product set pro_salesrate = pro_salesrate + :new.order_pro_quantity 
--    where 
--    pro_code = (select pro_code from product_detail where pro_detail_code = :new.order_pro_detail_code group by pro_code);
--end;
--
--create trigger total_buy_price
--after
--    insert on refund
--    for each row 
--begin
--   update member set member_total_buy = member_total_buy - (select order_price * order_pro_quantity from order_info 
--   where 
--   order_pro_detail_code = :new.pro_detail_code)
--   where member_name = :new.refund_name;
--   update order_info set order_price = 0 where order_pro_detail_code = :new.pro_detail_code;
--end;

COMMIT;

