<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	<link rel="stylesheet" href="/resources/css/space/spaceList.css">
    <!-- FullCalendar Core -->
    <link href="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/main.min.css" rel="stylesheet">
    <!-- FullCalendar DayGrid Plugin (달력 보기) -->
    <link href="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.15/main.min.css" rel="stylesheet">
    <!-- FullCalendar Core JS -->
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@6.1.15/index.global.min.js"></script>
    <!-- FullCalendar DayGrid Plugin JS -->
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@6.1.15/index.global.min.js"></script>
    <!-- FullCalendar Interaction Plugin JS (날짜 클릭 등 상호작용 기능) -->
    <script src="https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@6.1.15/index.global.min.js"></script>

</head>
<body class="spaceList">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

    <div class="modalShadowBox"></div>

    <main class="spaceListMain">
        <div class="mainSearchBox">
            <div class="mainSearchBtnBox">
                <button class="mainSearchSearchBtn">검색</button>
                <button class="mainSearchResetBtn">초기화</button>
            </div>
            <div class="mainSearch">
                <div class="mainSearchLocal">
                    <p>지역</p>
                    <p class="localPoint">어느 지역을 찾으세요?</p>
                    <div class="mainSearchLocalInput mainSearchSelect">
                        <div class="localItem">서울</div>
                        <div class="localItem">인천</div>
                        <div class="localItem">부산</div>
                        <div class="localItem">용산</div>
                        <div class="localItem">용인</div>
                        <div class="localItem">천안</div>
                        <div class="localItem">춘천</div>
                    </div>
                </div>
                <div class="mainSearchPlace">
                    <p>공간유형</p>
                    <p class="placePoint">어떤 유형의 공간을 찾으시나요?</p>
                    <div class="mainSearchPlaceInput mainSearchSelect">
                        <div class="placeItem">스튜디오</div>
                        <div class="placeItem">파티룸</div>
                        <div class="placeItem">스터디</div>
                        <div class="placeItem">레저</div>
                        <div class="placeItem">게임</div>
                        <div class="placeItem">회의</div>
                        <div class="placeItem">헬스</div>
                    </div>
                </div>
                <div class="mainSearchPeople">
                    <p>인원</p>
                    <p class="peoplePoint">몇명이 이용하시나요?</p>
                    <div class="mainSearchPeopleInput mainSearchSelect">
                        <div class="peopleBox">
                            <button class="peopleMinus">-</button>
                            <input type="text" class="quantity" id="quantity" value="0">
                            <button class="peoplePlus">+</button>
                        </div>
                        <div>
                            <button class="peopleSelect">적용</button>
                        </div>
                    </div>
                </div>
                <div class="mainSearchDate">
                    <p>날짜</p>
                    <p class="datePoint">대여 날짜는 언제인가요?</p>
                    <div class="mainSearchDateInput mainSearchSelect">
                        <div id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="spaceListSelectBox">
            <div class="spaceListTotalCntBox">
                <span class="spaceListTotalCnt">215</span>개
            </div>
            <select name="spaceListSort" onchange="spaceListSorting()" class="spaceListSelect" id="spaceListSelect">
                <option value="1">인기순</option>
                <option value="2">낮은 가격순</option>
                <option value="3">높은 가격순</option>
                <option value="4">조회순</option>
                <option value="5">후기순</option>
                <option value="6">평점 높은순</option>
            </select>
        </div>

        <!-- <h1 class="mainContentTitle">Our Space!</h1> -->

        <div class="mainContentsBox">
            <a href="javascript:void(0)" onclick="" class="mainItemCard">
                <img src="/img/item/c1.jpg">
                <div class="mainItemCardScript">
                    <div class="mainItemCardScriptTop">
                        <h3>고급 플레이스</h3>
                        <div class="CardScriptTopRight">
                            <img src="/icon/star_filled.svg">
                            <span>50</span>
                            <img src="/icon/heart_lineLight_gray.svg">
                            <span>20</span>
                        </div>
                    </div>
                    <p>서울 강북</p>
                    <p>50,000$</p>
                </div>
            </a>
            <a href="javascript:void(0)" onclick="" class="mainItemCard">
                <img src="/img/item/c1.jpg">
                <div class="mainItemCardScript">
                    <div class="mainItemCardScriptTop">
                        <h3>고급 플레이스</h3>
                        <div class="CardScriptTopRight">
                            <img src="/icon/star_filled.svg">
                            <span>50</span>
                            <img src="/icon/heart_lineLight_gray.svg">
                            <span>20</span>
                        </div>
                    </div>
                    <p>서울 강북</p>
                    <p>50,000$</p>
                </div>
            </a>
            <a href="javascript:void(0)" onclick="" class="mainItemCard">
                <img src="/img/item/c1.jpg">
                <div class="mainItemCardScript">
                    <div class="mainItemCardScriptTop">
                        <h3>고급 플레이스</h3>
                        <div class="CardScriptTopRight">
                            <img src="/icon/star_filled.svg">
                            <span>50</span>
                            <img src="/icon/heart_lineLight_gray.svg">
                            <span>20</span>
                        </div>
                    </div>
                    <p>서울 강북</p>
                    <p>50,000$</p>
                </div>
            </a>
            <a href="javascript:void(0)" onclick="" class="mainItemCard">
                <img src="/img/item/c1.jpg">
                <div class="mainItemCardScript">
                    <div class="mainItemCardScriptTop">
                        <h3>고급 플레이스</h3>
                        <div class="CardScriptTopRight">
                            <img src="/icon/star_filled.svg">
                            <span>50</span>
                            <img src="/icon/heart_lineLight_gray.svg">
                            <span>20</span>
                        </div>
                    </div>
                    <p>서울 강북</p>
                    <p>50,000$</p>
                </div>
            </a>
            <a href="javascript:void(0)" onclick="" class="mainItemCard">
                <img src="/img/item/c1.jpg">
                <div class="mainItemCardScript">
                    <div class="mainItemCardScriptTop">
                        <h3>고급 플레이스</h3>
                        <div class="CardScriptTopRight">
                            <img src="/icon/star_filled.svg">
                            <span>50</span>
                            <img src="/icon/heart_lineLight_gray.svg">
                            <span>20</span>
                        </div>
                    </div>
                    <p>서울 강북</p>
                    <p>50,000$</p>
                </div>
            </a>
            <a href="javascript:void(0)" onclick="" class="mainItemCard">
                <img src="/img/item/c1.jpg">
                <div class="mainItemCardScript">
                    <div class="mainItemCardScriptTop">
                        <h3>고급 플레이스</h3>
                        <div class="CardScriptTopRight">
                            <img src="/icon/star_filled.svg">
                            <span>50</span>
                            <img src="/icon/heart_lineLight_gray.svg">
                            <span>20</span>
                        </div>
                    </div>
                    <p>서울 강북</p>
                    <p>50,000$</p>
                </div>
            </a>
            <a href="javascript:void(0)" onclick="" class="mainItemCard">
                <img src="/img/item/c1.jpg">
                <div class="mainItemCardScript">
                    <div class="mainItemCardScriptTop">
                        <h3>고급 플레이스</h3>
                        <div class="CardScriptTopRight">
                            <img src="/icon/star_filled.svg">
                            <span>50</span>
                            <img src="/icon/heart_lineLight_gray.svg">
                            <span>20</span>
                        </div>
                    </div>
                    <p>서울 강북</p>
                    <p>50,000$</p>
                </div>
            </a>
            <a href="javascript:void(0)" onclick="" class="mainItemCard">
                <img src="/img/item/c1.jpg">
                <div class="mainItemCardScript">
                    <div class="mainItemCardScriptTop">
                        <h3>고급 플레이스</h3>
                        <div class="CardScriptTopRight">
                            <img src="/icon/star_filled.svg">
                            <span>50</span>
                            <img src="/icon/heart_lineLight_gray.svg">
                            <span>20</span>
                        </div>
                    </div>
                    <p>서울 강북</p>
                    <p>50,000$</p>
                </div>
            </a>
            
        </div>
        <div class="ttt">
        	<button class="mainItemMoreBtn">more</button>
        </div>
        <button class="toTopBtn" style="position: fixed; bottom: 40px; right: 40px; z-index: 1000;">↑</button>
    </main>

    <script>
        $("header").load("/header.html");

        $(".toTopBtn").on("click", function() {
            $('html, body').animate({ scrollTop: 0 }, 500);
        });

        function spaceListSorting() {
            
        };

        $(".mainSearchLocal").on("click", function() {
            $(".mainSearchLocalInput").css("display", "grid");
            $(".modalShadowBox").css("display", "block");
            $("body").addClass("modalMouse");
            $(".mainSearchBox")[0].scrollIntoView();
        });

        $(".localItem").on("click", function(e) {
            $(".localPoint").css("display", "none");
            $(".mainSearchInput").html("");
            $(".mainSearchLocal").append('<p class="mainSearchInput">'+e.target.textContent+'</p>');
            modalNone();
        });

        $(".mainSearchPlace").on("click", function() {
            $(".mainSearchPlaceInput").css("display", "grid");
            $(".modalShadowBox").css("display", "block");
            $("body").addClass("modalMouse");
            $(".mainSearchBox")[0].scrollIntoView();
        });

        $(".placeItem").on("click", function(e) {
            $(".placePoint").css("display", "none");
            $(".mainSearchItemPlaceInput").html("");
            $(".mainSearchPlace").append('<p class="mainSearchItemPlaceInput">'+e.target.textContent+'</p>');
            modalNone();
        });

        $(".mainSearchPeople").on("click", function() {
            $(".mainSearchPeopleInput").css("display", "flex");
            $(".modalShadowBox").css("display", "block");
            $("body").addClass("modalMouse");
            $(".mainSearchBox")[0].scrollIntoView();
        });

        const minusButton = $(".peopleMinus");
        const plusButton = $(".peoplePlus");
        const peopleInpField = $(".quantity");

        minusButton.on("click", function() {
            let value = parseInt(peopleInpField.val(), 10);
            if (!isNaN(value) && value > 0) {
                peopleInpField.val(value - 1);
            }
        });

        plusButton.on("click", function() {
            let value = parseInt(peopleInpField.val(), 10);
            if (!isNaN(value)) {
                peopleInpField.val(value + 1);
            }
        });
        
        $(".peopleSelect").on("click", function() {
            $(".peoplePoint").css("display", "none");
            $(".mainSearchItemPeopleInput").html("");
            $(".mainSearchPeople").append("<p class='mainSearchItemPeopleInput'>" + peopleInpField.val() + "</p>");
            modalNone();
        });

        function modalNone() {
            setTimeout(function() {
                $(".mainSearchSelect").css("display", "none");
                $(".modalShadowBox").css("display", "none");
                $("body").removeClass("modalMouse");
            }, 0);
        }

        $(".modalShadowBox").on("click", function() {
            $(".mainSearchSelect").css("display", "none");
            $(".modalShadowBox").css("display", "none");
            $("body").removeClass("modalMouse");
        });

        $(".mainSearchSearchBtn").on("click", function() {

        });

        $(".mainSearchResetBtn").on("click", function() {
            $(".localPoint").css("display", "block");
            $(".placePoint").css("display", "block");
            $(".peoplePoint").css("display", "block");
            $(".datePoint").css("display", "block");

            $(".mainSearchItemPlaceInput").remove();
            $(".mainSearchInput").remove();
            $(".mainSearchItemPeopleInput").remove();
            $(".mainSearchItemDateInput").remove();
        });

        document.addEventListener('DOMContentLoaded', function () {
            const calendarEl = document.getElementById('calendar');

            let today = new Date().toISOString().split('T')[0];

            const calendar = new FullCalendar.Calendar(calendarEl, {
                locale: 'ko',  // 한글로 표시
                selectable: true,  // 날짜 선택 가능
                headerToolbar: {  // 상단 툴바 설정
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth'
                },
                validRange: {
                    start:  today // 오늘 이후부터 선택 가능
                },
                dayCellDidMount: function (info) {
                    const cellDate = info.date.toISOString().split('T')[0];

                    if (cellDate < today) {
                        // 비활성화된 날짜 스타일 추가
                        info.el.style.backgroundColor = '#eee'; // 연한 회색
                        info.el.style.color = '#d3d3d3'; // 텍스트 색상도 흐리게
                        info.el.style.pointerEvents = 'none'; // 클릭 방지
                    }
                },
                dateClick: function (info) {
                    // alert('클릭한 날짜: ' + info.dateStr);  // 날짜 클릭 시 알림
                    $(".datePoint").css("display", "none");
                    $(".mainSearchItemDateInput").html("");
                    $(".mainSearchDate").append("<p class='mainSearchItemDateInput' style='color: black; font-size: 20px; font-weight: bold;'>" + info.dateStr + "</p>");
                    $(".mainSearchDateInput").css("display", "none");
                    modalNone();
                }
            });

            calendar.render();  // 달력 렌더링

            $(".mainSearchDate").on("click", function() {
                setTimeout(function() {
                    calendar.render();  // 달력 렌더링
                }, 0);
                $(".mainSearchDateInput").css("display", "block");
                $(".modalShadowBox").css("display", "block");
                $("body").addClass("modalMouse");
                $(".mainSearchBox")[0].scrollIntoView();
            });
        });
    </script>
    	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
    
</body>
</html>