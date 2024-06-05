<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="PenandSource.dto.BucketList" %>
<%@ page import="PenandSource.dto.MapDiary" %>

<%
    List<MapDiary> mapDiaries = (List<MapDiary>) request.getAttribute("mapDiaries");

%>

<%--<%--%>
<%--//    // 로그인 세션 아이디 찾기.--%>
<%--//    String userID = null;--%>
<%--//    if (session.getAttribute("userID") != null) {--%>
<%--//        userID = (String) session.getAttribute("userID");--%>
<%--//    } ;--%>
<%--//    // 세션아이디랑 게시글 작성 Memberid 찾아서 일치하는것 찾기--%>

<%--%>--%>
<%@ include file="../part/head.jspf"%>

<style>

</style>

<section class="section">
    <div class="con">
        <h1>버켓리스트 리스트</h1>

        <table border="1" style="border-collapse: collapse; text-align:center;">
        <colgroup>
            <col width="50">
            <col width="200">
            <col width="200">
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

        <h1>맵 일기 리스트_표 적용</h1>
        <%
            for (MapDiary mapDiary : mapDiaries) {
        %>
        <ul>
            <tr>
                <td><%=mapDiary.getId()%></td>

                <td>
                    <%= mapDiary.getTitle()%> </a>
                </td>
                <td><%=mapDiary.getContent()%></td>
                <td><%=mapDiary.getLat()%></td>
                <td><%=mapDiary.getLng()%></td>
                <td><%=mapDiary.getMemberId()%></td>
            </tr>
        </ul>
        <% } %>
        </tbody>
    </table>
        <div class="btn-group">
            <a href="write">게시물 작성</a>
        </div>
    </div>
</section>

<%@ include file="../part/foot.jspf"%>