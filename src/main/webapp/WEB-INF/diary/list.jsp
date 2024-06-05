<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="PenandSource.dto.Diary" %>

<%
    List<Diary> diaries = (List<Diary>) request.getAttribute("diaries");
    int cPage = (int) request.getAttribute("page");
    int totalPage = (int) request.getAttribute("totalPage");
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
        <h1>게시물 리스트</h1>

        <table border="1" style="border-collapse: collapse; text-align:center;">
        <colgroup>
            <col width="50">
            <col width="200">
            <col width="200">
            <col width="200">
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
            <th>내용</th>
            <th>멍청비용</th>
            <th>식단</th>
            <th>작성자</th>
        </tr>
        </thead>
        <tbody>

<h1>일기 리스트_표 적용</h1>
<%
    for (Diary diary : diaries) {
%>
<ul>
    <tr>
       <td><%=diary.getId()%></td>
       <td><%=diary.getRegDate()%></td>
        <td> <%=diary.getUpdateDate()%></td>
       <td>
           <a href="detail?id=<%= diary.getId()%>"><%= diary.getTitle()%> </a>
       </td>
       <td><%=diary.getContent()%></td>
       <td><%=diary.getStupidCost()%></td>
       <td><%=diary.getDiet()%></td>
       <td><%=diary.getWriterName()%></td>
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