package PenandSource.repository;

import PenandSource.dto.MapDiary;
import PenandSource.util.MysqlUtil;
import PenandSource.util.SecSql;

// DB 관련 -> 쿼리문들 다 리포지토리에 옮김
public class MapDiaryRepository {


    public int write(int loginedMemberId, String title, String content, String lat, String lng) {
        SecSql sql = new SecSql();
        sql.append("INSERT INTO mapDiary");
        sql.append("SET title =?", title);
        sql.append(", content=?", content);
        sql.append(", lat=?", lat);
        sql.append(", lng=?", lng);
//        sql.append(", address=?", address);
        sql.append(", memberId=?", loginedMemberId);

        int id = MysqlUtil.insert(sql);

        return id;
    }

    public MapDiary getForPrintMapDiaryById(int id) {
        SecSql sql = new SecSql();
        sql.append("SELECT D.*, M.name AS writerName");
        sql.append("FROM mapDiary AS D");
        sql.append("INNER JOIN member as M"); // 2차원 배열
        sql.append("on D.memberId = M.id");
        sql.append("WHERE D.id=?", id); // id 기준 게시글 조회.
        sql.append("order by id DESC");

//        Map<String, Object> diaryRow = MysqlUtil.selectRow(sql);
        return new MapDiary(MysqlUtil.selectRow(sql));
    }
}
