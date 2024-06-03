package PenandSource.servelet;

import PenandSource.Rq;
import PenandSource.controller.UserDiaryController;
import PenandSource.controller.UserHomeController;
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


// 공통적 사항 넣어주는 것 - DispatcherServlet
@WebServlet("/user/*")
public class DispatcherServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        MysqlUtil.setDBInfo("localhost", "root", "1234", "squeak");
        MysqlUtil.setDevMode(true);

        Rq rq = new Rq(req, resp);


        // 로그 보기 위한 print
//        System.out.printf("%s/%s/%s\n", controllerTypeName, controllerName, actionMethodName);


        // 모든 요청 들어가기 전에 실행되어야하는 실행문 -->

        HttpSession session = req.getSession();

        boolean isLogined = false;
        int loginedMemberId = -1; // -1 = 없다.
        Map<String, Object> loginedMemberRow = null;

        // null = 로그인 안되었다면
        if(session.getAttribute("loginedMemberId") != null) {
            loginedMemberId = (int) session.getAttribute("loginedMemberId");
            isLogined = true;

            SecSql sql = new SecSql();
            sql.append("SELECT * FROM `member`");
            sql.append("WHERE id = ?", loginedMemberId);
            loginedMemberRow = MysqlUtil.selectRow(sql);
        }

        // rq에 로그인 여부를 넘겨 -> Home.main.jsp 에서 불러서 사용 가능
        rq.setAttr("isLogined", isLogined); // 로그인 유무
        rq.setAttr("loginedMemberId", loginedMemberId);
        rq.setAttr("loginedMemberRow", loginedMemberRow);

        // 모든 요청 들어가기 전에 실행되어야하는 실행문 끝  <--


        switch (rq.getControllerTypeName()) {
            case "user"
                    -> {
                UserHomeController userHomeController = new UserHomeController();
                UserDiaryController userDiaryController = new UserDiaryController();

                switch (rq.getControllerName()) {
                    case "home" -> userHomeController.performAction(rq);
                    case "diary" -> userDiaryController.performAction(rq);
                }
            }
        }
        MysqlUtil.closeConnection();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
