show databases;

DROP DATABASE IF EXISTS Squeak;
CREATE DATABASE Squeak2;

USE Squeak2;

#일기 테이블 생성
CREATE TABLE diary(
                      id INT(10) UNSIGNED NOT NULL PRIMARY KEY auto_increment,
                      regDate DATETIME NOT NULL,  # 글 등록일
                      updateDate DATETIME NOT NULL, #사용자 지정일로 변경하기
                      title CHAR(200) NOT NULL,
                      content LONGTEXT NOT NULL,
                      stupidCost LONGTEXT,
                      diet LONGTEXT
);

# 일기 테이블에 멤버 아이디 넣기
ALTER TABLE diary Add COLUMN memberId Int(10) UNSIGNED NOT NULL AFTER  regDate;


drop table diary;
drop table member;

# 테스트 게시물
INSERT INTO diary
SET regDate = NOW(),
    updateDate=NOW(),
    title='일기1',
    content='일기내용1',
    stupidCost='늦잠택시 3000원',
    memberId=1;

INSERT INTO diary
SET regDate = NOW(),
    updateDate=NOW(),
    title='일기2',
    content='일기내용2',
    stupidCost='화내서 아이스크림 3000원',
    diet ='맥도날드 빅맥',
    memberId=1;


INSERT INTO diary
SET regDate = NOW(),
    updateDate=NOW(),
    title='일기3',
    content='일기내용3';

SELECT * FROM diary;

# 우리 서비스에서 bigInt 는 사치라 생각해서 int
CREATE TABLE member(
                       loginId CHAR(200) NOT NULL unique,
                       loginPw char(100) NOT NULL,
                       name char(100) not null ,
                       email char(100) NOT NULL unique,
);

# 일기에 작성자 추가.
SELECT D.*, M.name AS writerName
FROM diary AS D
         INNER JOIN member as M
                    on D.memberId = M.id
order by id DESC;

SELECT * FROM member;

SELECT * FROM diary;


# 유저테이블 삭제
drop table member;

drop table diary;

# 게시글 1번 아이디가 작성했다 가정
update diary
set memberId = 1
where memberid=0;

# 맵다이어리
CREATE TABLE mapDiary(
                         id INT(10) UNSIGNED NOT NULL PRIMARY KEY auto_increment,
                         title CHAR(200) NOT NULL,
                         content LONGTEXT NOT NULL,
                         lat double(10,6) NOT NULL,
                         lng double(10,6) NOT NULL
);

ALTER TABLE mapDiary Add COLUMN memberId Int(10) UNSIGNED NOT NULL;

SELECT * FROM mapDiary;

drop table mapDiary;



CREATE TABLE bucketList(
                           id INT(10) UNSIGNED NOT NULL PRIMARY KEY auto_increment,
                           content LONGTEXT NOT NULL
);
ALTER TABLE bucketList Add COLUMN memberId Int(10) UNSIGNED NOT NULL;

