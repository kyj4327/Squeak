package PenandSource.controller;

import PenandSource.Rq;
import PenandSource.dto.ResultData;
import PenandSource.service.MemberService;

public class UserMemberController extends Controller {

    private MemberService memberService;

    public UserMemberController() {
        memberService= new MemberService();
    }

    @Override
    public void performAction(Rq rq) {
        switch (rq.getActionMethodName()) {
            case "join" -> showJoin(rq);
            case "doJoin" -> actionJoin(rq);
            case "login" -> showLogin(rq);
            case "doLogin" -> actionDoLogin(rq);
            default -> rq.println("존재하지 않는 페이지 입니다.");
        }
    }

    private void actionDoLogin(Rq rq) {

    }

    private void showLogin(Rq rq) {

    }

    private void actionJoin(Rq rq) {

        String loginId = rq.getParam("loginId", "");
        String loginPw = rq.getParam("loginPw", "");
        String name = rq.getParam("name", "");
        String email = rq.getParam("email", "");

        // 로그인 완성 후 어디로 보낼지 정하기.
        String redirectURI = rq.getParam("redirectURI", "../diary/list");

        // 유효성체크
        if (loginId.length() == 0) {
            rq.historyBack("아이디를 입력해주세요.");
        }
        if (loginPw.length() == 0) {
            rq.historyBack("비밀번호를 입력해주세요.");
        }
        if (name.length() == 0) {
            rq.historyBack("이름을 입력해주세요.");
        }
        if (email.length() == 0) {
            rq.historyBack("email 입력해주세요.");
        }

        ResultData joinRd = memberService.join(loginId, loginPw, name, email);

        rq.replace(joinRd.getMsg(),redirectURI);
    }
    private void showJoin(Rq rq) {
        rq.jsp("member/join");
    }
}
