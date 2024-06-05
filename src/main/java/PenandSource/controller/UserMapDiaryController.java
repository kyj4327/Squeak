package PenandSource.controller;

import PenandSource.Rq;
import PenandSource.dto.BucketList;
import PenandSource.dto.MapDiary;
import PenandSource.dto.ResultData;
import PenandSource.service.MapDiaryService;
import jakarta.servlet.http.HttpSession;

import java.util.List;

public class UserMapDiaryController extends Controller{

    private MapDiaryService mapDiaryService;

    public UserMapDiaryController() {
        mapDiaryService = new MapDiaryService();
    }

    @Override
    public void performAction(Rq rq) {
        switch (rq.getActionMethodName()) {

            // 맵에 쓰면 바로 쓴내용 보이기, 삭제 가능하기 구현X
            case "list" -> showList(rq);
            case "detail" -> showDetail(rq);
            case "write" -> showWrite(rq);
            case "doWrite" -> actionWrite(rq);
//            case "doDelete" -> actionDelete(rq);

            default -> rq.println("존재하지 않는 페이지 입니다.");
        }
    }

    public void showList(Rq rq) {

        int page = rq.getIntParam("page", 1);

        int totalPage = mapDiaryService.getForPrintListTotalPage();

        List<MapDiary> mapDiaries = mapDiaryService.getForPrintmapDiaries(page);

        rq.setAttr("mapDiaries", mapDiaries);
        rq.setAttr("page", page);
        rq.setAttr("totalPage", totalPage);

        rq.jsp("mapdiary/list");
    }

    public void showDetail(Rq rq) {

        int id = rq.getIntParam("id", 0);

        if(id == 0) {
            rq.historyBack("잘못된 요청입니다");
            return;
        }

        MapDiary mapDiary = mapDiaryService.getForPrintMapDiaryByID(id);

        if (mapDiary == null) {
            rq.historyBack("잘못된 요청입니다");
        }

        rq.setAttr("mapDiary", mapDiary);

        rq.jsp("mapdiary/detail");
    }

    public void showWrite(Rq rq) {
        rq.jsp("mapdiary/write");
    }

    public void actionWrite(Rq rq) {
        String title = rq.getParam("title", "");
        String content = rq.getParam("content", "");
//        String address = rq.getParam("address", "");
        String lat = rq.getParam("lat", "");
        String lng = rq.getParam("lat", "");

        // 리다이렉트 -> 리스트로 보내준다.
        String redirectURI = rq.getParam("redirectURI", "../mapdiary/list");

        if (title.length() == 0) {
            rq.historyBack("추억 제목을 입력해주세요.");
            return;
            }

        if (content.length() == 0) {
            rq.historyBack("추억 내용을 입력해주세요");
            return;
        }

//        if (address.length() == 0) {
//            rq.historyBack("추억의 주소를 입력해주세요");
//            return;
//        }

        HttpSession session = rq.getSession();

        if(session.getAttribute("loginedMemberId") == null) {
            rq.replace("로그인 후 이용해주세요.", "../member/login");
            return;
        }

        int loginedMemberId = (int)session.getAttribute("loginedMemberId");

        ResultData writeRd = mapDiaryService.write(loginedMemberId, title, content, lat, lng);

//        int id = (int) writeRd.getBody().get("id"); // 기본적으로 Object 타입이라서 Int 형변환

        // getBody 에 들어온 Id 를 같이 넘겨준다.
//        redirectURI = redirectURI.replace("newID", id + ""); // 해당 게시글 내용으로 이동

//        rq.replace(writeRd.getMsg(), redirectURI);

//        rq.print("""
//          <script>
//            alert('%d번 고객님의 추억의 장소가 저장되었습니다.');
//            location.replace('detail?id=%d');
//          </script>
//          """.formatted(loginedMemberId, id));

        redirectURI = redirectURI.replace("list",  "list");


        rq.replace(writeRd.getMsg(), redirectURI);
        }





//    public void actionDelete(Rq rq) {
//        int id = rq.getIntParam("id", 0);
//        String redirectURI = rq.getParam("redirectURI", "../mapDiary/list");
//
//        if (id == 0) {
//            rq.historyBack("잘못된 요청입니다." );
//            return;
//        }
//
//        MapDiary mapDiary = mapDiaryService.getForPrintDiaryByID(id);
//
//        // 로그인해서 해당 유저만 삭제 가능
//        HttpSession session = rq.getSession();
//
//        if(session.getAttribute("loginedMemberId") == null) {
//            rq.replace("로그인 후 이용해주세요.", "../member/login");
//            return;
//        }
//
//        int loginedMemberId = (int)session.getAttribute("loginedMemberId");
//
//        ResultData actorCanDeleteRd = mapDiaryService.actorCanDelete(loginedMemberId, diary);
//
//        if (actorCanDeleteRd.isFail()) {
//            rq.historyBack(actorCanDeleteRd.getMsg());
//            return;
//        }
//
//
//        if (mapDiary == null) {
//            rq.historyBack("없는 게시물입니다.");
//            return;
//        }
//
//        ResultData deleteRd = mapDiaryService.delete(id);
//
//
//        rq.replace(deleteRd.getMsg(),redirectURI);
//    }
}
