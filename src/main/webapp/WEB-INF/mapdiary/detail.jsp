<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ page import="java.util.Map" %>
<%@ page import="PenandSource.dto.MapDiary" %>

<%
    MapDiary mapDiary = (MapDiary) request.getAttribute("mapDiary");
%>
<%@ include file="../part/head.jspf"%>
<style>
    .section {
        display: flex;
        justify-content: center;
    }
</style>

<section class="section">
    <div class="con">
        <h1> 맵일기 게시물 상세보기</h1>

        <table border="1" style="border-collapse: collapse; text-align:center;">
            <colgroup>
                <col width="50">
                <col width="200">
                <col width="200">
                <col width="100">
                <col width="50">
                <col width="50">
            </colgroup>
            <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>내용</th>
                <th>글쓴아이디</th>
                <th>위도</th>
                <th>경도</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><%=mapDiary.getId()%></td>
<%--                <td><%=mapDiary.getAddress()%></td>--%>
                <td><%=mapDiary.getTitle()%></td>
                <td><%=mapDiary.getContent()%></td>
                <td><%=mapDiary.getMemberId()%></td>
                <td><%=mapDiary.getLat()%></td>
                <td><%=mapDiary.getLng()%></td>
            </tr>
        </tbody>
        </table>
        <div class="btn-group">
            <a href="list">리스트</a>
<%--            <a href="doDelete?id=<%=diaryRow.get("id")%>">게시물 삭제</a>--%>

        </div>
    </div>
</section>
<%@ include file="../part/foot.jspf"%>