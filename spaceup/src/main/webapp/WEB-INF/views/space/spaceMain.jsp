<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/space/spaceMain.css">
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

<script type="text/javascript">
$(document).ready(function() {
    $("#newItemListBtn").on("click", function() {
        location.href = "/space/spaceList";
    });
    
    $("#mainSearchSearchBtn").on("click", function() {
    	document.mainSearchForm.action = "/space/spaceList";
    	document.mainSearchForm.submit();
    });
    
    $("#mainSearchResetBtn").on("click", function() {
    	document.mainSearchForm.spaceAddrBar.value = "";
    	document.mainSearchForm.spaceTypeBar.value = "";
    	document.mainSearchForm.spaceMaxCapacityBar.value = "";
    	document.mainSearchForm.reservationTimeBar.value = "";
    });
});

function mainCateFunction(number) {
	document.mainCateForm.spaceTypeBar.value = number;
	document.mainCateForm.action = "/space/spaceList";
	document.mainCateForm.submit();
}

//좋아요 클릭시
function likeyPress(spaceId)
{
	//  추가
	event.stopPropagation(); // 이벤트 버블링 중단
	
	$.ajax({
    	type:"POST",
    	url:"/space/likeCheckProc",
    	data:{
    		
    		spaceId: spaceId    		
    	},
 	    datatype:"JSON",
		beforeSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", "true");
		},						
		success:function(response)
		{        
		  let likeyImg = $("#heartLikeyButton-" + spaceId + " img");
		
		    if (response.code == 0)
		    {	               
		        // 이미지 바꾸기
		        likeyImg.attr("src", "/resources/images/space/icon/heartallwhite.png");
		        
		       // 애니메이션 효과 적용
		       likeyImg.addClass('scale-up-center');
		
		       // 애니메이션이 끝난 후 클래스 제거
		       setTimeout(function () {
		           likeyImg.removeClass('scale-up-center');
		       }, 500);
		    }
		    else if (response.code == 1)
		    {	               
		        // 이미지 바꾸기
		        likeyImg.attr("src", "/resources/images/space/icon/heartwhite.png");
		        
		       // 애니메이션 효과 적용
		       likeyImg.addClass('scale-up-center');
		
		       // 애니메이션이 끝난 후 클래스 제거
		       setTimeout(function () {
		           likeyImg.removeClass('scale-up-center');
		       }, 500);
		    }
			else if(response.code == 2)
			{
			   //alert("좋아요 취소 오류");
			   console.log("좋아요 오류1");
			          
			}
			else if(response.code == 404)
			{
			  // alert("해당 공간을 찾을 수 없습니다.");
				console.log("좋아요 오류2");
			   
			}
			else if(response.code == 500)
			{
			   //alert("좋아요 성공 오류 입니다.");
				console.log("좋아요 오류3");
			   
			}
			else if(response.code == 400) 
			{
			 alert(response.msg);
			 location.href = "/guest/loginForm";
			}
			else
			{
			   //alert("좋아요 중 오류가 발생하였습니다.");
				console.log("좋아요 오류");
			      
			}		   
		},
    	error:function(error)
    	{
    		icia.common.error(error);
    		console.log("공간 좋아요 중 오류가 발생하였습니다.");
    		
    	}
    });
}
</script>
</head>
<body class="main">
<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div class="modalShadowBox"></div>

	<div class="carousel">
		<div class="carousel-container">
			<img src="/resources/images/space/spaceMainBanner/s1.jpg" alt="Image 1">
			<img src="/resources/images/space/spaceMainBanner/s2.jpg" alt="Image 2">
			<img src="/resources/images/space/spaceMainBanner/s3.jpg" alt="Image 3">
			<img src="/resources/images/space/spaceMainBanner/s4.jpg" alt="Image 4">
		</div>
		<button class="prev-btn"><img src="/resources/images/space/icon/chevron_left_b.svg" /></button>
		<button class="next-btn"><img src="/resources/images/space/icon/chevron_right_b.svg" /></button>
	</div>

	<main>
		<div class="mainSearchBox">
			<div class="mainSearchBoxTitle">
				<p>SPACEUP 공간 파인더</p>
			</div>
			<div class="mainSearchBtnBox">
				<button class="mainSearchSearchBtn" id="mainSearchSearchBtn">검색</button>
				<button class="mainSearchResetBtn" id="mainSearchResetBtn">초기화</button>
			</div>
			<div class="mainSearch">
				<div class="mainSearchLocal">
					<p>지역</p>
					<p class="localPoint">어느 지역을 찾으세요?</p>
					<div class="mainSearchLocalInput mainSearchSelect">
						<div class="localItem" value="서울">서울</div>
						<div class="localItem" value="인천">인천</div>
						<div class="localItem" value="부산">부산</div>
						<div class="localItem" value="용산">용산</div>
						<div class="localItem" value="용인">용인</div>
						<div class="localItem" value="천안">천안</div>
						<div class="localItem" value="춘천">춘천</div>
					</div>
				</div>
				<div class="filterDivider"></div>
				<div class="mainSearchPlace">
					<p>공간유형</p>
					<p class="placePoint">어떤 유형의 공간을 찾으시나요?</p>
					<div class="mainSearchPlaceInput mainSearchSelect">
						<div class="placeItem" value="1">
							<img src="/resources/images/space/icon/partyroom.svg" />
							<p>파티룸</p>
						</div>
						<div class="placeItem" value="2">
							<img src="/resources/images/space/icon/dance.svg" />
							<p>연습실</p>
						</div>
						<div class="placeItem" value="3">
							<img src="/resources/images/space/icon/study.svg" />
							<p>스터디룸</p>
						</div>
						<div class="placeItem" value="4">
							<img src="/resources/images/space/icon/kitchen.svg" style="width: 23px;" />
							<p>공유주방</p>
						</div>
						<div class="placeItem" value="5">
							<img src="/resources/images/space/icon/studio.svg" />
							<p>스튜디오</p>
						</div>
						<div class="placeItem" value="6">
							<img src="/resources/images/space/icon/cafe.svg" />
							<p>카페</p>
						</div>
						<div class="placeItem" value="7">
							<img src="/resources/images/space/icon/officeShare.svg" />
							<p>오피스</p>
						</div>
						<div class="placeItem" value="8">
							<img src="/resources/images/space/icon/wedding.svg" style="width: 23px;"/>
							<p>스몰웨딩</p>
						</div>
						<div class="placeItem" value="9">
							<img src="/resources/images/space/icon/sports.svg" />
							<p>운동시설</p>
						</div>
						<div class="placeItem" value="10">
							<img src="/resources/images/space/icon/store.svg" />
							<p>가정집</p>
						</div>
						<div class="placeItem" value="11">
							<img src="/resources/images/space/icon/outside.svg" />
							<p>실외촬영</p>
						</div>
						<div class="placeItem" value="12">
							<img src="/resources/images/space/icon/camping.svg" style="width: 23px;" />
							<p>당일캠핑</p>
						</div>
						<div class="placeItem" value="13">
							<img src="/resources/images/space/icon/gallary.svg" />
							<p>갤러리</p>
						</div>
						<div class="placeItem" value="14">
							<img src="/resources/images/space/icon/office.svg" />
							<p>컨퍼런스</p>
						</div>
					</div>
				</div>
				<div class="filterDivider"></div>
				<div class="mainSearchPeople">
					<p>인원</p>
					<p class="peoplePoint">몇명이 이용하시나요?</p>
					<div class="mainSearchPeopleInput mainSearchSelect">
						<div class="peopleBox">
							<button class="peopleMinus">
								<img src="/resources/images/space/icon/btnMinus.svg" />
							</button>
							<div class="peopleInputBox">
								<p>인원</p>
								<input type="number" class="quantity" id="quantity" value="0">
								<p>명</p>
							</div>
							<button class="peoplePlus">
								<img src="/resources/images/space/icon/btnPlus.svg" />
							</button>
						</div>
							<button class="peopleSelect">인원적용</button>
					</div>
				</div>
				<div class="filterDivider"></div>
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
		    <div class="mainCateCard" onclick="mainCateFunction(0)">
		        <i class="fa-solid fa-list"></i>
		        <h2>전체보기</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(1)">
		        <i class="fa-solid fa-champagne-glasses"></i>
		        <h2>파티룸</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(2)">
		        <i class="fa-solid fa-music"></i>
		        <h2>연습실</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(3)">
		        <i class="fa-solid fa-book-open"></i>
		        <h2>스터디룸</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(4)">
		        <i class="fa-solid fa-utensils"></i>
		        <h2>공유주방</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(5)">
		        <i class="fa-solid fa-camera"></i>
		        <h2>스튜디오</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(6)">
		        <i class="fa-solid fa-coffee"></i>
		        <h2>카페</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(7)">
		        <i class="fa-solid fa-building"></i>
		        <h2>오피스</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(8)">
		        <i class="fa-solid fa-heart"></i>
		        <h2>스몰웨딩</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(9)">
		        <i class="fa-solid fa-dumbbell"></i>
		        <h2>운동시설</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(10)">
		        <i class="fa-solid fa-home"></i>
		        <h2>가정집</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(11)">
		        <i class="fa-solid fa-camera-retro"></i>
		        <h2>실외촬영</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(12)">
		        <i class="fa-solid fa-campground"></i>
		        <h2>당일캠핑</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(13)">
		        <i class="fa-solid fa-image"></i>
		        <h2>갤러리</h2>
		    </div>
		    <div class="mainCateCard" onclick="mainCateFunction(14)">
		        <i class="fa-solid fa-users"></i>
		        <h2>컨퍼런스</h2>
		    </div>
		</div>

		<div class="bestSlideContainer">
			<h1 class="bestSlideTitle">Best SPACE</h1>
			<div class="bestSlideBox">
				<div class="bestSlideList">

					<c:if test='${!empty bestSpaceList}'>
						<!--  var: for문 내부에서 사용할 변수, items: 리스트가 받아올 배열이름, varStatus:상태용 변수 -->
						<c:forEach var="bestSpace" items="${bestSpaceList}" varStatus="status">
							<div class="bestSlideItem" onclick="fn_spaceView(${bestSpace.spaceId})">
								<div class="bestSlideItemImgBox">
									<img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${bestSpace.spaceType}/${bestSpace.spaceId}/${bestSpace.spaceId}_1.jpg" onerror="this.onerror=null; this.src='/resources/images/space/icon/imagebear.jpg';" alt="Image">
									<button class="heartLikeyButton" id="heartLikeyButton-${bestSpace.spaceId}" onclick="likeyPress(${bestSpace.spaceId})">
										<img src="${bestSpace.spaceLiked ? '/resources/images/space/icon/heartallwhite.png' : '/resources/images/space/icon/heartwhite.png'}" alt="Heart Icon">
									</button>
								</div>
								<div class="bestSlideItemTextBox">
									<span class="bestSlideItemTextTitle">${bestSpace.spaceName}</span> <span class="bestSlideItemTextPlace">${bestSpace.spaceAddr}</span> <strong class="bestSlideItemTextPrice"> <span><span><fmt:formatNumber pattern="#,###">${bestSpace.spaceHourlyRate}</fmt:formatNumber>원</span><span class="time">/ 시간</span></span>
										<div class="bestItemCntBox">
											<span class="maxPeople"><img src="/resources/images/space/icon/eye.png" style="width: 20px; height: 20px; margin-top: 2px;">${bestSpace.spaceReadCnt}</span>
											<span class="reviewCnt"><img src="/resources/images/space/icon/star.png" style="width: 20px; height: 20px; margin-top: 2px;">${bestSpace.reviewScoreAvg}</span>
											<span class="likeyCnt"><img src="/resources/images/space/icon/heartgray.svg" style="width: 20px; height: 20px; margin-top: 2px;">${bestSpace.likeyCnt}</span>
										</div>
									</strong>
								</div>
							</div>
						</c:forEach>
					</c:if>

				</div>
			</div>
			<div class="bestSlideBtnBox">
				<div class="bestSlidePrevBtn"><img src="//s3.hourplace.co.kr/web/images/icon/chevron_left_b.svg" alt="Previous" class="flipsnap-icon" style="width: 16px; height: 16px;"></div>
				<div class="bestSlideNextBtn"><img src="//s3.hourplace.co.kr/web/images/icon/chevron_right_b.svg" alt="Next" class="flipsnap-icon" style="width: 16px; height: 16px;"></div>
			</div>
		</div>


		<h1 class="newSlideTitle">New!</h1>
		<div class="newItemContainer">
			
			<div class="newItemBox">
				<c:if test='${!empty newSpaceList}'>
					<!--  var: for문 내부에서 사용할 변수, items: 리스트가 받아올 배열이름, varStatus:상태용 변수 -->
					<c:forEach var="newSpace" items="${newSpaceList}" varStatus="status">
						<div class="newItem" onclick="fn_spaceView(${newSpace.spaceId})">
							<div class="bestSlideItemImgBox">
								<img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${newSpace.spaceType}/${newSpace.spaceId}/${newSpace.spaceId}_1.jpg" onerror="this.onerror=null; this.src='/resources/images/space/icon/imagebear.jpg';" alt="Image">
								<button class="heartLikeyButton" id="heartLikeyButton-${newSpace.spaceId}" onclick="likeyPress(${newSpace.spaceId})">
									<img src="${newSpace.spaceLiked ? '/resources/images/space/icon/heartallwhite.png' : '/resources/images/space/icon/heartwhite.png'}" alt="Heart Icon">
								</button>
							</div>
							<div class="bestSlideItemTextBox">
								<span class="bestSlideItemTextTitle">${newSpace.spaceName}</span> <span class="bestSlideItemTextPlace">${newSpace.spaceAddr}</span> <strong class="bestSlideItemTextPrice"> <span><span><fmt:formatNumber pattern="#,###">${newSpace.spaceHourlyRate}</fmt:formatNumber>원</span><span class="time">/ 시간</span></span>
									<div class="bestItemCntBox">
										<span class="maxPeople"><img src="/resources/images/space/icon/eye.png" style="width: 20px; height: 20px; margin-top: 2px;">${newSpace.spaceReadCnt}</span>
										<span class="reviewCnt"><img src="/resources/images/space/icon/star.png" style="width: 20px; height: 20px; margin-top: 2px;">${newSpace.reviewScoreAvg}</span>
										<span class="likeyCnt"><img src="/resources/images/space/icon/heartgray.svg" style="width: 20px; height: 20px; margin-top: 2px;">${newSpace.likeyCnt}</span>
									</div>
								</strong>
							</div>
						</div>
					</c:forEach>
				</c:if>

			</div>
			<button class="newItemListBtn" id="newItemListBtn">새로운 공간 더보기<img src="/resources/images/space/icon/moreList.svg" style="margin: 0 8px;"/></button>
		</div>

		<div class="bestSlideContainer">
			<h1 class="bestSlideTitle">Likey SPACE</h1>
			<div class="bestSlideBox">
				<div class="likeySlideList">

					<c:if test='${!empty likeySpaceList}'>
						<!--  var: for문 내부에서 사용할 변수, items: 리스트가 받아올 배열이름, varStatus:상태용 변수 -->

						<c:forEach var="likeySpace" items="${likeySpaceList}" varStatus="status">
							<div class="likeySlideItem" onclick="fn_spaceView(${likeySpace.spaceId})">
								<div class="bestSlideItemImgBox">
									<img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${likeySpace.spaceType}/${likeySpace.spaceId}/${likeySpace.spaceId}_1.jpg" onerror="this.onerror=null; this.src='/resources/images/space/icon/imagebear.jpg';" alt="Image">
									<button class="heartLikeyButton" id="heartLikeyButton-${likeySpace.spaceId}" onclick="likeyPress(${likeySpace.spaceId})">
										<img src="${likeySpace.spaceLiked ? '/resources/images/space/icon/heartallwhite.png' : '/resources/images/space/icon/heartwhite.png'}" alt="Heart Icon">
									</button>
								</div>
								<div class="bestSlideItemTextBox">
									<span class="bestSlideItemTextTitle">${likeySpace.spaceName}</span> <span class="bestSlideItemTextPlace">${likeySpace.spaceAddr}</span> <strong class="bestSlideItemTextPrice"><span><span><fmt:formatNumber pattern="#,###">${likeySpace.spaceHourlyRate}</fmt:formatNumber></span>원<span class="time">/ 시간</span></span>
										<div class="bestItemCntBox">
											<span class="maxPeople"><img src="/resources/images/space/icon/eye.png" style="width: 20px; height: 20px; margin-top: 2px;">${likeySpace.spaceReadCnt}</span>
											<span class="reviewCnt"><img src="/resources/images/space/icon/star.png" style="width: 20px; height: 20px; margin-top: 2px;">${likeySpace.reviewScoreAvg}</span>
											<span class="likeyCnt"><img src="/resources/images/space/icon/heartgray.svg" style="width: 20px; height: 20px; margin-top: 2px;">${likeySpace.likeyCnt}</span>
										</div>
									</strong>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="bestSlideBtnBox">
				<div class="likeySlidePrevBtn"><img src="//s3.hourplace.co.kr/web/images/icon/chevron_left_b.svg" alt="Previous" class="flipsnap-icon" style="width: 16px; height: 16px;"></div>
				<div class="likeySlideNextBtn"><img src="//s3.hourplace.co.kr/web/images/icon/chevron_right_b.svg" alt="Next" class="flipsnap-icon" style="width: 16px; height: 16px;"></div>
			</div>
		</div>

		<button class="toTopBtn">
			<img src="/resources/images/space/icon/topButton.svg" />
		</button>	
	</main>

	<form name="mainCateForm" id="mainCateForm" method="get">
		<input type="hidden" name="spaceTypeBar" value="">
	</form>

	<form name="mainSearchForm" id="mainSearchForm" method="get">
		<input type="hidden" name="spaceAddrBar" id="spaceAddrBar" value=""> <input type="hidden" name="spaceTypeBar" id="spaceTypeBar" value=""> <input type="hidden" name="spaceMaxCapacityBar" id="spaceMaxCapacityBar" value=""> <input type="hidden" name="reservationTimeBar" id="reservationTimeBar" value="">
	</form>

