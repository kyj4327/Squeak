package PenandSource.dto;

import PenandSource.util.Ut;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Map;

@NoArgsConstructor // 빈 생성자
@ToString
public class ResultData { // 보고서
    @Getter
    private String resultCode; // 성공 실패 여부
    @Getter
    private String msg;// 성공실패 과련 메시지
    @Getter
    private Map<String, Object> body;

    public boolean isSuccess() {
        return resultCode.startsWith("S-");
    }

    public boolean isFail() {
        return !isSuccess();
    }

    public static ResultData from(String resultCode, String msg, Object... bodyArgs) {
        ResultData rd = new ResultData();

        rd.resultCode = resultCode;
        rd.msg = msg;
        rd.body = Ut.mapOf(bodyArgs);

        return rd;
    }
}