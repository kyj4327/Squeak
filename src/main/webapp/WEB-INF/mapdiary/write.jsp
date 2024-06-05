<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Map"%>


<%
Map<String, Object> mapDiaryRow = (Map<String, Object>) request.getAttribute("mapDiaryRow");
%>

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
    body,
    html {
        margin: 0;
        padding: 0;
        height: 100%;
        overflow: hidden;
        background-color: #FFF8EA;
        font-family: "IBM Plex Sans KR", sans-serif;
    }

    .container {
        display: flex;
        height: 100%;
    }

    .left {
        flex: 1;
        position: relative;
        overflow: hidden;
    }

    .right {
        width: 300px;
        display: flex;
        flex-direction: column;
        padding: 10px;
        box-sizing: border-box;
        padding-top: 50px;
    }

    .wrap {
        position: absolute;
        left: 0;
        bottom: 40px;
        width: 288px;
        height: 400px;
        margin-left: -144px;
        text-align: left;
        overflow: hidden;
        font-size: 12px;
        font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
        line-height: 1.5;
    }

    .wrap * {
        padding: 0;
        margin: 0;
    }

    .wrap .info {
        width: 288px;
        height: 390px;
        border-radius: 5px;
        border-bottom: 2px solid #ccc;
        border-right: 1px solid #ccc;
        overflow: hidden;
        background: #fff;
    }

    .wrap .info:nth-child(1) {
        border: 0;
        box-shadow: 0px 1px 2px #888;
    }

    .info .title {
        padding: 5px 0 0 10px;
        height: 30px;
        background: black;
        border-bottom: 1px solid #ddd;
        font-size: 18px;
        font-weight: bold;
        color: white;
    }

    .info .close {
        position: absolute;
        top: 10px;
        right: 10px;
        color: #888;
        width: 17px;
        height: 17px;
        background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
        cursor: pointer;
    }

    .info .close:hover {
        cursor: pointer;
    }

    .desc .ellipsis {
        padding: 10px;
        height: 100px;
        white-space: normal;
    }

    .info .img {
        margin: 20px;
        width: 245px;
        height: 200px;
        color: #888;
        overflow: hidden;
    }

    .img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .img>img {
        width: 100%;
    }

    .info:after {
        content: '';
        position: absolute;
        margin-left: -12px;
        left: 50%;
        bottom: 0;
        width: 22px;
        height: 12px;
        background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
    }

    .container .markerImage {
        margin: 25px 10px 20px 10px;
        height: auto;
        flex-shrink: 0;
    }

    #inputFile {
        margin-top: 20px;
        margin-bottom: 10px;
        padding: 8px;
        background-color: black;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    input[type="button"] {
        width: calc(100% - 0px);
        height: 40px;
        padding: 8px 20px;
        background-color: black;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-bottom: 10px;
    }

    input[type="button"]:hover {
        background-color: rgb(56, 56, 56);
    }

    textarea {
        height: 100px;
        resize: none;
        /* margin-bottom: -3px; */
    }

    .markerContainer {
        display: flex;
        flex-wrap: wrap;
        margin-bottom: 20px;
    }

    #lat,
    #lng,
    #markerImage,
    #fileInput {
        display: none;
    }
</style>

<section class="write_section">
	<form action="doWrite" method="POST">
		<div class="container">
	        <div class="left">
	            <div id="map" style="width:100%;height:100%;"></div>
	        </div>
	        <div class="right">
	            <input id="add" type="text" placeholder="주소 검색">
	            <input type="button" value="검색" onclick="getAdd()"> <br>
	            <input type="text" name="lat" id="lat">
	            <input type="text" name="lng" id="lng">
	
	            <input name="title" id="title" type="text" placeholder="제목 입력">
	            <textarea name="content" id="content" placeholder="내용 입력"></textarea>
	
	            <input type="file" id="inputFile">
	            <textarea name="fileInput" id="fileInput"></textarea>
	            <!-- <div id="fileContent"></div> -->
	
	            <div class="markerContainer">
	                <img name="" class="markerImage" src="https://ifh.cc/g/2VQZpg.png" alt="My Image" width="50px" height="50px">
	                <img class="markerImage" src="https://ifh.cc/g/blcCLq.png" alt="My Image" width="50px" height="50px">
	                <img class="markerImage" src="https://ifh.cc/g/K6oJB0.png" alt="My Image" width="50px" height="50px">
	                <img class="markerImage" src="https://ifh.cc/g/yTrlgb.png" alt="My Image" width="50px" height="50px">
	                <img class="markerImage" src="https://ifh.cc/g/wSc06k.png" alt="My Image" width="50px" height="50px">
	                <img class="markerImage" src="https://ifh.cc/g/KXKFCW.png" alt="My Image" width="50px" height="50px">
	                <img class="markerImage" src="https://ifh.cc/g/4F85Ca.png" alt="My Image" width="50px" height="50px">
	                <img class="markerImage" src="https://ifh.cc/g/4cyHWQ.png" alt="My Image" width="50px" height="50px">
	                <input name="markerImage" id="markerImage" type="text">
	            </div>
	
	            <input type="button" value="저장" onclick="saveData()">
	        </div>
    	</div>
	</form>
