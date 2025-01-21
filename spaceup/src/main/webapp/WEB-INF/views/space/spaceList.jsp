<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

<script>
$(document).ready(function() {	
	// spaceType와 spaceTypeBar 요소 가져오기
    const $spaceTypeElement = $('#spaceType');
    const $spaceTypeBarElement = $('#spaceTypeBar');

    // spaceType 값 읽어서 숫자로 변환
    const spaceTypeValue = parseInt($spaceTypeElement.val(), 10);

    // 값이 1 이상인지 확인 후, spaceTypeBar 값 설정
    if (spaceTypeValue >= 1) {
        $spaceTypeBarElement.val(spaceTypeValue);
    }
		       
    $("#mainSearchSearchBtn").on("click", function() {
    	let spaceName = $("input[name=spaceName]").val();
    	
        if(spaceName != null && spaceName != "") {
        	document.mainSearchForm.spaceName.value = spaceName;
        }
    	
    	document.mainSearchForm.action = "/space/spaceList";
    	document.mainSearchForm.submit();
    });
    
    $("#mainSearchResetBtn").on("click", function() {
    	$(".localPoint").html("<p class='localPoint' id='localPoint' style='font-size: 16px; color: rgb(163, 163, 163);'>어느 지역을 찾으세요?</p>");
        $(".placePoint").html("<p class='placePoint' id='placePoint' style='font-size: 16px; color: rgb(163, 163, 163);'>어떤 유형의 공간을 찾으시나요?</p>");
        $(".peoplePoint").html("<p class='peoplePoint' id='peoplePoint' style='font-size: 16px; color: rgb(163, 163, 163);'>몇명이 이용하시나요?</p>");
        $(".datePoint").html("<p class='datePoint' id='localPointReset' style='font-size: 16px; color: rgb(163, 163, 163);'>대여 날짜는 언제인가요?</p>");
                               
        $(".mainSearchItemPlaceInput").remove();
        $(".mainSearchInput").remove();
        $(".mainSearchItemPeopleInput").remove();
        $(".mainSearchItemDateInput").remove();

        document.mainSearchForm.spaceAddrBar.value = "";
        document.mainSearchForm.spaceType.value = "";
        document.mainSearchForm.spaceTypeBar.value = "";
        document.mainSearchForm.spaceMaxCapacityBar.value = "";
        document.mainSearchForm.reservationTimeBar.value = "";
        document.mainSearchForm.spaceName.value = "";
    });
    
    
    
    if (performance.navigation.type == 1) { // 1은 새로고침
                        
        $(".localPoint").html("<p class='localPoint' id='localPoint' style='font-size: 16px; color: rgb(163, 163, 163);'>어느 지역을 찾으세요?</p>");
        $(".placePoint").html("<p class='placePoint' id='placePoint' style='font-size: 16px; color: rgb(163, 163, 163);'>어떤 유형의 공간을 찾으시나요?</p>");
        $(".peoplePoint").html("<p class='peoplePoint' id='peoplePoint' style='font-size: 16px; color: rgb(163, 163, 163);'>몇명이 이용하시나요?</p>");
        $(".datePoint").html("<p class='datePoint' id='localPointReset' style='font-size: 16px; color: rgb(163, 163, 163);'>대여 날짜는 언제인가요?</p>");
                               
        $(".mainSearchItemPlaceInput").remove();
        $(".mainSearchInput").remove();
        $(".mainSearchItemPeopleInput").remove();
        $(".mainSearchItemDateInput").remove();

        document.mainSearchForm.spaceAddrBar.value = "";
        document.mainSearchForm.spaceType.value = "";
        document.mainSearchForm.spaceTypeBar.value = "";
        document.mainSearchForm.spaceMaxCapacityBar.value = "";
        document.mainSearchForm.reservationTimeBar.value = "";    
        
        document.moreForm.offset.value = "";
        
        location.href = "/space/spaceList";
    }       
    
});

