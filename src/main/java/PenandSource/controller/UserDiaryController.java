package PenandSource.controller;

import PenandSource.Rq;
import PenandSource.dto.Diary;
import PenandSource.dto.ResultData;
import PenandSource.service.DiaryService;
import PenandSource.util.Ut;
import jakarta.servlet.http.HttpSession;

import java.util.List;

public class UserDiaryController extends Controller{

    private DiaryService diaryService;

    public UserDiaryController() {
        diaryService = new DiaryService();
    }

    @Override
    public void performAction(Rq rq) {
        switch (rq.getActionMethodName()) {
            case "list" -> showList(rq);
            case "detail" -> showDetail(rq);
            case "write" -> showWrite(rq);
            case "doWrite" -> actionWrite(rq);
            case "modify" -> showModify(rq);
            case "doModify" -> actionModify(rq);
            case "doDelete" -> actionDelete(rq);
            default -> rq.println("존재하지 않는 페이지 입니다.");
        }
    }

    public void showList(Rq rq) {

        int page = rq.getIntParam("page", 1);

        int totalPage = diaryService.getForPrintListTotalPage();

//        List<Map<String, Object>> diaryRows = diaryService.getDiaryRows(page);
        List<Diary> diaries = diaryService.getForPrintDiaries(page);

        rq.setAttr("diaries", diaries);
        rq.setAttr("page", page);
        rq.setAttr("totalPage", totalPage);

        rq.jsp("diary/list");
    }



    public void showDetail(Rq rq) {

        int id = rq.getIntParam("id", 0);

        if(id == 0) {
            rq.historyBack("잘못된 요청입니다");
            return;
        }

        Diary diary = diaryService.getForPrintDiaryByID(id);

        if (diary == null) {
            rq.historyBack("잘못된 요청입니다");
        }

        rq.setAttr("diary", diary);

        rq.jsp("diary/detail");
    }

    public void showWrite(Rq rq) {
        rq.jsp("diary/write");
    }

    public void actionWrite(Rq rq) {
        String title = rq.getParam("title", "");
        String content = rq.getParam("content", "");
        String stupidCost = rq.getParam("stupidCost", "");
        String diet = rq.getParam("diet", "");

        // 리다이렉트 -> 리스트로 보내준다.
//        String redirectURI = rq.getParam("redirectURI", "../diary/list");
        String redirectURI = rq.getParam("redirectURI", "../diary/list");


        if (title.length() == 0) {
            rq.historyBack("제목을 입력해주세요.");
            return;
            }

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

        ResultData writeRd = diaryService.write(loginedMemberId, title, content,stupidCost,diet);
        int id = (int) writeRd.getBody().get("id");
//        redirectURI = redirectURI.replace("[NEW_ID]", id + ""); // 해당 게시글 내용으로 이동
//        redirectURI = redirectURI.replace("list", id + ""); // Id 지정해주면 해당 게시글로 이동 -> 우리는 그냥 게시글목록으로 바로 넘겨
        redirectURI = redirectURI.replace("list",  "list");


        rq.replace(writeRd.getMsg(), redirectURI);

//        System.out.println("성공 여부: " + writeRd.getResultCode());
//        System.out.println("메시지 : " + writeRd.getMsg());
//        rq.replace(writeRd.getMsg(), "list");


        /**
         *  If문으로 입력받은 제목 내용이 없으면 입력 안되게하기 추가한것.,
         */
//        if ((title.length() != 0) && (content.length() != 0)) {

//
//             id 기준으로 등록  --> 일기 적고 해당 일기 상세 내용이 아니라 list로 날리기
//            int id = MysqlUtil.insert(sql);
        }

