<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="PenandSource.Rq" %>

<%@ page import="java.util.Map" %>

<%
    Rq rq = new Rq(request, response);
    Map<String, Object> diaryRow = (Map<String, Object>) rq.getAttr("diaryRow");
%>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>게시물 상세보기</title>
</head>
<body>
<style>
    body, ul, li {
        margin: 0;
    }

    .section {
        display: flex;
        justify-content: center;
    }
</style>

<section class="section">
    <div class="con">
        <h1>게시물 상세보기</h1>

        <table border="1" style="border-collapse: collapse; text-align:center;">
            <colgroup>
                <col width="50">
                <col width="200">
                <col width="200">
                <col width="200">
                <col width="200">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>작성날짜</th>
                <th>수정날짜</th>
                <th>제목</th>
                <th>멍청비용</th>
                <th>식단</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><%=diaryRow.get("id")%>
                </td>
                <td><%=diaryRow.get("regDate")%>
                </td>
                <td><%=diaryRow.get("title")%>
                </td>
                <td><%=diaryRow.get("content")%>
                </td>
                <td><%=diaryRow.get("stupidCost")%>
                </td>
                <td><%=diaryRow.get("diet")%>
            </tr>
        </tbody>
        </table>
        <div class="btn-group">
            <a href="list">리스트로 이동</a>
            <a href="doDeleite?id=<%=diaryRow.get("id")%>">게시물 삭제</a>

        </div>
    </div>
</section>

</body>
</html>