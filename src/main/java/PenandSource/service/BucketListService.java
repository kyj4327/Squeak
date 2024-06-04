package PenandSource.service;

import PenandSource.dto.BucketList;
import PenandSource.dto.ResultData;
import PenandSource.repository.BuketListRepository;
import PenandSource.util.Ut;

import java.util.List;

public class BucketListService {

    private BuketListRepository buketListRepository;

    public BucketListService() {
        buketListRepository = new BuketListRepository();
    }

    //페이지
    public int getItemInAPage() {
        return 10;
    }
    public int getForPrintListTotalPage() {
        int itemInAPage = getItemInAPage();

        int totalCount = buketListRepository.getTotalCount();
        int totalPage = (int)Math.ceil((double) totalCount / itemInAPage);

        return totalPage;
    }

    public List<BucketList> getForPrintbucketLists(int page) {
        int itemInAPage = getItemInAPage();
        int limitFrom = (page - 1) * itemInAPage;

        List<BucketList> bucketLists = buketListRepository.getForPrintBucketLists(itemInAPage, limitFrom);

        return bucketLists;
    }

    public ResultData write(int loginedMemberId,String content) {
        int id = buketListRepository.write(loginedMemberId, content);
        return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다.", id), "id", id);
    }

    public BucketList getForPrintBucketListByID(int id) {
        return buketListRepository.getForPrintBucketListById(id);
    }

    public BucketList getBucketListById(int id) {
        return buketListRepository.getBucketListById(id);
    }

}
