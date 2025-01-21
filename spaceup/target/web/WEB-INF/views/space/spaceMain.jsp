<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Responsive Carousel</title>
<link rel="stylesheet" href="/resources/css/space/	spaceMain.css">
<script src="https://kit.fontawesome.com/a5c51740a4.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>

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
<body class="main">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div class="modalShadowBox"></div>

	<div class="carousel">
		<div class="carousel-container">
			<img src="/resources/images/space/spaceMain/s1.png" alt="Image 1"> <img src="/resources/images/space/spaceMain/s2.png" alt="Image 2"> <img src="/resources/images/space/spaceMain/s3.png" alt="Image 3">
		</div>
		<button class="prev-btn">❮</button>
		<button class="next-btn">❯</button>
	</div>

	<main>
		<div class="mainSearchBox">
			<div class="mainSearchBoxTitle">
				<p>TEST 공간 파인더</p>
			</div>
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
		<div class="mainCateBox">
			<a href="javascript:void(0)" onclick="" class="mainCateCard" data-aos="fade-up" data-aos-duration="800" data-aos-delay="0"> <i class="fa-solid fa-video"></i>
				<h2>드라마/영화/촬영</h2> <span>#공간</span>
			</a>
			<div class="mainCateCard" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
				<i class="fa-solid fa-champagne-glasses"></i>
				<h2>파티</h2>
				<span>#공간</span>
			</div>
			<div class="mainCateCard" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
				<i class="fa-regular fa-calendar-days"></i>
				<h2>스터디/모임</h2>
				<span>#공간</span>
			</div>
			<div class="mainCateCard" data-aos="fade-up" data-aos-duration="800" data-aos-delay="300">
				<i class="fa-solid fa-dumbbell"></i>
				<h2>레저/헬스</h2>
				<span>#공간</span>
			</div>
			<div class="mainCateCard" data-aos="fade-up" data-aos-duration="800" data-aos-delay="400">
				<i class="fa-solid fa-gamepad"></i>
				<h2>게임/이벤트</h2>
				<span>#공간</span>
			</div>
			<div class="mainCateCard" data-aos="fade-up" data-aos-duration="800" data-aos-delay="500" data-aos-anchor=".mainCateCard">
				<i class="fa-solid fa-headset"></i>
				<h2>회의</h2>
				<span>#공간</span>
			</div>
		</div>

		<div class="bestSlideContainer">
			<h1 class="bestSlideTitle">Best Space!</h1>
			<div class="bestSlideBox">
				<div class="bestSlideList">
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span class="bestSlideItemTextTitle">서울에 있는 파티</span> <span class="bestSlideItemTextPlace">서울 영등포구</span> <strong class="bestSlideItemTextPrice"> <span><span>70,000 </span>원/시간</span>
								<div class="bestItemCntBox">
									<span class="maxPeople"><img src="/icon/user-icon.svg">8</span> <span class="reviewCnt"><img src="/icon/review-icon.svg">12</span> <span class="likeyCnt"><img src="/icon/likey-icon.svg">9</span>
								</div>
							</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="bestSlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
				</div>
			</div>
			<div class="bestSlideBtnBox">
				<div class="bestSlidePrevBtn"></div>
				<div class="bestSlideNextBtn"></div>
			</div>
		</div>

		<div class="newItemContainer">
			<h1 class="newSlideTitle">New!</h1>
			<div class="newItemBox">
				<div class="newItem">
					<div class="bestSlideItemImgBox">
						<img src="/img/item/c1.jpg">
					</div>
					<div class="bestSlideItemTextBox">
						<span class="bestSlideItemTextTitle">서울에 있는 파티</span> <span class="bestSlideItemTextPlace">서울 영등포구</span> <strong class="bestSlideItemTextPrice"> <span><span>70,000 </span>원/시간</span>
							<div class="bestItemCntBox">
								<span class="maxPeople"><img src="/icon/user-icon.svg">8</span> <span class="reviewCnt"><img src="/icon/review-icon.svg">12</span> <span class="likeyCnt"><img src="/icon/likey-icon.svg">9</span>
							</div>
						</strong>
					</div>
				</div>
				<div class="newItem">
					<div class="bestSlideItemImgBox">
						<img src="/img/item/c1.jpg">
					</div>
					<div class="bestSlideItemTextBox">
						<span class="bestSlideItemTextTitle">서울에 있는 파티</span> <span class="bestSlideItemTextPlace">서울 영등포구</span> <strong class="bestSlideItemTextPrice"> <span><span>70,000 </span>원/시간</span>
							<div class="bestItemCntBox">
								<span class="maxPeople"><img src="/icon/user-icon.svg">8</span> <span class="reviewCnt"><img src="/icon/review-icon.svg">12</span> <span class="likeyCnt"><img src="/icon/likey-icon.svg">9</span>
							</div>
						</strong>
					</div>
				</div>
				<div class="newItem">
					<div class="bestSlideItemImgBox">
						<img src="/img/item/c1.jpg">
					</div>
					<div class="bestSlideItemTextBox">
						<span class="bestSlideItemTextTitle">서울에 있는 파티</span> <span class="bestSlideItemTextPlace">서울 영등포구</span> <strong class="bestSlideItemTextPrice"> <span><span>70,000 </span>원/시간</span>
							<div class="bestItemCntBox">
								<span class="maxPeople"><img src="/icon/user-icon.svg">8</span> <span class="reviewCnt"><img src="/icon/review-icon.svg">12</span> <span class="likeyCnt"><img src="/icon/likey-icon.svg">9</span>
							</div>
						</strong>
					</div>
				</div>
				<div class="newItem">
					<div class="bestSlideItemImgBox">
						<img src="/img/item/c1.jpg">
					</div>
					<div class="bestSlideItemTextBox">
						<span class="bestSlideItemTextTitle">서울에 있는 파티</span> <span class="bestSlideItemTextPlace">서울 영등포구</span> <strong class="bestSlideItemTextPrice"> <span><span>70,000 </span>원/시간</span>
							<div class="bestItemCntBox">
								<span class="maxPeople"><img src="/icon/user-icon.svg">8</span> <span class="reviewCnt"><img src="/icon/review-icon.svg">12</span> <span class="likeyCnt"><img src="/icon/likey-icon.svg">9</span>
							</div>
						</strong>
					</div>
				</div>
				<div class="newItem">
					<div class="bestSlideItemImgBox">
						<img src="/img/item/c1.jpg">
					</div>
					<div class="bestSlideItemTextBox">
						<span class="bestSlideItemTextTitle">서울에 있는 파티</span> <span class="bestSlideItemTextPlace">서울 영등포구</span> <strong class="bestSlideItemTextPrice"> <span><span>70,000 </span>원/시간</span>
							<div class="bestItemCntBox">
								<span class="maxPeople"><img src="/icon/user-icon.svg">8</span> <span class="reviewCnt"><img src="/icon/review-icon.svg">12</span> <span class="likeyCnt"><img src="/icon/likey-icon.svg">9</span>
							</div>
						</strong>
					</div>
				</div>
				<div class="newItem">
					<div class="bestSlideItemImgBox">
						<img src="/img/item/c1.jpg">
					</div>
					<div class="bestSlideItemTextBox">
						<span class="bestSlideItemTextTitle">서울에 있는 파티</span> <span class="bestSlideItemTextPlace">서울 영등포구</span> <strong class="bestSlideItemTextPrice"> <span><span>70,000 </span>원/시간</span>
							<div class="bestItemCntBox">
								<span class="maxPeople"><img src="/icon/user-icon.svg">8</span> <span class="reviewCnt"><img src="/icon/review-icon.svg">12</span> <span class="likeyCnt"><img src="/icon/likey-icon.svg">9</span>
							</div>
						</strong>
					</div>
				</div>
			</div>

			<button class="newItemListBtn">새로운 공간 더보기</button>

		</div>

		<div class="bestSlideContainer">
			<h1 class="bestSlideTitle">Likey Space!</h1>
			<div class="bestSlideBox">
				<div class="likeySlideList">
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span>파티룸 서울</span> <span>감성 파티룸입니다.</span> <strong>70,000$</strong>
						</div>
					</div>
					<div class="likeySlideItem">
						<div class="bestSlideItemImgBox">
							<img src="/img/item/c1.jpg">
						</div>
						<div class="bestSlideItemTextBox">
							<span class="bestSlideItemTextTitle">파티룸 서울</span> <span class="bestSlideItemTextPlace">감성 파티룸입니다.</span> <strong class="bestSlideItemTextPrice">70,000$</strong>
						</div>
					</div>
				</div>
			</div>
			<div class="bestSlideBtnBox">
				<div class="likeySlidePrevBtn"></div>
				<div class="likeySlideNextBtn"></div>
			</div>
		</div>

	</main>





	<script>
    $("header").load("/header.html");

    AOS.init({once: true});

    const carouselContainer = document.querySelector('.carousel-container');
    const prevButton = document.querySelector('.prev-btn');
    const nextButton = document.querySelector('.next-btn');

    let currentIndex = 0;
    const totalImages = document.querySelectorAll('.carousel-container img').length;

    nextButton.addEventListener('click', () => {
        currentIndex = (currentIndex + 1) % totalImages;
        updateCarousel();
    });

    prevButton.addEventListener('click', () => {
        currentIndex = (currentIndex - 1 + totalImages) % totalImages;
        updateCarousel();
    });

    function updateCarousel() {
        const offset = -currentIndex * 100;
        carouselContainer.style.transform = `translateX(${offset}vw)`;
    }

    bSList = $(".bestSlideList");
    
    let testLate = 0;
    let totlaItems = $(".bestSlideItem").length;
    let curSlideCnt = 0;

    $(".bestSlidePrevBtn").on("click", function() {
        if(curSlideCnt > 0) {
            curSlideCnt = (curSlideCnt - 1 + totlaItems) % (totlaItems / 2)
            moveCarousel();
        }
    });

    $(".bestSlideNextBtn").on("click", function() {
        if(curSlideCnt < 4) {
            console.log(curSlideCnt);
            curSlideCnt = (curSlideCnt + 1) % (totlaItems / 2)
            moveCarousel();
        }
    });

    lSList = $(".likeySlideList");
    
    let likeyTotlaItems = $(".likeySlideItem").length;
    let likeyCurSlideCnt = 0;

    $(".likeySlidePrevBtn").on("click", function() {
        if(likeyCurSlideCnt > 0) {
            likeyCurSlideCnt = (likeyCurSlideCnt - 1 + likeyTotlaItems) % (likeyTotlaItems / 2)
            likeyMoveCarousel();
        }
    });

    $(".likeySlideNextBtn").on("click", function() {
        if(likeyCurSlideCnt < 4) {
            likeyCurSlideCnt = (likeyCurSlideCnt + 1) % (likeyTotlaItems / 2)
            likeyMoveCarousel();
        }
    });

    function moveCarousel() {
        const offset = -curSlideCnt * (20);
        bSList.css("transform", `translateX(${offset}%)`);
    }

    function likeyMoveCarousel() {
        const offset = -likeyCurSlideCnt * (20);
        lSList.css("transform", `translateX(${offset}%)`);
        console.log("move");
    }

    $(".mainSearchLocal").on("click", function() {
        $(".mainSearchLocalInput").css("display", "grid");
        $(".modalShadowBox").css("display", "block");
        $("body").addClass("modalMouse");
        $(".mainSearchBox")[0].scrollIntoView();
    });

    $(".localItem").on("click", function(e) {
        $(".localPoint").css("display", "none");
        $(".mainSearchInput").html("");
        $(".mainSearchLocal").append('<p class="mainSearchInput"  style="color: black; font-size: 20px; font-weight: bold;">'+e.target.textContent+'</p>');
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
        $(".mainSearchPlace").append('<p class="mainSearchItemPlaceInput" style="color: black; font-size: 20px; font-weight: bold;">'+e.target.textContent+'</p>');
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
        $(".mainSearchPeople").append("<p class='mainSearchItemPeopleInput' style='color: black; font-size: 20px; font-weight: bold;'>" + peopleInpField.val() + "</p>");
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
    
</script>

	<script>
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
