package PenandSource.servelet;

import PenandSource.Rq;
import PenandSource.util.SecSql;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/home/main")
public class HomeMainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Rq rq = new Rq(req, resp);

        HttpSession session = req.getSession();

        boolean isLogined = false;
        int loginedMemberId = -1; // -1 = 없다.
//        Map<String, Object> loginedMemberRow = null;

        // null = 로그인 안되었다면
        if(session.getAttribute("loginedMemberId") != null) {
            loginedMemberId = (int) session.getAttribute("loginedMemberId");
            isLogined = true;

            SecSql sql = new SecSql();
            sql.append("SELECT * FROM 'member'");
            sql.append("WHERE id =?", loginedMemberId);
//            loginedMemberRow = MysqlUtil.selectRow(sql);
        }

        // rq에 로그인 여부를 넘겨 -> Home.main.jsp 에서 불러서 사용 가능
        rq.setAttr("isLogined", isLogined);
        rq.setAttr("loginedMemberId", loginedMemberId);
//        rq.setAttr("loginedMemberRow", loginedMemberRow);

        rq.jsp("home/main");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
