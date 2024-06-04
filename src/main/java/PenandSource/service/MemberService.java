package PenandSource.service;

import PenandSource.dto.Member;
import PenandSource.dto.ResultData;
import PenandSource.repository.MemberRepository;
import PenandSource.util.Ut;

public class MemberService {

    private MemberRepository memberRepository;

    public MemberService() {
        memberRepository = new MemberRepository();
    }

    public ResultData join(String loginId, String loginPw, String name, String email) {

        // 이미 가입한 회원 = oldMember
        Member oldMember = getMemberByLoginId(loginId);

         // 이미 가입한 회원의 아이디가 null 아니다 -> 존재한다
        if (oldMember != null) {
            return ResultData.from("F-1", Ut.f("%s(은)는 이미 가입된 아이디입니다.", loginId));
        }

        oldMember = getMemberByNameANDeMail(name, email);

        if (oldMember != null) {
            return ResultData.from("F-2", Ut.f("%s(은) 이미 가입된 이메일입니다.", email));
        }

        int id = memberRepository.join(loginId, loginPw, name, email);

        return ResultData.from("S-1", "회원 가입이 완료되었습니다.", "id", id);
    }



    private Member getMemberByLoginId(String loginId) {
        return memberRepository.getMemberByLoginId(loginId);
    }
    private Member getMemberByNameANDeMail(String name, String email) {
        return memberRepository.getMemberByNameAndEmail(name, email);
    }

    public String getWriteNameByBoardId(int memberId) {
        return memberRepository.getWriteNameByBoardID(memberId);
    }
}