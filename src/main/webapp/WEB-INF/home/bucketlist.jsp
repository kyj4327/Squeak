<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%--<%@ page import="PenandSource.Rq" %>--%>

<%--<%--%>
<%--    Rq rq = new Rq(request, response);--%>
<%--    boolean isLogined = (boolean) rq.getAttr("isLogined");--%>
<%--    int loginedMemberID = (int) rq.getAttr("loginedMemberId");--%>
<%--%>--%>


<!doctype html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>버킷리스트</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        #bucketList {
            list-style-type: none;
            padding: 0;
        }
        .completed {
            text-decoration: line-through;
        }

        #itemInput {
            width: 80%; /* 입력 창 */
            margin-right: 10px; 
        }
        /* 삭제 아이콘 스타일 */
        .deleteIcon {
            visibility: hidden; /* 처음에는 숨김 */
            cursor: pointer;
            margin-left: 5px;
        }
        li:hover .deleteIcon {
            visibility: visible; /* 마우스 호버시 나타남 */
        }
    </style>
</head>
<body>
    <input type="text" id="itemInput" placeholder="내용을 입력해 주세요.">
    <button onclick="addItem()">+</button>
    <ul id="bucketList"></ul>

    <script>
        function addItem() {
            // 입력값 가져오기
            var newItem = document.getElementById("itemInput").value;
            
            if (newItem === "") {
                alert("빈칸은 등록할 수 없습니다.");
                return;
            }
            
            // 새로운 리스트
            var li = document.createElement("li");
            
            // 체크박스
            var checkbox = document.createElement("input");
            checkbox.type = "checkbox";
            checkbox.onclick = function() {
                // 체크박스가 클릭되면 완료된 항목으로 표시
                li.classList.toggle("completed");
            };
            
            // 리스트 아이템에 체크박스 추가
            li.appendChild(checkbox);
            
            // 텍스트 추가
            var textSpan = document.createElement("span");
            textSpan.textContent = newItem;
            li.appendChild(textSpan);
            
            // 삭제 아이콘 추가
            var deleteIcon = document.createElement("span");
            deleteIcon.classList.add("deleteIcon");
            deleteIcon.textContent = "x";
            deleteIcon.onclick = function() {
                li.remove(); // 해당 리스트 아이템 삭제
            };
            li.appendChild(deleteIcon);
            
            // 리스트에 추가
            document.getElementById("bucketList").appendChild(li);
            
            // 입력 필드 비우기
            document.getElementById("itemInput").value = "";
        }
    </script>
</body>
</html>