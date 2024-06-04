<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Map"%>
<%@ page import="PenandSource.dto.Diary"%>

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
<title>일기 작성</title>
</head>
<body>
	<style>
p#titlename, p#datename {
	display: inline-block;
}

input#title {
	border: 1px solid black;
	border-radius: 4px;
	/* display: inline-block; */
	width: 650px;
}

input#updateDate {
	border: 1px solid black;
	border-radius: 4px;
}

div.content-menu {
	margin-bottom: 10px;
}

button.active {
	background-color: black;
	color: #FFF;
}

div#acontent {
	border: 1px solid black;
	border-radius: 4px;
	width: 700px;
	height: 400px;
	padding: 5px;
}

textarea {
	display: none;
}

#acontent:empty:before, #acontent:focus:empty:before {
	content: attr(placeholder);
	color: gray
}

#astupidCost:empty:before, #astupidCost:focus:empty:before {
	content: attr(placeholder);
	color: gray
}

#adiet:empty:before, #adiet:focus:empty:before {
	content: attr(placeholder);
	color: gray
}

div#astupidCost, div#adiet {
	border: 1px solid black;
	border-radius: 4px;
	width: 700px;
	height: 100px;
	padding: 5px;
}
</style>

	<section class="write_section">
		<div class="con">
			<h1>일기 작성</h1>
			<form action="doWrite" method="POST">

				<div class="titleWrite">
					<p id="titlename">제목 :</p>
					<input type="text" id="title" name="title"
						placeholder="제목을 입력해주세요." autocomplete="off">
				</div>

				<div class="dateWrite">
					<p id="datename">날짜 :</p>
					<input type="date" id="updateDate" name="updateDate">
				</div>

				<p class="contentWrite">내용 :</p>
				<div class="content-menu">
					<button type="button" id="btn_bold">
						<b>진하게</b>
					</button>
					<button type="button" id="btn_italic">
						<i>기울임</i>
					</button>
					<button type="button" id="btn_underline">
						<u>밑줄</u>
					</button>
					<button type="button" id="btn_strike">
						<s>취소선</s>
					</button>
				</div>
				<div id="acontent" name="acontent" contenteditable="true"
					placeholder="내용을 입력해주세요."></div>
				<textarea name="content" id="content"></textarea>

				<div class="stupidCostWrite">
					<p>멍청이 비용 :</p>
					<div id="astupidCost" name="astupidCost" contenteditable="true"
						placeholder="오늘의 멍청이 비용?"></div>
					<textarea name="stupidCost" id="stupidCost"></textarea>
				</div>

				<div class="dietWrite">
					<p>식단 :</p>
					<div id="adiet" name="adiet" contenteditable="true"
						placeholder="오늘의 식단?"></div>
					<textarea name="diet" id="diet"></textarea>
				</div>

				<div class="btn-group">
					<button type="submit" onclick="updateTextarea()">저장</button>
				</div>

			</form>
		</div>
	</section>

	<script>
		const acontent = document.getElementById('acontent');
		const btnBold = document.getElementById('btn_bold');
		const btnItalic = document.getElementById('btn_italic');
		const btnUnderline = document.getElementById('btn_underline');
		const btnStrike = document.getElementById('btn_strike');
		btnBold.addEventListener('click', function() {
			setStyle('bold');
		});
		btnItalic.addEventListener('click', function() {
			setStyle('italic');
		});
		btnUnderline.addEventListener('click', function() {
			setStyle('underline');
		});
		btnStrike.addEventListener('click', function() {
			setStyle('strikeThrough')
		});
		function setStyle(style) {
			document.execCommand(style);
			focusContent();
		}
		function focusContent() {
			acontent.focus({
				preventScroll : true
			});
		}

		acontent.addEventListener('keydown', function() {
			checkStyle();
		});
		acontent.addEventListener('mousedown', function() {
			checkStyle();
		});
		function setStyle(style) {
			document.execCommand(style);
			focusContent();
			checkStyle();
		}
		function checkStyle() {
			if (isStyle('bold')) {
				btnBold.classList.add('active');
			} else {
				btnBold.classList.remove('active');
			}
			if (isStyle('italic')) {
				btnItalic.classList.add('active');
			} else {
				btnItalic.classList.remove('active');
			}
			if (isStyle('underline')) {
				btnUnderline.classList.add('active');
			} else {
				btnUnderline.classList.remove('active');
			}
			if (isStyle('strikeThrough')) {
				btnStrike.classList.add('active');
			} else {
				btnStrike.classList.remove('active');
			}
		}
		function isStyle(style) {
			return document.queryCommandState(style);
		}

		function updateTextarea() {
			const divContent = document.getElementById('acontent').innerHTML;
			const divStupidCost = document.getElementById('astupidCost').innerText;
			const divDiet = document.getElementById('adiet').innerText;
			document.getElementById('content').value = divContent;
			document.getElementById('stupidCost').value = divStupidCost;
			document.getElementById('diet').value = divDiet;
		}
	</script>
</body>
</html>

<%@ include file="../part/foot.jspf"%>