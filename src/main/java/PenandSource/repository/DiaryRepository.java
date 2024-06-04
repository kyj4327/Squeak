package PenandSource.repository;

import PenandSource.dto.Diary;
import PenandSource.util.MysqlUtil;
import PenandSource.util.SecSql;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

// DB 관련 -> 쿼리문들 다 리포지토리에 옮김
public class DiaryRepository {

    public int getTotalCount() {
        SecSql sql = new SecSql();
        sql.append("SELECT COUNT(*)");
        sql.append("FROM diary");

        int totalCount = MysqlUtil.selectRowIntValue(sql);

        return totalCount;
    }

    public List<Diary> getForPrintDiaries(int itemInAPage, int limitFrom) {
        SecSql sql = new SecSql();
        sql.append("SELECT D.*, M.name AS writerName");
        sql.append("FROM diary AS D");
        sql.append("INNER JOIN `member` AS M");
        sql.append("ON D.memberId = M.id");
        sql.append("ORDER BY D.id DESC");
        sql.append("LIMIT ?, ?", limitFrom, itemInAPage);

        List<Map<String, Object>> selectRows = MysqlUtil.selectRows(sql);
        List<Diary> diaries = new ArrayList<>();

        for(Map<String,Object> selectRow : selectRows){
            diaries.add(new Diary(selectRow));
        }

        return diaries;
    }

    public int write(int loginedMemberId, String updateDate, String title, String content, String stupidCost, String diet) {
        SecSql sql = new SecSql();
        sql.append("INSERT INTO diary");
        sql.append("SET regDate= NOW()");
        sql.append(", updateDate =?", updateDate);
        sql.append(", title =?", title);
        sql.append(", content=?", content);
        sql.append(", stupidCost=?", stupidCost);
        sql.append(", diet=?", diet);
        sql.append(", memberId=?", loginedMemberId);

        /*
         sql.append("INSERT INTO diary");
            sql.append("SET regDate= NOW()");
            sql.append(", updateDate = NOW()");
            sql.append(", title =?", title);
            sql.append(", content=?", content);
            sql.append(", stupidCost=?", stupidCost);
            sql.append(", diet=?", diet);
            sql.append(", memberId=?", loginedMemberId);
         */
        int id = MysqlUtil.insert(sql);

        return id;
    }

    public Diary getForPrintDiaryById(int id) {
        SecSql sql = new SecSql();
        sql.append("SELECT D.*, M.name AS writerName");
        sql.append("FROM diary AS D");
        sql.append("INNER JOIN member as M"); // 2차원 배열
        sql.append("on D.memberId = M.id");
        sql.append("WHERE D.id=?", id); // id 기준 게시글 조회.
        sql.append("order by id DESC");

//        Map<String, Object> diaryRow = MysqlUtil.selectRow(sql);
        return new Diary(MysqlUtil.selectRow(sql));
    }

    public void delete(int id) {
        SecSql sql = new SecSql();
        sql.append("DELETE");
        sql.append("FROM diary");
        sql.append("WHERE id=?", id);

        MysqlUtil.delete(sql);

    }
}