// 좋아요 클릭시
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

    		if(response.code == 0)
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
    		else if(response.code == 1)
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
    			console.log("좋아요 취소 오류");	    
    		}
    		else if(response.code == 404)
    		{
    			//alert("해당 공간을 찾을 수 없습니다.");
    			console.log("좋아요 취소 오류2");
    			
    		}
    		else if(response.code == 500)
    		{
    			//alert("좋아요 성공 오류 입니다.");
    			console.log("좋아요 취소 오류3");
    			
    		}
    		else
    		{
    			//alert("좋아요 중 오류가 발생하였습니다.");
    			console.log("좋아요 취소 오류4");
    			   
    		}
    		
    	},
    	error:function(error)
    	{
    		icia.common.error(error);
    		//alert("공간 좋아요 중 오류가 발생하였습니다.");
    		
    	}
    });
}

</script>

</head>


<body class="spaceList">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

    <div class="modalShadowBox"></div>

    <main class="spaceListMain">
        <div class="mainSearchBox">
            <div class="mainSearchBtnBox">
                <button class="mainSearchSearchBtn" id="mainSearchSearchBtn">검색</button>
                <button class="mainSearchResetBtn" id="mainSearchResetBtn">초기화</button>
            </div>
            <div class="mainSearch">
                <div class="mainSearchLocal">
                    <p>지역</p>
                     <c:choose>
			      	<c:when test="${!empty spaceAddrBar}">			         	
			         	<p class="localPoint" style="color: black; font-size: 20px; font-weight: bold;">${spaceAddrBar}</p>
			        </c:when>			   
			        <c:otherwise>
			         	<p class="localPoint" id="localPoint">어느 지역을 찾으세요?</p>
			        </c:otherwise>     
			      </c:choose>       
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
<c:choose>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 1}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">파티룸</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 2}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">연습실</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 3}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">스터디룸</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 4}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">공유주방</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 5}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">스튜디오</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 6}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">카페</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 7}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">오피스</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 8}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">스몰웨딩</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 9}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">운동시설</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 10}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">가정집</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 11}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">실외촬영</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 12}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">당일캠핑</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 13}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">갤러리</p>
    </c:when>
    <c:when test="${!empty spaceTypeBar && spaceTypeBar == 14}">
        <p class="placePoint" style="color: black; font-size: 20px; font-weight: bold;">컨퍼런스</p>
    </c:when>
    <c:otherwise>
        <p class="placePoint">어떤 유형의 공간을 찾으시나요?</p>
    </c:otherwise>     