<script>
	AOS.init({once: true});
	
	$(".toTopBtn").on("click", function() {
        $('html, body').animate({ scrollTop: 0 }, 500);
    });

    const carouselContainer = document.querySelector('.carousel-container');
    
    const slides = carouselContainer.querySelectorAll('.carousel-container img'); // 클래스 없이 div로 선택
    
    const prevButton = document.querySelector('.prev-btn');
    const nextButton = document.querySelector('.next-btn');

    let currentIndex = 0;

    
    
    const totalImages = slides.length;
           
    nextButton.addEventListener('click', () => {
        currentIndex = (currentIndex + 1) % totalImages;
        updateCarousel();
    });

    prevButton.addEventListener('click', () => {
        currentIndex = (currentIndex - 1 + totalImages) % totalImages;
        updateCarousel();
    });
    
          
    // 자동 슬라이드
    setInterval(() => {
        currentIndex = (currentIndex + 1) % totalImages;
        updateCarousel();
    }, 4000);  // 3000ms = 3초

    function updateCarousel() {
        const offset = -currentIndex * 100;
        carouselContainer.style.transition = 'transform 1s ease-in-out'; // 부드러운 애니메이션
        carouselContainer.style.transform = "translateX(" + offset + "vw)";

        // 마지막 슬라이드에서 첫 번째 슬라이드로 돌아갈 때 부드럽게 처리
        if (currentIndex === totalImages) {
            setTimeout(() => {
                carouselContainer.style.transition = 'none'; // 애니메이션을 잠시 꺼서 즉시 첫 번째 슬라이드로 이동
                currentIndex = 0;
                updateCarousel();
                
                setTimeout(() => {
                    carouselContainer.style.transition = 'transform 1s ease-in-out'; // 애니메이션 활성화
                }, 50); // 약간의 딜레이 후 애니메이션 다시 활성화
            }, 1000); // 슬라이드가 끝난 후 1초 대기 후 이동
        }
    }
    
    bSList = $(".bestSlideList");
    
    let testLate = 0;
    let totlaItems = $(".bestSlideItem").length;
    let curSlideCnt = 0;

    $(".bestSlidePrevBtn").on("click", function() {
        if (curSlideCnt > 0) {
            curSlideCnt = (curSlideCnt - 1 + totlaItems) % totlaItems;
            moveCarousel();
        }
    });

    $(".bestSlideNextBtn").on("click", function() {
        if (curSlideCnt < totlaItems - 3) {
            console.log(curSlideCnt);
            curSlideCnt = (curSlideCnt + 1) % totlaItems;
            moveCarousel();
        }
    });

    
    lSList = $(".likeySlideList");
    
    let likeyTotlaItems = $(".likeySlideItem").length;
    let likeyCurSlideCnt = 0;

    $(".likeySlidePrevBtn").on("click", function() {
        if (likeyCurSlideCnt > 0) {
            likeyCurSlideCnt = (likeyCurSlideCnt - 1 + likeyTotlaItems) % likeyTotlaItems;
            likeyMoveCarousel();
        }
    });

    $(".likeySlideNextBtn").on("click", function() {
        if (likeyCurSlideCnt < likeyTotlaItems - 3) {  // 적어도 3개 이상의 슬라이드를 남기고 이동
            likeyCurSlideCnt = (likeyCurSlideCnt + 1) % likeyTotlaItems;
            likeyMoveCarousel();
        }
    });

  
    function moveCarousel() {
        const offset = -curSlideCnt * (400);
        bSList.css("transform", "translateX("+offset+"px)");
    }

    function likeyMoveCarousel() {
        const offset = -likeyCurSlideCnt * (400);
        lSList.css("transform", "translateX("+offset+"px)");
        console.log("move");
    }    
