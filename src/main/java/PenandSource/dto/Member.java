package PenandSource.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Map;


@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class Member {

    private int id;
    private String loginId;
    private String loginPw;
    private String name;
    private String email;

    public Member(Map<String, Object> selectRow) {
        this.id = (int) selectRow.get("id");
        this.loginId = (String) selectRow.get("loginId");
        this.loginPw = (String) selectRow.get("loginPw");
        this.name = (String) selectRow.get("name");
        this.email = (String) selectRow.get("email");

    }
}
