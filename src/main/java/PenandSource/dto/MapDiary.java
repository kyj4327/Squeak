package PenandSource.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

import java.util.Map;

@Data
@AllArgsConstructor
@ToString
public class MapDiary {
// 주소 제목 내용 파일 마커이미지주소
    private int id;
//    private double address;
    private double lat; // 위도
    private double lng; // 경도

    private String title;
    private String content;


    // 로그인한 유저아이디
    private int memberId;

    public MapDiary(Map<String, Object> selectRow) {
        this.id = (int) selectRow.get("id");
//        this.address = (String) selectRow.get("address");
        this.memberId = (int) selectRow.get("memberId");
        this.title = (String) selectRow.get("title");
        this.content = (String) selectRow.get("content");
        this.lat = (double) selectRow.get("lat");
        this.lng = (double) selectRow.get("lng");
        }
}

/*
- 주소 검색
address  getAdd()

- 제목 입력
title  getTitle

- 내용 입력
content getText()

- 사진 첨부
fileInput fileContent


 */

/*
     id INT(10) UNSIGNED NOT NULL PRIMARY KEY auto_increment,
                      title CHAR(200) NOT NULL,
                      content LONGTEXT NOT NULL,
                      lat double(10,6) NOT NULL,
                      lng double(10,6) NOT NULL
 */