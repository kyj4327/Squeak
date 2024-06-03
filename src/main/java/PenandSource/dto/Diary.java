package PenandSource.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

import java.util.Map;

@Data
@AllArgsConstructor
@ToString
public class Diary {

    private int id;
    private String regDate;
    private String updateDate;
    // 로그인한 유저아이디
    private int memberId;
    private String title;
    private String content;
    private String stupidCost;
    private String diet;

    private String writerName;

    public Diary(Map<String, Object> selectRow) {
        this.id = (int) selectRow.get("id");
        this.regDate = (String) selectRow.get("regDate");

        this.memberId = (int) selectRow.get("memberId");

        this.updateDate = (String) selectRow.get("updateDate");
        this.title = (String) selectRow.get("title");
        this.content = (String) selectRow.get("content");
        this.stupidCost = (String) selectRow.get("stupidCost");
        this.diet = (String) selectRow.get("diet");
        this.writerName = (String) selectRow.get("writerName");

        // 로그인 없이 글 작성 가능하게 하기
//        if (selectRow.get("writerName") != null) {
//            this.writerName = (String) selectRow.get("writerName");
//        }
    }
}
