package PenandSource.servelet;

import PenandSource.Rq;
import PenandSource.util.MysqlUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user/member/doLogout")
public class UsrMemberDoLogOutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MysqlUtil.setDBInfo("localhost", "root", "", "Squeak");
        MysqlUtil.setDevMode(true);

        Rq rq = new Rq(req, resp);

        HttpSession session = req.getSession();
        session.removeAttribute("loginedMemberId");

        rq.print("""
                <script>
                  alert('오늘 하루도 수고하셨습니다.');
                  location.replace('/home/main');
                </script>
                """);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}

