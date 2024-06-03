<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="PenandSource.Rq" %>

<%@ page import="java.util.Map" %>


<%
    Rq rq = new Rq(request, response);
%>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>회원가입</title>
</head>
<body>
<style>

</style>

<script>
    <%--    아이디 패스워드 빈칸 입력 유효성 검사 --%>

    function JoinForm_submit(form) {
        // 회원가입 버튼 연속 누르면 계속 Post 되니까 막기.
        let JoinForm__submitDone = false;

        if(JoinForm__submitDone) {
            alert('처리 중입니다.');
            return;
        }

        form.loginId.value = form.loginId.value.trim();

        // id 미입력시 경고창띄우기
        if(form.loginId.value.length == 0) {
            alert('로그인 아이디를 입력해주세요');
            form.loginId.focus();
            return;
        }

        // 공백제거 -> 공백 들어가면 아이디 가입 가능할지도 모르니 공백 없애고 유효성 검사 돌리기.
        form.loginPw.value = form.loginPw.value.trim();

        if(form.loginPw.value.length == 0) {
            alert('로그인 비번을 입력해주세요');
            form.loginPw.focus();
            return;
        }

        form.loginPwConfirm.value = form.loginPwConfirm.value.trim();

        if(form.loginPwConfirm.value.length == 0) {
            alert('로그인 비번 확인을 입력해주세요');
            form.loginPwConfirm.focus();
            return;
        }

        if(form.loginPw.value != form.loginPwConfirm.value) {
            alert('로그인 비번이 일치하지 않습니다.');
            form.loginPwConfirm.focus();
            return;
        }

        form.name.value = form.name.value.trim();
        if(form.name.value.length == 0) {
            alert('이름을 입력해주세요.');
            form.name.focus();
            return;
        }

        form.email.value = form.email.value.trim();
        if(form.email.value.length == 0) {
            alert('이메일을 입력해주세요.');
            form.email.focus();
            return;
        }

        form.submit();
        JoinForm__submitDone = true;
    }
</script>


<div class="member_join_box">
    <div class="con">
        <h1>회원가입</h1>
        <%--회원가입 = Post --%>
        <form action="doJoin" method="POST" onsubmit="JoinForm_submit(this); return false;">
            <div>로그인 아이디 : <input autocomplete="off" placeholder="아이디를 입력해주세요." name="loginId" type="text"></div>
            <%--type="password" => **** 으로 표시 --%>
            <div>로그인 패스워드 : <input autocomplete="off" placeholder="비밀번호를 입력해주세요." name="loginPw" type="password"></div>
            <div>로그인 패스워드 확인 : <input autocomplete="off" placeholder="비밀번호를 확인을 입력해주세요." name="loginPwConfirm"
                                      type="password"></div>
            <div>이름 : <input placeholder="이름을 입력해주세요." name="name" type="text"></div>
            <div>이메일 : <input placeholder="이메일은 입력해주세요." name="email" type="email"></div>
            <div class="btn-group">
                <button type="submit">회원가입</button>
                <button type="button">
<%--                     URL 동작 불가능 수정하기.--%>
<%--                    <a href="/WEB-INF/diary/home/main">취소</a>--%>
        <a href="/home/main">취소</a>

                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>