</c:choose>       
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
                  <c:choose>
			      	<c:when test="${!empty spaceMaxCapacityBar && spaceMaxCapacityBar > 0}">			         	
			         	<p class="peoplePoint" style="color: black; font-size: 20px; font-weight: bold;">${spaceMaxCapacityBar}명</p>
			        </c:when>			   
			        <c:otherwise>
			         	<p class="peoplePoint">몇명이 이용하시나요?</p>
			        </c:otherwise>     
			      </c:choose>                                                                                   
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
        <c:choose>
      		<c:when test="${!empty reservationTimeBar}">
        		<p class="datePoint" style="color: black; font-size: 20px; font-weight: bold;">${reservationTimeBar}</p>
       		</c:when>
       		 <c:otherwise>
        		<p class="datePoint">대여 날짜는 언제인가요?</p>               
        	</c:otherwise>
        </c:choose>                         
                    <div class="mainSearchDateInput mainSearchSelect">
                        <div id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="spaceListSelectBox">
            <div class="spaceListTotalCntBox">
                <span class="spaceListTotalCnt">${spaceListTotalCount}</span> 개
            </div>
            <select name="spaceListSelect" onchange="spaceListSorting()" class="spaceListSelect" id="spaceListSelect">
            	<option value="1">최신순</option>
                <option value="2">인기순</option>
                <option value="3">낮은 가격순</option>
                <option value="4">높은 가격순</option>
                <option value="5">조회순</option>
                <option value="6">후기순</option>
                <option value="7">평점 높은순</option>
            </select>
        </div>

        <!-- <h1 class="mainContentTitle">Our Space!</h1> -->

		<div class="bestSlideListBox" id="bestSlideListBox">
			<div class="bestSlideList" id="bestSlideList">
					<c:if test='${!empty spaceList}'>
						<c:forEach var="space" items="${spaceList}" varStatus="status">
							<div class="bestSlideItem" id="bestSlideItem" onclick="fn_spaceView(${space.spaceId})">
								<div class="bestSlideItemImgBox" id="bestSlideItemImgBox">
									<img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${space.spaceType}/${space.spaceId}/${space.spaceId}_1.jpg" onerror="this.onerror=null; this.src='/resources/images/space/icon/imagebear.jpg';" alt="Image">
									<button class="heartLikeyButton"
										id="heartLikeyButton-${space.spaceId}"
										onclick="likeyPress(${space.spaceId})">
										<img src="${space.spaceLiked ? '/resources/images/space/icon/heartallwhite.png' : '/resources/images/space/icon/heartwhite.png'}"
											alt="Heart Icon">
									</button>
								</div>
								
								<div class="bestSlideItemTextBox" id="bestSlideItemTextBox">
									<span class="bestSlideItemTextTitle">${space.spaceName}</span>
									<span class="bestSlideItemTextPlace">${space.spaceAddr}</span>
									<strong class="bestSlideItemTextPrice">
										<span>
											<span><fmt:formatNumber pattern="#,###">${space.spaceHourlyRate}</fmt:formatNumber></span>원<span class="time">/ 시간</span>
										</span>
										<div class="bestItemCntBox">
											<span class="maxPeople">
												<img src="/resources/images/space/icon/eye.png"
													style="width: 20px; height: 20px; margin-top: 2px;">${space.spaceReadCnt}</span>
											<span class="reviewCnt">
												<img src="/resources/images/space/icon/star.png"
													style="width: 20px; height: 20px; margin-top: 2px;">${space.reviewScoreAvg}</span>
											<span class="likeyCnt">
												<img src="/resources/images/space/icon/heartgray.svg"
													style="width: 20px; height: 20px; margin-top: 2px;">${space.likeyCnt}</span>
										</div>
									</strong>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>			
			</div>
		
		<c:if test="${spaceListTotalCount ge offset + 6}">	
		<div class="loading" style="text-align: center; padding: 10px; width: 200px;">loading</div>		
        </c:if>
        <button class="toTopBtn">
        	<img src="/resources/images/space/icon/topButton.svg" />
        </button>
        
        <c:if test='${empty spaceList}'>
          <script>
             document.getElementById("spaceListSelect").remove();                     
          </script>
          <div style="width: 1200px; height: 600px; overflow: hidden; display: flex; justify-content: center; align-items: center;">
               <img src="/resources/images/space/icon/noimg2.png" alt="Image" style="width: 50%; height: 50%; object-fit: cover;">
          </div>
       </c:if>
        
    </main>
    
	<!-- 폼 -->   
     <form name="mainSearchForm" id="mainSearchForm" method="get">
	   	<input type="hidden" name="spaceAddrBar" id="spaceAddrBar" value="${spaceAddrBar} ">
	   	<input type="hidden" name="spaceType" id="spaceType" value="${spaceType}">
	   	<input type="hidden" name="spaceTypeBar" id="spaceTypeBar" value="${spaceTypeBar}">
	    <input type="hidden" name="spaceMaxCapacityBar" id="spaceMaxCapacityBar" value="${spaceMaxCapacityBar}">
	    <input type="hidden" name="reservationTimeBar" id="reservationTimeBar" value="${reservationTimeBar}">
	    <input type="hidden" name="spaceName" id="spaceName" value="${spaceName}">
    
    	<input type="hidden" name="spaceSort" id="spaceSort" value="">
   </form>
        
   <form name="moreForm" id="moreForm" method="get">
 	  	<input type="hidden" name="offset" id="offset" value="0">           
   </form>

    <script>
        $("header").load("/header.html");

        $(".toTopBtn").on("click", function() {
            $('html, body').animate({ scrollTop: 0 }, 500);
        });
	
        function spaceListSorting() {        	
        	var sortValue = document.getElementById("spaceListSelect").value;
        	
        	$(".loading").show();
        	
        	document.moreForm.offset.value = "0"
        	        	               	     
            // 빈값이면 빈 문자열 처리
            let spaceTypeBar = $('#spaceTypeBar').val() || '';
            let spaceAddrBar = $('#spaceAddrBar').val() || '';
            let spaceMaxCapacityBar = $('#spaceMaxCapacityBar').val() || '';
            let reservationTimeBar = $('#reservationTimeBar').val() || '';
            let spaceName = $('#spaceName').val() || '';
                                   
            // Ajax 요청
            $.ajax({
                url: '/space/spaceSorting',  // 여기에 맞는 URL로 수정
                method: 'GET',
                data: {                   
                    // 검색 조건 추가
                    spaceTypeBar: spaceTypeBar,
                    spaceAddrBar: spaceAddrBar,
                    spaceMaxCapacityBar: spaceMaxCapacityBar,
                    spaceName: spaceName,
                    reservationTimeBar: reservationTimeBar,
                    spaceSort: sortValue
                },
                datatype:"JSON",
                beforeSend:function(xhr)
    			{
    				xhr.setRequestHeader("AJAX", "true");
    			},
                success:function(response) {
                    // 서버에서 받은 데이터 확인
                    
                    const spaceListMore = response.data;                            
    												 								 		               					
                        if (response.code == 0) {
                        	document.querySelector('.bestSlideList').innerHTML = '';
                        	
                        	console.log("spaceListMore:", spaceListMore);
                        	spaceListMore.forEach((space, index) => {
                        	    console.log(`Index ${index}:`, space);
                        	    console.log("space.spaceId:", space.spaceId);
                        	    console.log("space.spaceName:", space.spaceName);
                        	    console.log("space.spaceScoreAvg:", space.reviewScoreAvg);
                        	});
                        	                    	                      
                            spaceListMore.forEach(function(space) {
                            	let reviewScoreAvg = space.reviewScoreAvg || 0.0;  // 기본값 0.0
                            	let reviewDisplay = (reviewScoreAvg === 0) ? '0.0' : reviewScoreAvg;

                            	// 숫자 포맷 적용 (toLocaleString)
                                let formattedHourlyRate = space.spaceHourlyRate.toLocaleString(); 
                                let formattedReadCnt = space.spaceReadCnt.toLocaleString();
                                let formattedLikeyCnt = space.likeyCnt.toLocaleString();
    							                        	
                                let spaceItem = `	
                                	<div class="bestSlideItem" onclick="fn_spaceView(\${space.spaceId})">		
    	                            	<div class="bestSlideItemImgBox" id="bestSlideItemImgBox">
											<img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/\${space.spaceType}/\${space.spaceId}/\${space.spaceId}_1.jpg" onerror="this.onerror=null; this.src='/resources/images/space/icon/imagebear.jpg';" alt="Image">
    											<button class="heartLikeyButton"
    												id="heartLikeyButton-\${space.spaceId}"
    												onclick="likeyPress(\${space.spaceId})">
    												<img src="\${space.spaceLiked ? '/resources/images/space/icon/heartallwhite.png' : '/resources/images/space/icon/heartwhite.png'}"
    													alt="Heart Icon">
    											</button>
    										</div>
    										
    										<div class="bestSlideItemTextBox">
    											<span class="bestSlideItemTextTitle">\${space.spaceName}</span>
    											<span class="bestSlideItemTextPlace">\${space.spaceAddr}</span>
    											<strong class="bestSlideItemTextPrice">
    												<span>
    													<span>\${formattedHourlyRate}</span>원<span class="time"></span><span class="time">/ 시간</span>
    												</span>
    												<div class="bestItemCntBox">
    													<span class="maxPeople">
    														<img src="/resources/images/space/icon/eye.png"
    															style="width: 20px; height: 20px; margin-top: 2px;">\${formattedReadCnt}</span>
    													<span class="reviewCnt">
    														<img src="/resources/images/space/icon/star.png"
    															style="width: 20px; height: 20px; margin-top: 2px;">\${reviewDisplay}</span>
    													<span class="likeyCnt">
    														<img src="/resources/images/space/icon/heartgray.svg"
    															style="width: 20px; height: 20px; margin-top: 2px;">\${formattedLikeyCnt}</span>
    												</div>
    											</strong>
    										</div>
    									</div>
                                	</div>    
                                `;
                                // 공간 아이템 추가
                                $('#bestSlideList').append(spaceItem);
                            });
                        
                        // offset을 5만큼 증가시켜서 다음 페이지 요청 시 7번부터 12번 데이터를 가져오도록 함
                        offset += limit;
                        document.moreForm.offset.value = offset;
                    } else {
                        //alert("데이터 불러오기 오류.");  // 더 이상 데이터가 없을 경우 
                        console.log("데이터 불러오기 오류.");
                    }
                }
    			,
                error: function(err) {
                    //alert('서버 요청 오류: ' + JSON.stringify(err));  // 오류 발생 시 얼럿
                    console.log("서버 요청 오류: " + JSON.stringify(err));
                }
            });
        
        };                   
    </script>
    
    <script>
    let listStatus = true;
    let listStatusAjax = 0;
    
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
	        window.scrollBy({ top: 20 });
	    });

	    $(".mainSearchPlace").on("click", function () {
	        openModal(".mainSearchPlaceInput"); // 공간 유형 모달 열기
	        $(".mainSearchBox")[0].scrollIntoView({ block: "center" });
	        window.scrollBy({ top: 20 });
	    });

	    $(".mainSearchPeople").on("click", function () {
	        openModal(".mainSearchPeopleInput"); // 인원 선택 모달 열기
	        $(".mainSearchBox")[0].scrollIntoView({ block: "center" });
	        window.scrollBy({ top: 20 });
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
	        $("input[name=spaceName]").val("");
	        
	        location.href = "/space/spaceList";
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
            window.scrollBy({ top: 20});
        });
	});
	
	  function fn_spaceView(spaceId) {
      	window.open("/space/spaceView?spaceId="+spaceId, '_blank');
      }

	 /* 공간 리스트 페이징 처리 - 더 불러오기 */
    function fn_moreData() {
	var sortValue = document.getElementById("spaceListSelect").value;        	
	
	//alert("정렬 벨류 값 = " +  sortValue);
                   
		// 페이지를 이동할 때마다 offset 값을 6씩 증가
    let offset = parseInt($('#offset').val());   // 현재 offset 값 (기본 0에서 시작)
    let limit = parseInt('${limit}');    // limit 값 (한 번에 가져올 데이터 개수)

    // offset 계산을 잘못하지 않도록 조정
    let nextOffset = offset + limit;  // 다음 페이지의 offset을 계산
    
    // 빈값이면 빈 문자열 처리
    let spaceTypeBar = $('#spaceTypeBar').val() || '';
    let spaceAddrBar = $('#spaceAddrBar').val() || '';
    let spaceMaxCapacityBar = $('#spaceMaxCapacityBar').val() || '';
    let reservationTimeBar = $('#reservationTimeBar').val() || '';
    let spaceName = $('#spaceName').val() || '';
    
   
    
    // Ajax 요청
    $.ajax({
        url: '/space/loadMoreSpace',  // 여기에 맞는 URL로 수정
        method: 'GET',
        data: {
            offset: nextOffset,
            limit: limit,
            // 검색 조건 추가
            spaceTypeBar: spaceTypeBar,
            spaceAddrBar: spaceAddrBar,
            spaceMaxCapacityBar: spaceMaxCapacityBar,
            spaceName: spaceName,
            reservationTimeBar: reservationTimeBar,
            spaceSort: sortValue
        },
        datatype:"JSON",
        beforeSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", "true");
		},
        success:function(response) {
        	
            // 서버에서 받은 데이터 확인
            
            const spaceListMore = response.data;                            
											 								 		               					
                if (response.code == 0) {
                	document.querySelector('.bestSlideList').innerHTML = '';
                	
                	console.log("spaceListMore:", spaceListMore);
                	spaceListMore.forEach((space, index) => {
                	    console.log(`Index ${index}:`, space);
                	    console.log("space.spaceId:", space.spaceId);
                	    console.log("space.spaceName:", space.spaceName);
                	    console.log("space.spaceScoreAvg:", space.reviewScoreAvg);
                	});
                	                    	                      
                    spaceListMore.forEach(function(space) {
                    	// 숫자 포맷 적용 (toLocaleString)
                        let formattedHourlyRate = space.spaceHourlyRate.toLocaleString(); 
                        let formattedReadCnt = space.spaceReadCnt.toLocaleString();
                        let formattedLikeyCnt = space.likeyCnt.toLocaleString();
                    	
                    	let reviewScoreAvg = space.reviewScoreAvg || 0.0;  // 기본값 0.0
                    	let reviewDisplay = (reviewScoreAvg === 0) ? '0.0' : reviewScoreAvg;
						                        	
                        let spaceItem = `	
                        	<div class="bestSlideItem" onclick="fn_spaceView(\${space.spaceId})">		
                            	<div class="bestSlideItemImgBox" id="bestSlideItemImgBox">
									<img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/\${space.spaceType}/\${space.spaceId}/\${space.spaceId}_1.jpg" onerror="this.onerror=null; this.src='/resources/images/space/icon/imagebear.jpg';" alt="Image">
										<button class="heartLikeyButton"
											id="heartLikeyButton-\${space.spaceId}"
											onclick="likeyPress(\${space.spaceId})">
											<img src="\${space.spaceLiked ? '/resources/images/space/icon/heartallwhite.png' : '/resources/images/space/icon/heartwhite.png'}"
												alt="Heart Icon">
										</button>
									</div>
									
									<div class="bestSlideItemTextBox">
										<span class="bestSlideItemTextTitle">\${space.spaceName}</span>
										<span class="bestSlideItemTextPlace">\${space.spaceAddr}</span>
										<strong class="bestSlideItemTextPrice">
											<span>
												<span>\${formattedHourlyRate}</span>원<span class="time">/ 시간</span>
											</span>
											<div class="bestItemCntBox">
												<span class="maxPeople">
													<img src="/resources/images/space/icon/eye.png"
														style="width: 20px; height: 20px; margin-top: 2px;">\${formattedReadCnt}</span>
												<span class="reviewCnt">
													<img src="/resources/images/space/icon/star.png"
														style="width: 20px; height: 20px; margin-top: 2px;">\${reviewDisplay}</span>
												<span class="likeyCnt">
													<img src="/resources/images/space/icon/heartgray.svg"
														style="width: 20px; height: 20px; margin-top: 2px;">\${formattedLikeyCnt}</span>
											</div>
										</strong>
									</div>
								</div>									
                        	</div>                            	
                        `;                            
                        // 공간 아이템 추가
                        $('#bestSlideList').append(spaceItem);                            
                    });                                                                                                                                                                   
                // offset을 5만큼 증가시켜서 다음 페이지 요청 시 7번부터 12번 데이터를 가져오도록 함
                offset += limit;
                document.moreForm.offset.value = offset;
                
                if(${spaceListTotalCount} <= offset + 6) {                	
                	$(".loading").hide();                  
                }
            } else {                	
            	//alert("데이터 불러오기 오류.");  // 더 이상 데이터가 없을 경우
            	console.log("데이터 불로오기 오류");
            }
        }
		,
        error: function(err) {
            //alert('서버 요청 오류: ' + JSON.stringify(err));  // 오류 발생 시 얼럿
            console.log("서버 요청 오류:"+ JSON.stringify(err));
        }
    });
    
    observer.observe(loading[0]);
}
                                 
        const loading = $(".loading");
        
        if(listStatus) {
            // Intersection Observer 생성
           const observer = new IntersectionObserver(
             (entries, observer) => {
               entries.forEach(entry => {
                 if (entry.isIntersecting) {
                	 fn_moreData(); // 데이터 로드
                   console.log(loading);
                   console.log(loading[0]);
                 }
               });
             },
             {
               root: null, // 브라우저의 viewport가 root가 됨
               rootMargin: "0px",
               threshold: 0.5 // 요소의 100%가 보일 때 트리거
             }
           );
            
            
  
           // loading 요소를 관찰 대상으로 설정
           observer.observe(loading[0]);
           
        }
        
        $("input[name=spaceName]").val("${spaceName}");
        
    </script>
    
       
       
    	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
    
</body>
</html>