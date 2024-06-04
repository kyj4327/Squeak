package PenandSource.controller;

import PenandSource.Rq;
import PenandSource.dto.BucketList;
import PenandSource.dto.ResultData;
import PenandSource.service.BucketListService;
import PenandSource.service.MemberService;
import jakarta.servlet.http.HttpSession;

import java.util.List;

public class UserBuketListController extends Controller{

    private BucketListService bucketListService;
    private MemberService memberService;

    public UserBuketListController() {
        bucketListService = new BucketListService();
    }

    @Override
    public void performAction(Rq rq) {
        switch (rq.getActionMethodName()) {
            case "list" -> showList(rq);
            case "write" -> showWrite(rq);
            case "doWrite" -> actionWrite(rq);
            default -> rq.println("존재하지 않는 페이지 입니다.");
        }
    }

    public void showList(Rq rq) {

        int page = rq.getIntParam("page", 1);

        int totalPage = bucketListService.getForPrintListTotalPage();

        List<BucketList> bucketLists = bucketListService.getForPrintbucketLists(page);

        rq.setAttr("bucketLists", bucketLists);
        rq.setAttr("page", page);
        rq.setAttr("totalPage", totalPage);

        rq.jsp("bucketlist/list");
    }

    public void showWrite(Rq rq) {
        rq.jsp("bucketlist/write");
    }

    public void actionWrite(Rq rq) {
        String content = rq.getParam("content", "");

        // 리다이렉트 -> 리스트로 보내준다.
        String redirectURI = rq.getParam("redirectURI", "../bucketlist/list");

        if (content.length() == 0) {
            rq.historyBack("내용을 입력해주세요");
            return;
        }

        HttpSession session = rq.getSession();

        if(session.getAttribute("loginedMemberId") == null) {
            rq.replace("로그인 후 이용해주세요.", "../member/login");
            return;
        }

        int loginedMemberId = (int)session.getAttribute("loginedMemberId");

        ResultData writeRd = bucketListService.write(loginedMemberId, content);
        int id = (int) writeRd.getBody().get("id");
        redirectURI = redirectURI.replace("list",  "list");


        rq.replace(writeRd.getMsg(), redirectURI);

        }
}