</section>

<script type="text/javascript"
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=716e318dde95cbbb638178aeea7926f8&libraries=services">
</script>

<script>
    let content2 = '';
    let title = '';
    let overlay;
    let marker;

    function getAdd() {
        const add = document.querySelector('#add').value;
        search(add);
        // const la = coords.La;
        // console.log(la);
        document.querySelector('#add').value = '';
    }

    // function getTitle() {
    //     tit = document.querySelector('#tit').value;
    //     document.querySelector('#info-title > div').insertAdjacentHTML("beforebegin", tit);
    //     document.querySelector('#tit').value = '';
    // }

    // function getText() {
    //     content2 = document.querySelector('#content').value;
    //     document.querySelector('#info-content').innerHTML = content2;
    //     document.querySelector('#content').value = '';
    // }

    function saveData() {
        title = document.querySelector('#title').value;
        document.querySelector('#info-title > div').insertAdjacentHTML("beforebegin", title);
        document.querySelector('#title').value = '';

        content2 = document.querySelector('#content').value;
        document.querySelector('#info-content').innerHTML = content2;
        document.querySelector('#content').value = '';
    }

    document.getElementById('inputFile').addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (!file) {
            return;
        }

        const reader = new FileReader();

        reader.onload = function (event) {
            const fileContents = event.target.result;

            displayFileContents(fileContents);
        };

        reader.readAsDataURL(file);
    });

    function displayFileContents(contents) {
        const imgElement = document.getElementById('img');
        imgElement.src = contents;
        document.getElementById('fileInput').value = imgElement.src;
        // console.log(document.getElementById('fileInput').value);
        // console.log(imgElement.src);
        // document.getElementById('inputFile').value = '';
    }

    var map;

    navigator.geolocation.getCurrentPosition(function (position) {
        var lat = position.coords.latitude;
        var lng = position.coords.longitude;

        var mapOption = {
            center: new kakao.maps.LatLng(lat, lng),
            level: 4
        };

        map = new kakao.maps.Map(document.getElementById('map'), mapOption);
    });

    var geocoder = new kakao.maps.services.Geocoder();

    function search(add) {
        title = '';
        content2 = '';
        geocoder.addressSearch(add, function (result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                const la = coords.La;
                const ln = coords.Ma;
                console.log(la);
                console.log(ln);
                document.getElementById('lat').value = la;
                document.getElementById('lng').value = ln;

                var markerImage = new kakao.maps.MarkerImage(
                    'https://ifh.cc/g/JXqvJr.png',
                    new kakao.maps.Size(35, 35),
                    {
                        offset: new kakao.maps.Point(20, 40)
                    }
                );
                marker = new kakao.maps.Marker({
                    map: map,
                    position: coords,
                    image: markerImage
                });
                var content = '<div class="wrap">' +
                    '    <div class="info">' +
                    '        <div class="title" id="info-title">' +
                    `            ${title}` +
                    '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                    '        </div>' +
                    '        <div class="body">' +
                    '            <div class="img">' +
                    '               <img id="img" src="">' +
                    '           </div>' +
                    '            <div class="desc">' +
                    `                <div class="ellipsis" id="info-content">${content2}</div>` +
                    '            </div>' +
                    '        </div>' +
                    '    </div>' +
                    '</div>';
                overlay = new kakao.maps.CustomOverlay({
                    content: content,
                    map: map,
                    position: marker.getPosition()
                });
                kakao.maps.event.addListener(marker, 'click', function () {
                    overlay.setMap(map);
                });
                map.setCenter(coords);
            }
        });
    }

    function closeOverlay() {
        overlay.setMap(null);
    }

    document.querySelectorAll('.markerImage').forEach(function (element) {
        element.addEventListener('click', function () {
            changeMarkerImage(element.src);
        });
    });

    let selectedMarkerImageSrc = '';

    function changeMarkerImage(imageSrc) {
        document.getElementById('markerImage').value = imageSrc;
        if (!marker) {
            var latLng = new kakao.maps.LatLng(0, 0);
            marker = new kakao.maps.Marker({
                map: map,
                position: latLng
            });
        }

        var markerImage = new kakao.maps.MarkerImage(
            imageSrc,
            new kakao.maps.Size(35, 35),
            { offset: new kakao.maps.Point(18, 40) }
        );
        marker.setImage(markerImage);
    }
</script>

</body>
</html>