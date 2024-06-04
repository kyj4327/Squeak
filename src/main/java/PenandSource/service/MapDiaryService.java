package PenandSource.service;

import PenandSource.dto.MapDiary;
import PenandSource.dto.ResultData;
import PenandSource.repository.MapDiaryRepository;
import PenandSource.util.Ut;

public class MapDiaryService {

    private MapDiaryRepository mapDiaryRepository;

    public MapDiaryService() {
        mapDiaryRepository = new MapDiaryRepository();
    }

//    //페이지 네이션
//    public int getItemInAPage() {
//        return 10;
//    }
//
//    public int getForPrintListTotalPage() {
//        int itemInAPage = getItemInAPage();
//
//        int totalCount = mapDiaryRepository.getTotalCount();
//        int totalPage = (int)Math.ceil((double) totalCount / itemInAPage);
//
//        return totalPage;
//    }
//
//    public List<MapDiary> getForPrintDiaries(int page) {
//        int itemInAPage = getItemInAPage();
//        int limitFrom = (page - 1) * itemInAPage;
//
//        List<MapDiary> mapDiaries = mapDiaryRepository.getForPrintDiaries(itemInAPage, limitFrom);
//
//        return mapDiaries;
//    }
//    //페이지 네이션


    public ResultData write(int loginedMemberId, String title, String content, String lat, String lng) {
        int id = mapDiaryRepository.write(loginedMemberId, title, content,lat,lng);
        return ResultData.from("S-1", Ut.f("%d번 추억이 생성되었습니다.", id), "id", id);
    }

    public MapDiary getForPrintMapDiaryByID(int id) {
        return mapDiaryRepository.getForPrintMapDiaryById(id);
    }

}
