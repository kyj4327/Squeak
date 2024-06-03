<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ page import="java.util.Map" %>
<%@ page import="PenandSource.dto.Diary" %>

<%
    Diary diary = (Diary) request.getAttribute("diary");
%>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>게시물 수정</title>
</head>
<body>
<style>
    body, ul, li {
        margin: 0;
    }
</style>

<section class="modify_section">
    <div class="con">

        <h1>일기 수정 페이지</h1>
<%--        form -> input, textarea 들만 읽는다, 수정을 눌렀을때 해당 글 id 도 받아와서 넘겨야한다.--%>
        <form action="doModify" method="POST">
        <%--            <input type="hidden" name="id" value="<%=(int)diaryRow.get("id")%>">--%>
            <input type="hidden" name="id" value="${param.id}"> <%--el 표기법 --%>

            <div>제목 : <input autocomplete="off" placeholder="제목을 입력해주세요."name="title" type="text" value="<%= diary.getTitle()%>"></div>
            <div>내용 : <textarea autocomplete="off" placeholder="내용을 입력해주세요."name="content" type="text"><%= diary.getContent()%></textarea></div>
            <div>멍청비용 : <textarea autocomplete="off" placeholder="오늘의 멍청비용은?" name="stupidCost" type="text"><%= diary.getStupidCost()%></textarea></div>
            <div>식단 : <textarea autocomplete="off" placeholder="오늘의 식단?" name="diet" type="text"><%= diary.getDiet()%></textarea></div>
            <div class="btn-group">
                <button type="submit">일기 수정</button>
                <a href="detail?id=${param.id}">수정 취소</a>
                <a href="list">일기 리스트로</a>
            <%--monolothic--%>
            </div>
        </form>
    </div>
</section>

</body>
</html>

</body>
</html>