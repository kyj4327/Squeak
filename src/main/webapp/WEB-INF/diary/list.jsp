<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="PenandSource.dto.Diary"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
List<Diary> diaries = (List<Diary>) request.getAttribute("diaries");
int cPage = (int) request.getAttribute("page");
int totalPage = (int) request.getAttribute("totalPage");
%>

<%@ include file="../part/head.jspf"%>

<!doctype html>
<html lang="ko">

<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>일기</title>
</head>

<body>
	<style>
.section {
	display: flex;
	justify-content: center;
}

.con {
	width: 800px;
}

#write {
	margin-bottom: 10px;
}

.card-header {
	display: flex;
	justify-content: space-between;
}

#regDate {
	display: flex;
	align-items: center;
}

table {
	/*width: 95%;
	border-collapse: collapse;*/
	border-collapse: separate;
	border-spacing: 0;
	width: 100%;
	border: 1px solid lightgrey;
	border-radius: 12px;
	overflow: hidden;
	margin: 0 auto;
	margin-bottom: 15px;
}

th, td {
	width: 50%;
	border: 1px solid lightgrey;
	padding: 8px;
	text-align: center;
}

th:first-child {
	border-top-left-radius: 10px;
}

th:last-child {
	border-top-right-radius: 10px;
}

td:first-child {
	border-bottom-left-radius: 10px;
}

td:last-child {
	border-bottom-right-radius: 10px;
}

th {
	background-color: #E8E1D5;
}

#del {
	border: 1px solid lightgrey;
	float: right;
}

#odd {
	background-color: #FFF8EA;
}

#even {
	background-color: #FFFCF5;
}
</style>

	<section class="section">
		<div class="con">
			<h2>일기장</h2>
			<div class="btn-group">
				<a href="write"><button id="write">작성</button></a>
			</div>
			<%
			int count = 1;
			for (Diary diary : diaries) {
				String collapseId = "collapse" + count;
				String showClass = count == 1 ? "show" : "";
				String cardClass = (count % 2 == 1) ? "odd" : "even";
			%>
			<div id="accordion">
				<div class="card">
					<div class="card-header" id="<%=cardClass%>"
						data-bs-toggle="collapse" data-bs-target="#<%=collapseId%>">
						<a class="collapsed btn"><%=diary.getUpdateDate()%> : <%=diary.getTitle()%>
						</a>
						<div name="regDate" , id="regDate">
							작성일 :
							<%=diary.getRegDate()%></div>
					</div>
					<div id="<%=collapseId%>" class="collapse<%=showClass%>">
						<div class="card-body">
							<%=diary.getContent()%>
						</div>
						<table>
							<tr>
								<th>멍청이 비용</th>
								<th>식단</th>
							</tr>
							<tr>
								<td><%=diary.getStupidCost()%></td>
								<td><%=diary.getDiet()%></td>
							</tr>
						</table>
						<a href="javascript:void(0);"
							onclick="confirmDeletion('doDelete?id=<%=diary.getId()%>')">
							<button id="del">삭제</button>
						</a>
					</div>
				</div>
			</div>
			<%
			count += 1;
			}
			%>
		</div>
	</section>

	<script>
		function confirmDeletion(url) {
			if (confirm('삭제하시겠습니까?')) {
				window.location.href = url;
			}
		}
	</script>
</body>

<%@ include file="../part/foot.jspf"%>