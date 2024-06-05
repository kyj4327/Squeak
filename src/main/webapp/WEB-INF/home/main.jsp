<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%--<%@ page import="PenandSource.Rq" %>--%>

<%--<%--%>
<%--    Rq rq = new Rq(request, response);--%>
<%--    boolean isLogined = (boolean) rq.getAttr("isLogined");--%>
<%--    int loginedMemberID = (int) rq.getAttr("loginedMemberId");--%>
<%--%>--%>

<%@ include file="../part/head.jspf"%>
<!doctype html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>끄적끄적</title>
     <style>
        * {
            margin: 0; /* 모든 요소의 기본 여백 제거 */
            padding: 0; /* 모든 요소의 기본 패딩 제거 */
            box-sizing: border-box; /* 요소의 너비와 높이에 패딩과 테두리를 포함 */
        }

        html, body {
            height: 100%; /* html과 body 요소를 전체 높이로 설정 */
            overflow: hidden; /* 스크롤바를 숨김 */
            font-family: Arial, sans-serif; /* 기본 글꼴 설정 */
        }

        .container {
            position: relative; /* 자식 요소의 위치를 상대적으로 설정 */
            width: 100%; /* 가로폭 100% */
            height: 100%; /* 세로폭 100% */
        }

        .top-left {
            position: absolute; /* 위치를 절대적으로 설정 */
            top: 5%; /* 위쪽여백 5%  */
            left: 5%; /* 왼쪽여백 5% */
            font-size: 0.9em; /* 글꼴 크기 설정 */
            background-color: #FFF8EA; /* 배경 색상 설정 */
            border-radius: 25px; /* 테두리 둥글게 설정 */
            padding: 10px 20px; /* 내부 여백 설정 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        .weather {
            position: absolute; /* 위치를 절대적으로 설정 */
            top: 13%; /* 위쪽 여백 13%  */
            left: 5%; /* 왼쪽 여백 5% */
            font-size: 0.9em; /* 글꼴 크기 설정 */
            background-color: #FFF8EA; /* 배경 색상 설정 */
            border-radius: 25px; /* 테두리 둥글게 설정 */
            padding: 10px 20px; /* 내부 여백 설정 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        .bottom-right {
            position: absolute; /* 위치를 절대적으로 설정 */
            top: 20%; /* 위쪽 20% 여백 */
            right: 5%; /* 오른쪽 여백 5%  */
            bottom: 5%; /* 아래쪽 여백 5%  */
            left: 5%; /* 왼쪽 여백 5% */
            display: flex; /* 플렉스박스 설정 */
            justify-content: center; /* 가로 정렬 가운데 */
            align-items: center; /* 세로 정렬 가운데 */
        }

        #calendar {
            display: block; /* 블록 요소로 설정 */
            border: 1px solid #ddd; /* 테두리 설정 */
            border-radius: 15px; /* 테두리 둥글게 설정 */
            background-color: #fff; /* 배경 색상 설정 */
            width: 100%; /* 가로폭 100% */
            height: 100%; /* 세로폭 100% */
        }

        table {
            border-collapse: collapse; /* 테두리 겹침 제거 */
            width: 100%; /* 테이블 가로폭 100% */
            height: 100%; /* 테이블 세로폭 100% */
            border-radius: 15px; /* 테두리 둥글게 설정 */
            overflow: hidden; /* 넘침 숨기기 */
        }

        th, td {
            border: 1px solid #ddd; /* 셀 테두리 설정 */
            padding: 10px; /* 셀 내부 여백 설정 */
            text-align: center; /* 텍스트 가운데 정렬 */
            font-size: 1.2em; /* 글꼴 크기 설정 */
        }

        th {
            background-color: #FFF8EA; /* 헤더 셀 배경 색상 설정 */
            color: #333; /* 헤더 셀 글꼴 색상 설정 */
        }

        td {
            background-color: #fff; /* 데이터 셀 배경 색상 설정 */
            color: #555; /* 데이터 셀 글꼴 색상 설정 */
        }

        tr:nth-child(even) {
            background-color: #f9f9f9; /* 짝수 행 배경 색상 설정 */
        }

        .sunday {
            color: pink; /* 일요일 셀 글꼴 색상 설정 */
        }

        .saturday {
            color: #add8e6; /* 토요일 셀 글꼴 색상 설정 */
        }
        
    </style>
