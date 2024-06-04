package PenandSource.repository;

import PenandSource.dto.Member;
import PenandSource.util.MysqlUtil;
import PenandSource.util.SecSql;

import java.util.List;

public class MemberRepository {
    private List<Member> members;


    public Member getMemberByLoginId(String loginId) {

        SecSql sql = new SecSql();
        sql.append("SELECT M.*");
        sql.append("FROM member AS M");
        sql.append("WHERE M.loginId = ?", loginId);

        return new Member(MysqlUtil.selectRow(sql));
    }

    public Member getMemberByNameAndEmail(String name, String email) {

        SecSql sql = new SecSql();
        sql.append("SELECT M.*");
        sql.append("FROM member AS M");
        sql.append("WHERE M.name = ?", name);
        sql.append("AND M.email = ?", email);
        sql.append("LIMIT 1"); // 둘중에 하나만 있으면 된다.

        return new Member(MysqlUtil.selectRow(sql));
    }

    public int join(String loginId, String loginPw, String name, String email) {

        SecSql sql = new SecSql();
        sql.append("INSERT INTO `member`");
        sql.append("SET loginId = ?", loginId);
        sql.append(", loginPw = ?", loginPw);
        sql.append(", name = ?", name);
        sql.append(", email = ?", email);

        int id = MysqlUtil.insert(sql);

        return id;
    }

    public String getWriteNameByBoardID(int memberId) {
        for(Member member : members) {
            if (member.getId() == memberId) {
                return member.getLoginId();
            }
        }
        return "";
    }
}
