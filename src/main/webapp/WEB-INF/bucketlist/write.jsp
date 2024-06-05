<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.Map" %>


<%
    Map<String, Object> bucketListRow = (Map<String, Object>) request.getAttribute("bucketListRow");
%>
<%@ include file="../part/head.jspf"%>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>맵 일기 게시물 작성</title>
</head>
<body>
<style>
    body, ul, li {
        margin: 0;
    }
</style>

<section class="write_section">
    <div class="con">
        <h1> 버킷 쓰기 페이지</h1>
        <form action="doWrite" method="POST">

            <div>내용 : <textarea autocomplete="off" placeholder="내용을 입력해주세요." name="content" type="text"></textarea></div>

            <div class="btn-group">
                <button type="submit">글 작성</button>
            <%--monolothic : html 파일 내용을 jsp 파일에 그냥 대입? 입력하기.--%>

            </div>
        </form>
    </div>
</section>

</body>
</html>

</body>
</html>


<%@ include file="../part/foot.jspf"%>