</head>
<body>
    <div class="container">
        <div id="datetime" class="top-left"></div>
        <div id="weather" class="weather"></div>
        <div class="bottom-right">
            <div id="calendar"></div>
        </div>
    </div>
    <script>
   
    function padToTwoDigits(number) {
        return number < 10 ? '0' + number : number;
    }

    function updateDateTime() {
        const now = new Date();
        const year = now.getFullYear();
        const month = padToTwoDigits(now.getMonth() + 1);
        const date = padToTwoDigits(now.getDate());
        const hours = padToTwoDigits(now.getHours());
        const minutes = padToTwoDigits(now.getMinutes());
        const seconds = padToTwoDigits(now.getSeconds());

        const formattedDate = `\${year}. \${month}. \${date}. \${hours}:\${minutes}:\${seconds}`;
        document.getElementById('datetime').textContent = formattedDate;
    }
        setInterval(updateDateTime, 1000);

        function generateCalendar() {
            const calendarElement = document.getElementById('calendar');
            const now = new Date();
            const year = now.getFullYear();
            const month = now.getMonth();

            const firstDay = new Date(year, month, 1).getDay();
            const lastDate = new Date(year, month + 1, 0).getDate();

            const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            const dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

            let calendarHTML = `<table><thead><tr><th colspan="7">\${monthNames[month]} \${year}</th></tr><tr>`;
            
            dayNames.forEach(dayName => {
                const className = dayName === "Sun" ? 'sunday' : dayName === "Sat" ? 'saturday' : '';
                calendarHTML += `<th class="\${className}">\${dayName}</th>`;
            });
            calendarHTML += `</tr></thead><tbody><tr>`;


            let dayCount = 0;

            for (let i = 0; i < firstDay; i++) {
                calendarHTML += `<td></td>`;
                dayCount++;
            }

            for (let day = 1; day <= lastDate; day++) {
                if (dayCount % 7 === 0) {
                    calendarHTML += `</tr><tr>`;
                }
                const className = dayCount % 7 === 0 ? 'sunday' : dayCount % 7 === 6 ? 'saturday' : '';
                calendarHTML += `<td class="\${className}">\${day}</td>`;
                dayCount++; //달력 색
            }

            while (dayCount % 7 !== 0) {
                calendarHTML += `<td></td>`;
                dayCount++;
            }

            calendarHTML += `</tr></tbody></table>`;
            calendarElement.innerHTML = calendarHTML;
        }

        function getWeatherIcon(weatherDescription) {
            switch (weatherDescription) {
                case 'Clear':
                    return '☀️';
                case 'Clouds':
                    return '🌥️';
                case 'Rain':
                    return '🌧️';
                case 'Snow':
                    return '❄️';
                case 'Mist':
                case 'Fog':
                    return '🌫️';
                case 'Thunderstorm':
                    return '⛈️';
                case 'Haze':
                    return '🌫️';
                default:
                    return '🌍'; 
            }
        }

        function fetchWeather(latitude, longitude) {
            const apiKey = '6edee3c2aa182bc44d18ccb204c98a31'; // OpenWeatherMap API 키
            const url = `https://api.openweathermap.org/data/2.5/weather?lat=\${latitude}&lon=\${longitude}&units=metric&appid=\${apiKey}`;
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    const weatherElement = document.getElementById('weather');
                    const weatherDescription = data.weather[0].main; // 날씨 상태
                    const weatherIcon = getWeatherIcon(weatherDescription); // 해당하는 이모티콘
                    const temperature = data.main.temp;
                    weatherElement.textContent = weatherIcon + weatherDescription + temperature + '°C';
                })
                .catch(error => console.error('날씨 데이터를 가져오지 못했습니다.', error));
        }

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(position => { //사용자 위치 가져오기
                    const { latitude, longitude } = position.coords;
                    fetchWeather(latitude, longitude); //위치 받으면 날씨데이터 가져오기
                }, error => {
                    console.error('위치 정보를 가져오지 못했습니다.', error);
                });
            } else {
                console.error('이 브라우저에서는 지원하지 않습니다.');
            }
        }

        updateDateTime();
        generateCalendar();
        getLocation();
    </script>
    <ul>
<%--       <% if(isLogined) { %>
            <li><a href="/user/member/doLogout">로그아웃</a></li>
        <% }  %> 					--%>  
    </ul> 
</body>

</html>