    public void showModify(Rq rq) {
        int id = rq.getIntParam("id", 0);

        if(id == 0) {
            rq.historyBack("잘못된 요청입니다.");
            return;
        }
        HttpSession session = rq.getSession();

        // 로그인 안하면 수정 불가하게
        if(session.getAttribute("loginedMemberId") == null) {
            rq.replace("로그인 후 이용해주세요.", "../member/login");
            return;
        }

        // 로그인한 아이디 불러오기 -> 로그인한 아아디 기준으로 수정가능하게 하기
        int loginedMemberId = (int)session.getAttribute("loginedMemberId");

        Diary diary = diaryService.getForPrintDiaryByID(id);

        if (diary == null) {
            rq.historyBack(Ut.f("%번 게시물이 존재하지 않습니다.", id));
        }

        // 해당 게시글은 해당 게시글 작성자만 수정 가능하게 구현하기
        ResultData actorCanModifyRd = diaryService.actorCanModify(loginedMemberId, diary);

        if (actorCanModifyRd.isFail()) {
            rq.historyBack(actorCanModifyRd.getMsg());
            return;
        }

        rq.setAttr("diary", diary);

        rq.jsp("diary/modify");
    }

    public void actionModify(Rq rq) {
        int id = rq.getIntParam("id", 0);

        String title = rq.getParam("title", "");
        String content = rq.getParam("content", "");
        String stupidCost = rq.getParam("stupidCost", "");
        String diet = rq.getParam("diet", "");

        // 리다이렉트 -> 리스트로 보내준다. (
        String redirectURI = rq.getParam("redirectURI", Ut.f("../diary/detail?id=%d", id));

        // 유효성 검사_제목 없으면 탈락
        if (title.length() == 0) {
            rq.historyBack("제목을 입력해주세요");
            return;
        }

        // 유효성 검사_내용 없으면 탈락
        if (content.length() == 0) {
            rq.historyBack("내용을 입력해주세요");
            return;
        }

        if(id == 0) {
            rq.historyBack("잘못된 요청입니다.");
            return;
        }

        // 로그인 기능 아이디 체크 시작
        Diary diary = diaryService.getForPrintDiaryByID(id);

        HttpSession session = rq.getSession();

        // 로그인 안하면 수정 불가하게
        if(session.getAttribute("loginedMemberId") == null) {
            rq.replace("로그인 후 이용해주세요.", "../member/login");
            return;
        }

        int loginedMemberId = (int)session.getAttribute("loginedMemberId");

        // 해당 게시글은 해당 게시글 작성자만 수정 가능하게 구현하기
        ResultData actorCanModifyRd = diaryService.actorCanModify(loginedMemberId, diary);

        if (actorCanModifyRd.isFail()) {
            rq.historyBack(actorCanModifyRd.getMsg());
            return;
        }

        // 수정할 값들 변수로 지정 -> 일기는 변경 불가
        ResultData modifyRd = diaryService.modify(id, title, content, stupidCost, diet);

        rq.replace(modifyRd.getMsg(),redirectURI);
    }

    public void actionDelete(Rq rq) {
        int id = rq.getIntParam("id", 0);
        String redirectURI = rq.getParam("redirectURI", "../diary/list");

        if (id == 0) {
            rq.historyBack("잘못된 요청입니다." );
            return;
        }

        Diary diary = diaryService.getForPrintDiaryByID(id);

        // 로그인해서 해당 유저만 삭제 가능
        HttpSession session = rq.getSession();

        if(session.getAttribute("loginedMemberId") == null) {
            rq.replace("로그인 후 이용해주세요.", "../member/login");
            return;
        }

        int loginedMemberId = (int)session.getAttribute("loginedMemberId");

        ResultData actorCanDeleteRd = diaryService.actorCanDelete(loginedMemberId, diary);

        if (actorCanDeleteRd.isFail()) {
            rq.historyBack(actorCanDeleteRd.getMsg());
            return;
        }


        if (diary == null) {
            rq.historyBack("없는 게시물입니다.");
            return;
        }

        ResultData deleteRd = diaryService.delete(id);


        rq.replace(deleteRd.getMsg(),redirectURI);
    }
}
