package PenandSource.servelet;

import PenandSource.Rq;
import PenandSource.controller.UserBuketListController;
import PenandSource.controller.UserDiaryController;
import PenandSource.controller.UserHomeController;
import PenandSource.controller.UserMapDiaryController;
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

        MysqlUtil.setDBInfo("localhost", "root", "", "squeak");
        MysqlUtil.setDevMode(true);

        Rq rq = new Rq(req, resp);


        // 로그 보기 위한 print
//        System.out.printf("%s/%s/%s\n", controllerTypeName, controllerName, actionMethodName);


        // 모든 요청 들어가기 전에 실행되어야하는 실행문 start-->
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

        // 모든 요청 들어가기 전에 실행되어야하는 실행문 끝 end <--


        switch (rq.getControllerTypeName()) {
            case "user"
                    -> {
                UserHomeController userHomeController = new UserHomeController();
                UserDiaryController userDiaryController = new UserDiaryController();
                UserMapDiaryController userMapDiaryController = new UserMapDiaryController();
                UserBuketListController userBuketListController = new UserBuketListController();

                switch (rq.getControllerName()) {
                    case "home" -> userHomeController.performAction(rq);
                    case "diary" -> userDiaryController.performAction(rq);
                    // mapDiary -> 이슈 발생 = mapdiary 로 한번이상 접속시 쿠키에 남아서 브라우져가 값을 계속 소문자로 변경한다 애초에 소문자로 바꿈
                    case "mapdiary" -> userMapDiaryController.performAction(rq);
                    // bucketList -> 이슈 발생 = bucketlist 로 한번이상 접속시 쿠키에 남아서 브라우져가 값을 계속 소문자로 변경한다 애초에 소문자로 바꿈
                    case "bucketlist" -> userBuketListController.performAction(rq);
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
