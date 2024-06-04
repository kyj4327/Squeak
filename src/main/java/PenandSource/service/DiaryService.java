package PenandSource.service;

import PenandSource.dto.Diary;
import PenandSource.dto.ResultData;
import PenandSource.repository.DiaryRepository;
import PenandSource.util.Ut;

import java.util.List;
//충돌부분 commit

public class DiaryService {
    private DiaryRepository diaryRepository;

    public DiaryService() {
        diaryRepository = new DiaryRepository();
    }

    //페이지
    public int getItemInAPage() {
        return 10;
    }
    public int getForPrintListTotalPage() {
        int itemInAPage = getItemInAPage();

        int totalCount = diaryRepository.getTotalCount();
        int totalPage = (int)Math.ceil((double) totalCount / itemInAPage);

        return totalPage;
    }

    public List<Diary> getForPrintDiaries(int page) {
        int itemInAPage = getItemInAPage();
        int limitFrom = (page - 1) * itemInAPage;

        List<Diary> diaries = diaryRepository.getForPrintDiaries(itemInAPage, limitFrom);

        return diaries;
    }


    public ResultData write(int loginedMemberId, String updateDate, String title, String content, String stupidCost, String diet) {
        int id = diaryRepository.write(loginedMemberId, updateDate, title, content,stupidCost, diet);
        return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다.", id), "id", id);
    }

    public Diary getForPrintDiaryByID(int id) {
        return diaryRepository.getForPrintDiaryById(id);
    }

    public ResultData delete(int id) {
        diaryRepository.delete(id);


        return ResultData.from("S-1", Ut.f("%d번 일기 삭제되었습니다.", id), "id", id);
    }

    public ResultData actorCanDelete(int loginedMemberId, Diary diary) {

        // 삭제 권한 아닌 경우 -> 게시자가 아닌 경우

        // 로그인 아이디 와 게시글의 아이디가 같은가
        if (loginedMemberId != diary.getMemberId()) {
            return ResultData.from("F-1","권한이 없습니다.");
        }
        return ResultData.from("S-1", "삭제되었습니다.");
    }
}
