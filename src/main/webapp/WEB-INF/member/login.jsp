<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.Map" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>끄적끄적 로그인</title>
</head>
<body>
<style>

</style>

<script>
    function LoginForm_submit(form) {
        let LoginForm__submitDone = false;

        if(LoginForm__submitDone) {
            alert('처리 중입니다.');
            return;
        }

        form.loginId.value = form.loginId.value.trim();

        if(form.loginId.value.length == 0) {
            alert('로그인 아이디를 입력해주세요');
            form.loginId.focus();
            return;
        }

        form.loginPw.value = form.loginPw.value.trim();

        if(form.loginPw.value.length == 0) {
            alert('로그인 비번을 입력해주세요');
            form.loginPw.focus();
            return;
        }

        form.submit();
        LoginForm__submitDone = true;
    }
</script>


<div class="member_login_box">
    <div class="con">
        <h1>로그인</h1>

        <form action="doLogin" method="POST" onsubmit="LoginForm_submit(this); return false;">
            <div>로그인 아이디 : <input placeholder="아이디를 입력해주세요." name="loginId" type="text"></div>
            <div>로그인 패스워드 : <input placeholder="비밀번호를 입력해주세요." name="loginPw" type="password"></div>
            <div class="btn-group">
                <button type="submit">로그인</button>
                <button type="button">
                    <a href="/home/main">취소</a>
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>