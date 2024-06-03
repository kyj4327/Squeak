<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.Map" %>
<%@ page import="PenandSource.dto.Diary" %>


<%
    Map<String, Object> diaryRow = (Map<String, Object>) request.getAttribute("diaryRow");
%>
<%@ include file="../part/head.jspf"%>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>게시물 작성</title>
</head>
<body>
<style>
    body, ul, li {
        margin: 0;
    }
</style>

<section class="write_section">
    <div class="con">
        <h1>일기 쓰기 페이지</h1>
<%-- action => 받는 사람 주소--%>
        <form action="doWrite" method="POST">
            <%-- autocomplete="off" 자동 완성 끄기--%>
<%--                <input type="hidden" name="redirectUri" value="../diary/detail?id=[NEW_ID]">--%>

            <div>제목 : <input autocomplete="off" placeholder="제목을 입력해주세요." name="title" type="text"></div>
            <div>내용 : <textarea autocomplete="off" placeholder="내용을 입력해주세요." name="content" type="text"></textarea></div>
            <div>멍청비용 : <textarea autocomplete="off" placeholder="오늘의 멍청비용은?" name="stupidCost" type="text"></textarea></div>
            <div>식단 : <textarea autocomplete="off" placeholder="오늘의 식단?" name="diet" type="text"></textarea></div>
            <div class="btn-group">
                <button type="submit">글 작성</button>
                <a href="list">리스트로 돌아가기</a>
            <%--monolothic : html 파일 내용을 jsp 파일에 그냥 대입? 입력하기.--%>

            </div>

                <li><a href="/home/main">메인으로</a></li>

        </form>
    </div>
</section>

</body>
</html>

</body>
</html>


<%@ include file="../part/foot.jspf"%>