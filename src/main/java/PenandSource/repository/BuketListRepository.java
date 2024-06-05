package PenandSource.repository;

import PenandSource.dto.BucketList;
import PenandSource.dto.MapDiary;
import PenandSource.util.MysqlUtil;
import PenandSource.util.SecSql;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class BuketListRepository {

    private List<BucketList> bucketLists;

    public int getTotalCount() {
        SecSql sql = new SecSql();
        sql.append("SELECT COUNT(*)");
        sql.append("FROM bucketList");

        int totalCount = MysqlUtil.selectRowIntValue(sql);

        return totalCount;
    }

    public int write(int loginedMemberId, String content) {
        SecSql sql = new SecSql();
        sql.append("INSERT INTO bucketList");
        sql.append("SET memberId=?", loginedMemberId);
        sql.append(", content=?", content);

        int id = MysqlUtil.insert(sql);

        return id;
    }


    public BucketList getForPrintBucketListById(int id) {
        SecSql sql = new SecSql();
        sql.append("SELECT B.*, M.name AS writerName");
        sql.append("FROM bucketList AS B");
        sql.append("INNER JOIN member as M"); // 2차원 배열
        sql.append("on B.memberId = M.id");
        sql.append("WHERE B.id=?", id); // id 기준 게시글 조회.
        sql.append("order by id DESC");

        return new BucketList(MysqlUtil.selectRow(sql));
    }

    public List<BucketList> getForPrintBucketLists(int itemInAPage, int limitFrom) {
        SecSql sql = new SecSql();
        sql.append("SELECT B.*, M.name AS writerName");
        sql.append("FROM bucketList AS B");
        sql.append("INNER JOIN `member` AS M");
        sql.append("ON B.memberId = M.id");
        sql.append("ORDER BY B.id DESC");
        sql.append("LIMIT ?, ?", limitFrom, itemInAPage);

        List<Map<String, Object>> selectRows = MysqlUtil.selectRows(sql);
        List<BucketList> bucketLists = new ArrayList<>();

        for (Map<String, Object> selectRow : selectRows) {
            bucketLists.add(new BucketList(selectRow));
        }

        return bucketLists;
    }

    public BucketList getBucketListById(int id) {
        for (BucketList bucketList : bucketLists) {
            if (bucketList.getId() == id) {
                return bucketList;
            }
        }
        return null;
    }

    // 로그인 아이디랑 memberID 일치만 리스트로 불러오기.
    public List<BucketList> getForPrintBucketListByMemberId(int memberId) {
        SecSql sql = new SecSql();
        sql.append("SELECT B.*, M.name AS writerName");
        sql.append("FROM bucketList AS B");
        sql.append("INNER JOIN member AS M");
        sql.append("ON B.memberId = M.id");
        sql.append("WHERE B.memberId = ?",memberId);
        sql.append("ORDER BY B.id DESC");

        List<Map<String, Object>> selectRows = MysqlUtil.selectRows(sql);
        List<BucketList> bucketLists = new ArrayList<>();

        for (Map<String, Object> selectRow : selectRows) {
            bucketLists.add(new BucketList(selectRow));
        }

        return bucketLists;
    }
}
