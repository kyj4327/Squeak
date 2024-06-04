package PenandSource.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

import java.util.Map;

@Data
@AllArgsConstructor
@ToString
public class BucketList {

    // 내용 입력 -> 내용 바로 출력 제목 없음
    private int id;
    private String content;

    // 로그인한 유저아이디
    private int memberId;

    private String writerName;


    public BucketList(Map<String, Object> selectRow) {
        this.id = (int) selectRow.get("id");
        this.memberId = (int) selectRow.get("memberId");
        this.content = (String) selectRow.get("content");
        this.writerName = (String) selectRow.get("writerName");

    }
}

/*

todolist 형식
-> 내용 입력하고 누르면 제목없이 내용 바로 저장
-> 저장된 내용을 바로 글보기 형식으로 표현
-> 근데 글보기 옆 상자 체크시 중간줄 그어서 완성함을 표현.


- 내용 입력
content getText()


 */