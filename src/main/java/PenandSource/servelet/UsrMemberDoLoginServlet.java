package PenandSource.servelet;

import PenandSource.Rq;
import PenandSource.util.MysqlUtil;
import PenandSource.util.SecSql;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

@WebServlet("/user/member/doLogin")
public class UsrMemberDoLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MysqlUtil.setDBInfo("localhost", "root", "1234", "Squeak");
        MysqlUtil.setDevMode(true);

        Rq rq = new Rq(req, resp);

//        String loginId = rq.getParam("loginId", "");
//        String loginPw = rq.getParam("loginPw", "");
//
//        // loginId 있는지 확인하기
//        SecSql sql = new SecSql();
//        sql.append("SELECT*");
//        sql.append("FROM `member`");
//        sql.append("WHERE loginId = ?", loginId);

        String loginId = rq.getParam("loginId", "");
        String loginPw = rq.getParam("loginPw", "");

        SecSql sql = new SecSql();
        sql.append("SELECT*");
        sql.append("FROM `member`");
        sql.append("WHERE loginId = ?", loginId);

        Map<String, Object> memberRow = MysqlUtil.selectRow(sql);

        if (memberRow.isEmpty()) {
            rq.print("""
                    <script>
                      alert('잘못 입력하셨습니다.');
                      history.back();
                    </script>
                    """);
        }
        // map -> object 받았으니 string 형변환으로 비교
        if (((String) memberRow.get("loginPw")).equals(loginPw) == false) {
            rq.print("""
                    <script>
                      alert('잘못 입력하셨습니다.');
                      history.back();
                    </script>
                    """);
        }

        // 세션에 현재 로그인한 정보를 담기 위해서
        HttpSession session = req.getSession();
        session.setAttribute("loginedMemberId", memberRow.get("id"));
        // -> id -> name으로 수정해서 이름으로 뽑는걸로 바꾸기.
        //(String) memberRow.get("loginPw")).equals(loginPw) == true

        if ((((String) memberRow.get("loginId")).equals(loginId) == true)&&
                (((String) memberRow.get("loginPw")).equals(loginPw) == true)) {
            rq.print("""
                    <script>
                      alert('로그인 되었습니다.');
                      location.replace('/home/main');
                    </script>
                    """);
        }
        // 뒤로가서 로그인 계속 시도하면 안되니까 history.back X -> 바로 홈으로 replace
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}

