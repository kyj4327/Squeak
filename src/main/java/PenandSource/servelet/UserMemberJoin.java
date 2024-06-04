package PenandSource.servelet;

import PenandSource.Rq;
import PenandSource.util.MysqlUtil;
import PenandSource.util.SecSql;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user/member/doJoin")
public class UserMemberJoin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MysqlUtil.setDBInfo("localhost", "root", "1234", "squeak");
        MysqlUtil.setDevMode(true);

        Rq rq = new Rq(req, resp);

        String loginId = rq.getParam("loginId", "");
        String loginPw = rq.getParam("loginPw", "");
        String name = rq.getParam("name", "");
        String email = rq.getParam("email", "");

        // 중복아이디 확인
        SecSql sql = new SecSql();
        sql.append("SELECT COUNT(*) AS cnt");
        sql.append("FROM `member`");
        sql.append("WHERE loginId = ?", loginId);

        boolean isJoinAvailableLoginId = MysqlUtil.selectRowIntValue(sql) == 0;

        if(isJoinAvailableLoginId == false) {
            rq.print("""
          <script>
            alert('%s(은)는 이미 가입된 아이디입니다.');
            history.back();
          </script>
          """.formatted(loginId));
        }

        // 중복 이메일 확인
        sql = new SecSql();
        sql.append("SELECT COUNT(*) AS cnt");
        sql.append("FROM `member`");
        sql.append("WHERE email = ?", email);

        boolean isJoinAvailableEmail = MysqlUtil.selectRowIntValue(sql) == 0;

        if(isJoinAvailableEmail == false) {
            rq.print("""
          <script>
            alert('%s(은)는 이미 가입된 이메일입니다.');
            history.back();
          </script>
          """.formatted(email));
        }

        sql = new SecSql();
        sql.append("INSERT INTO `member`");
        sql.append("SET loginId = ?", loginId);
        sql.append(", loginPw = ?", loginPw);
        sql.append(", name = ?", name);
        sql.append(", email = ?", email);

        int id = MysqlUtil.insert(sql);
        rq.print("""
          <script>
            alert('%d번 회원이 생성되었습니다.');
            location.replace('/home/main');
          </script>
          """.formatted(id, id));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}