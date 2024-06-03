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

<style>
    body {
        margin: 0px;
        box-sizing: border-box;
        background: #FFF8EA; 
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    a {
        text-decoration: none;
    }

    .logo {
        margin-top: 35px; 
        margin-bottom: 30px;
        margin-right: auto; 
        margin-left: 65px; 
        display: block;
        width: 250px; 
    }

    .login_div {
        position: relative;
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 350px;
        height: 380px;
        background-color: white;
        border: 1px solid #d3d3d3;
        border-radius: 10px;
        box-shadow: 0px 0px 10px 2px rgba(0, 0, 0, 0.1);
        padding: 20px;
        background: linear-gradient(white 90%, #f0f0f0 90%);
        background-size: 100% 40px;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .login_div::before {
        content: "";
        position: absolute;
        top: 0;
        left: 40px;
        width: 3px;
        height: 100%;
        background: red; /* 붉은 줄 */
        z-index: 1;
        margin-left: 17px;
    }

    .punch_holes {
        position: absolute;
        top: 20px;
        left: 20px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        height: calc(100% - 40px);
        z-index: 1;
    }

    .hole {
        width: 10px;
        height: 10px;
        background-color: #FFFCE8;
        border: 2px solid #d3d3d3;
        border-radius: 50%;
    }

    .login_form {
        display: flex;
        flex-direction: column;
        width: 280px;
        margin-top: 10px;
        z-index: 2;
    }

    .login_text {
        height: 40px;
        margin: 3px 0;
        padding: 0 10px;
        border: 1px solid #d3d3d3;
        border-radius: 3px;
        box-shadow: inset 0px 0px 5px rgba(0, 0, 0, 0.1);
        font-family: Arial, sans-serif;
        margin-left: 30px;
        margin-right: -10px;
    }

    .login_text:focus {
        outline: 1px solid gray;
    }

    #login_btn {
        height: 33px;
        margin: 10px 0 5px 0;
        border-radius: 5px;
        font-size: 15px;
        font-weight: bold;
        font-family: Arial, sans-serif;
        margin-left: 30px;
        margin-right: -10px;
    }

    .login_join {
        margin-top: 65px;
        color: black;
        font-size: 13px;
        z-index: 2;
        margin-left: 40px;
    }
</style>

<body>
    <article>
        <div class="login_div">
            <div class="punch_holes">
                <div class="hole"></div>
                <div class="hole"></div>
                <div class="hole"></div>
                <div class="hole"></div>
                <div class="hole"></div>
            </div>
            <img class="logo" src="https://ifh.cc/g/7zvABf.png" alt="Logo">
            <form class="login_form" action="doLogin" method="POST" onsubmit="LoginForm_submit(this); return false;" >
                <input id="login_id" class="login_text" type="text" name="loginId" placeholder="아이디">
                <input id="login_pw" class="login_text" type="password" name="loginPw" placeholder="비밀번호">
                <input id="login_btn" type="submit" disabled>
            </form>
            <a class="login_join" href="join">회원가입</a>
        </div>
    </article>

    <script>
        function LoginForm_submit(form) {
            if (!loginBtn.disabled) {
                form.id.value = loginId.value.trim();
                form.pw.value = loginPw.value.trim();
                form.submit();
                LoginForm__submitDone = true;
            } else {
                alert('로그인 아이디와 비밀번호를 올바르게 입력해주세요.');
            }
        }
        
        const loginId = document.getElementById('login_id');
        const loginPw = document.getElementById('login_pw');
        const loginBtn = document.getElementById('login_btn');

        function login() {
            if(loginId.value.length > 0 && loginPw.value.length >= 8) {
                loginBtn.style.color = 'white';
                loginBtn.style.backgroundColor = 'black';
                loginBtn.disabled = false;
            } else {
                loginBtn.disabled = true;
            }
        }

        function moveToMain() {
            window.location.replace('/home/main');
        }
        

        loginId.addEventListener('keyup', login);
        loginPw.addEventListener('keyup', login);
        loginBtn.addEventListener('click', moveToMain);
    </script>
</body>

</html>