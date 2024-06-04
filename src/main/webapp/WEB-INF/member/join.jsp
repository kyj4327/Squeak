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

<style>
    .hide {
        display: none;
    }

    * {
        box-sizing: border-box;
        padding: 0;
        margin: 0;
    }

    body {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        width: 100vw;
        height: 100vh;
        background: #FFF8EA;
    }

    main {
        position: relative;
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 550px;
        height: 650px;
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

    main::before {
        content: "";
        position: absolute;
        top: 0;
        left: 30px;
        width: 3px; /* 붉은줄 */
        height: 100%;
        background: red;
        z-index: 1;
        margin-left: 50px;
    }

    .logo {
        margin-right: auto; 
        margin-left: 155px; 
        margin-top: 40px;
        margin-bottom: 10px;
        width: 250px; 
    }

    .divClass {
        display: flex;
        flex-direction: column;
        width: 100%;
        margin-top: 10px;
        z-index: 2;
    }

    .join_form {
        display: flex;
        flex-direction: column;
        width: 280px;
        margin-top: 10px;
        z-index: 2;
    }

    .form_text {
        height: 40px;
        margin: 10px;
        padding: 0 10px;
        border: 1px solid #d3d3d3;
        border-radius: 3px;
        box-shadow: inset 0px 0px 5px rgba(0, 0, 0, 0.1);
        font-family: Arial, sans-serif;
        margin-left: 40px;
        margin-right: -10px;
    }

    .form_text:focus {
        outline: 1px solid gray;
    }

    button {
        height: 33px;
        margin: 10px 0 5px 0;
        border-radius: 5px;
        font-size: 15px;
        font-weight: bold;
        font-family: Arial, sans-serif;
        margin-left: 40px;
        margin-right: -10px;
        background-color: black;
        color: white;
    }

    button:hover {
        background-color: rgb(52, 52, 52);
        color: white;
    }

    #msg {
        font-size: 12px;
        text-align: center;
        margin-left: 40px;
    }

    /* 펀치 */
    .punch_holes {
        position: absolute;
        top: 20px;
        left: 10px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        height: calc(100% - 40px);
        z-index: 1;
    }

    .hole {
        width: 17px;
        height: 17px;
        background-color: #FFF8EA;
        border: 2px solid #d3d3d3;
        border-radius: 50%;
        margin-bottom: 5px;
        margin-left: 15px;
    }
</style>

<body>
    <main>
        <div class="punch_holes">
            <div class="hole"></div>
            <div class="hole"></div>
            <div class="hole"></div>
            <div class="hole"></div>
            <div class="hole"></div>
        </div>
        <!-- 로고와 폼 -->
        <img class="logo" src="https://ifh.cc/g/7zvABf.png" alt="Logo"> 
        <form class="join_form" action="doJoin" method="POST" onsubmit="JoinForm_submit(this); return false;">
            <div class="divClass">
                <input id="username" class="form_text" type="text" placeholder="이름">
            </div>
            <div class="divClass">
                <input id="user_id" class="form_text" type="text" placeholder="아이디" name="loginId">
            </div>
            <div class="sMessage hide" id="msg">사용할 수 있는 아이디입니다</div>
            <div class="fMessage hide" id="msg">아이디는 6~12글자이어야 합니다</div>
            <div class="fMessage2 hide" id="msg">영어 또는 숫자만 가능합니다</div>
            <div class="divClass">
                <input id="user_pw" class="form_text" type="password" placeholder="비밀번호" name="loginPw">
            </div>
            <div class="sPwMessage hide" id="msg">8글자 이상, 영문, 숫자, 특수문자(@#!%?)를 사용하세요</div>
            <div class="divClass">
                <input id="user_pw_rt" class="form_text" type="password" placeholder="비밀번호 확인" name="loginPwConfirm">
            </div>
            <div class="mismatchMessage hide" id="msg">비밀번호가 일치하지 않습니다</div>
            <div class="divClass">
                <input id="email" class="form_text" type="text" placeholder="ex) abc@naver.com" name="email">
            </div>
            <div class="emailcheck hide" id="msg">양식에 맞춰 작성하세요</div>
            <div class="divClass">
                <button id="joinButton">회원가입</button>
            </div>
        </form>
    </main>

    <script>
        function JoinForm_submit(form) {
            let JoinForm__submitDone = false;

            if(JoinForm__submitDone) {
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
            form.loginPwConfirm.value = form.loginPwConfirm.value.trim();

            if(form.loginPw.value.length == 0) {
                alert('로그인 비밀번호를 입력해주세요');
                form.loginPw.focus();
                return;
            }

            if(form.loginPwConfirm.value.length == 0) {
                alert('로그인 비밀번호 확인을 입력해주세요');
                form.loginPwConfirm.focus();
                return;
            }

            if(form.loginPw.value != form.loginPwConfirm.value) {
                alert('로그인 비밀번호가 일치하지 않습니다.');
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

        document.querySelector('#user_id').onkeyup = function () {
            const userId = this.value.trim();
            const id_sMessage = document.querySelector('.sMessage');
            const id_fMessage = document.querySelector('.fMessage');
            const id_fMessagetwo = document.querySelector('.fMessage2');

            if (userId.length !== 0) {
                if (/^[A-Za-z0-9][A-Za-z0-9]*$/.test(userId) === false) {
                    id_sMessage.classList.add('hide');
                    id_fMessage.classList.add('hide');
                    id_fMessagetwo.classList.remove('hide');
                } else if (userId.length < 6 || userId.length > 12) {
                    id_sMessage.classList.add('hide');
                    id_fMessage.classList.remove('hide');
                    id_fMessagetwo.classList.add('hide');
                } else {
                    id_sMessage.classList.remove('hide');
                    id_fMessage.classList.add('hide');
                    id_fMessagetwo.classList.add('hide');
                }
            } else {
                id_sMessage.classList.add('hide');
                id_fMessage.classList.add('hide');
                id_fMessagetwo.classList.add('hide');
            }
        };

        document.querySelector('#user_pw').onkeyup = function () {
            const userPw = this.value.trim();
            const pw_Message = document.querySelector('.sPwMessage');

            if (userPw.length !== 0) {
                if (/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#!%?])[A-Za-z\d@#!%?]{8,}$/.test(userPw)) {
                    pw_Message.classList.add('hide');
                } else {
                    pw_Message.classList.remove('hide');
                }
            } else {
                pw_Message.classList.add('hide');
            }
        };

        document.querySelector('#user_pw_rt').onkeyup = function () {
            const userPw = document.querySelector('#user_pw').value.trim();
            const userPw_rt = this.value.trim();
            const pw_mismatchMessage = document.querySelector('.mismatchMessage');

            if (userPw_rt.length !== 0) {
                if (userPw === userPw_rt) {
                    pw_mismatchMessage.classList.add('hide');
                } else {
                    pw_mismatchMessage.classList.remove('hide');
                }
            } else {
                pw_mismatchMessage.classList.add('hide');
            }
        };

        document.querySelector('#email').onkeyup = function () {
            const userEmail = this.value.trim();
            const eMessage = document.querySelector('.emailcheck');

            if (userEmail.length !== 0) {
                if (/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/.test(userEmail)) {
                    eMessage.classList.add('hide');
                } else {
                    eMessage.classList.remove('hide');
                }
            } else {
                eMessage.classList.add('hide');
            }
        };
    </script>
</body>

</html>