</script>

<script>	
document.addEventListener('DOMContentLoaded', function () {
	
	const mainSearchBox = document.querySelector('.mainSearchBox');

    // 모든 모달 닫기
    function closeAllModals() {
        $(".mainSearchSelect").css("display", "none"); // 모든 모달 숨기기
        $(".modalShadowBox").css("display", "none"); // 모달 배경 숨김
        $("body").removeClass("modalMouse"); // 스크롤 활성화
        mainSearchBox.classList.remove('modal-active'); // z-index 비활성화
    }

    // 특정 모달 열기
    function openModal(modalSelector) {
        closeAllModals(); // 열려 있는 모달 닫기
        $(modalSelector).css("display", "grid"); // 선택한 모달만 표시
        $(".modalShadowBox").css("display", "block"); // 모달 배경 표시
        $("body").addClass("modalMouse"); // 스크롤 비활성화
        mainSearchBox.classList.add('modal-active'); // z-index 활성화
    }
    
    function modalNone() {
           setTimeout(function() {
               $(".mainSearchSelect").css("display", "none");
               $(".modalShadowBox").css("display", "none");
               $("body").removeClass("modalMouse");
               mainSearchBox.classList.remove('modal-active'); // z-index 비활성화
           }, 0);
       }

    $(".mainSearchLocal").on("click", function () {
        openModal(".mainSearchLocalInput"); // 지역 모달 열기
        $(".mainSearchBox")[0].scrollIntoView({ block: "center" });
        window.scrollBy({ top: 240 });
    });

    $(".mainSearchPlace").on("click", function () {
        openModal(".mainSearchPlaceInput"); // 공간 유형 모달 열기
        $(".mainSearchBox")[0].scrollIntoView({ block: "center" });
        window.scrollBy({ top: 240 });
    });

    $(".mainSearchPeople").on("click", function () {
        openModal(".mainSearchPeopleInput"); // 인원 선택 모달 열기
        $(".mainSearchBox")[0].scrollIntoView({ block: "center" });
        window.scrollBy({ top: 240 });
    });

    $(".localItem").on("click", function(e) {
           $(".localPoint").css("display", "none");
           $(".mainSearchInput").html("");
           $(".mainSearchLocal").append('<p class="mainSearchInput"  style="color: black; font-size: 20px; font-weight: bold;">'+e.target.textContent+'</p>');
           modalNone();
           
           $('#spaceAddrBar').val($(this).attr('value')); // 서치바 벨류 설정
       });


    $(".placeItem").on("click", function(e) {
           $(".placePoint").css("display", "none");
           $(".mainSearchItemPlaceInput").html("");
           $(".mainSearchPlace").append('<p class="mainSearchItemPlaceInput" style="color: black; font-size: 20px; font-weight: bold;">'+e.target.textContent+'</p>');
           modalNone();
           
           $('#spaceTypeBar').val($(this).attr('value')); // 서치바 벨류 설정
       });


    const minusButton = $(".peopleMinus");
    const plusButton = $(".peoplePlus");
    const peopleInpField = $(".quantity");

    minusButton.on("click", function () {
        let value = parseInt(peopleInpField.val(), 10);
        if (!isNaN(value) && value > 0) {
            peopleInpField.val(value - 1);
        }
    });

    plusButton.on("click", function () {
        let value = parseInt(peopleInpField.val(), 10);
        if (!isNaN(value)) {
            peopleInpField.val(value + 1);
        }
    });

    $(".peopleSelect").on("click", function() {
           $(".peoplePoint").css("display", "none");
           $(".mainSearchItemPeopleInput").html("");
           $(".mainSearchPeople").append("<p class='mainSearchItemPeopleInput' style='color: black; font-size: 20px; font-weight: bold;'>" + peopleInpField.val() + " 명</p>");
           modalNone();
           
           $('#spaceMaxCapacityBar').val($(".quantity").val()); // 서치바 벨류 설정
       });

    $(".modalShadowBox").on("click", function () {
        closeAllModals(); // 배경 클릭 시 모든 모달 닫기
    });

    $(".mainSearchResetBtn").on("click", function () {
        $(".localPoint").css("display", "block");
        $(".placePoint").css("display", "block");
        $(".peoplePoint").css("display", "block");
        $(".datePoint").css("display", "block");

        $(".mainSearchItemPlaceInput").remove();
        $(".mainSearchInput").remove();
        $(".mainSearchItemPeopleInput").remove();
        $(".mainSearchItemDateInput").remove();
    });

    // 달력 관련 코드
    const calendarEl = document.getElementById('calendar');

    let today = new Date().toISOString().split('T')[0];

    const calendar = new FullCalendar.Calendar(calendarEl, {
        locale: 'ko',
        selectable: true,
        validRange: {
            start: today
        },
        headerToolbar: {
            left: 'prev,next', // "월간 뷰" 버튼 제외
            center: 'title',
            right: 'today' // 원하는 뷰 버튼만 표시
        },
        dayCellContent: function(arg) {
               // 날짜 숫자를 가져와 '일'을 제거
               const dateText = arg.date.getDate().toString(); // 숫자만 가져오기
               arg.dayNumberText = dateText; // 날짜에 숫자만 표시
               return { html: dateText }; // 숫자를 HTML로 반환
           },
           dayCellClassNames: function(arg) {
               const date = arg.date.toISOString().split('T')[0];

               // 일요일
               if (arg.date.getDay() === 0) {
                   return 'fc-sunday';
               }

               // 토요일
               if (arg.date.getDay() === 6) {
                   return 'fc-saturday';
               }

               return [];
           },
        dayCellDidMount: function (info) {
            const cellDate = info.date.toISOString().split('T')[0];
            if (cellDate < today) {
                info.el.style.backgroundColor = '#fff';
                info.el.style.color = '#d3d3d3';
                info.el.style.pointerEvents = 'none';
            }
        },
        dateClick: function (info) {
               // alert('클릭한 날짜: ' + info.dateStr);  // 날짜 클릭 시 알림
               $(".datePoint").css("display", "none");
               $(".mainSearchItemDateInput").html("");
               $(".mainSearchDate").append("<p class='mainSearchItemDateInput' style='color: black; font-size: 20px; font-weight: bold;'>" + info.dateStr + "</p>");
               $(".mainSearchDateInput").css("display", "none");
               modalNone();
               
               $("#reservationTimeBar").val(info.dateStr); //서치바 벨류 설정
           }
    });

    calendar.render();

    $(".mainSearchDate").on("click", function() {
    	closeAllModals();
    	
           setTimeout(function() {
               calendar.render();  // 달력 렌더링
           }, 0);
           $(".mainSearchDateInput").css("display", "block");
           $(".modalShadowBox").css("display", "block");
           $("body").addClass("modalMouse");
          
      
			$(".mainSearchBox")[0].scrollIntoView({block: "center"});
           
			mainSearchBox.classList.add('modal-active'); // z-index 활성화
           window.scrollBy({ top: 240});
       });
});
        
function fn_spaceView(spaceId) {
	window.open("/space/spaceView?spaceId="+spaceId, '_blank');
}
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
