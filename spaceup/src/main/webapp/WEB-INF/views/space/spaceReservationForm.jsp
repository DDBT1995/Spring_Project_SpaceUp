<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 페이지</title>
    <link rel="stylesheet" href="/resources/css/space/spaceReservationForm.css">
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0f979efa24339b22af634ee6af0fd743&libraries=services"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

    <div class="profile-container">    
        <div class="reserv-container">
            <h1>예약 내용 확인 및 결제</h1>

            <h2 style="margin-bottom: 1px;">예약 정보</h2>
            <div class="detailPage">
                <div class="info-box_2">
                    <div class="info-box_3">                    
                        <img src="http://spaceuphostcenter.sist.co.kr:8088//resources/images/space/upload/${space.spaceType}/${space.spaceId}/${spaceImgNames[0]}" alt="예약된 장소" style="width: 100px; height: 72px;">
                        <div class="details_3">
                            <p><strong class="strong" style="font-size: 14px;">공간 번호</strong> ${space.spaceId}</p>
                            <p>${space.spaceName}</p>
                        </div>                
                    </div>
                    <div class="details_2">
                    	<fmt:parseDate value="${useDate}" pattern="yyyy-MM-dd" var="parsedDate" />
                    	<fmt:formatDate value="${parsedDate}" pattern="EEEE" var="dayOfWeek" />
                    	<c:set var="hourString" value="${reservationTimeItem[0]}" />
					    <%
					        String hourString = (String) pageContext.getAttribute("hourString");
					        int hour = Integer.parseInt(hourString);
					        String period = (hour < 12) ? "오전" : "오후";
					        int convertedHour = (hour > 12) ? hour - 12 : hour;
					        String formattedTime = String.format("%s %d:00", period, convertedHour);
					    %>

					    <c:set var="lastIndex" value="${fn:length(reservationTimeItem) - 1}" />
						<c:set var="hourString" value="${reservationTimeItem[lastIndex]}" />
						<%
						    String hourStringEnd = (String) pageContext.getAttribute("hourString");
						    int hourEnd = Integer.parseInt(hourStringEnd);
						    hourEnd = hourEnd + 1;
						    String periodEnd = (hourEnd < 12) ? "오전" : "오후";
						    int convertedHourEnd = (hourEnd > 12) ? hourEnd - 12 : hourEnd;
						    String formattedTimeEnd = String.format("%s %d:00", periodEnd, convertedHourEnd);
						%>
						
                        <p><strong class="strong" style="margin-bottom: 15px;">일정</strong> <fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일" /> (${dayOfWeek}) <%= formattedTime %> ~ <%= formattedTimeEnd %></p>
                        <p><strong class="strong">예약 시간</strong> ${fn:length(reservationTimeItem)}시간</p>    
                        <hr>

                        <p><strong class="strong">총 1시간</strong> <fmt:formatNumber value="${space.spaceHourlyRate}" pattern="#,###" />원</p>
                        <p><strong class="strong"  style="font-size: 13px;"><fmt:formatNumber value="${space.spaceHourlyRate}" pattern="#,###" />원x${fn:length(reservationTimeItem)}시간</strong> <fmt:formatNumber value="${space.spaceHourlyRate * fn:length(reservationTimeItem)}" pattern="#,###" />원</p>
                        <hr>
                        <p><strong class="strong">총 금액 합계</strong> <fmt:formatNumber value="${space.spaceHourlyRate * fn:length(reservationTimeItem)}" pattern="#,###" />원 (부가세 포함)</p>
                    </div>
                </div>
            </div>
            
            <div class="detailPage">
                <div class="info-box_2">
                    <div id="spaceLocationDiv">
						<span style="font-size: 24px; font-weight: bold;">위치</span>
						<div id="map" style="width: 100%; height: 300px; margin-bottom: 20px; margin-top:10px;"></div>
						<script>
							// Kakao Maps API 초기화
							setTimeout(function() {
								kakao.maps.load(function() {
									var mapContainer = document.getElementById('map'); // 지도 컨테이너
									var mapOptions = {
										center : new kakao.maps.LatLng(
												37.5665, 126.9780), // 초기 중심 좌표 (서울)
										level : 3	// 확대 레벨
									};
	
									var map = new kakao.maps.Map(mapContainer, mapOptions);
	
									// 주소 -> 좌표 변환 객체 생성
									var geocoder = new kakao.maps.services.Geocoder();
	
									// 검색할 주소
									var address = "${space.spaceAddr}";
	
									// 주소를 좌표로 변환
									geocoder.addressSearch(
										address, function(result, status) {
											if (status === kakao.maps.services.Status.OK) {
												var latlng = new kakao.maps.LatLng(
													result[0].y,
													result[0].x
												);
	
												// 지도 중심을 변경
												map.setCenter(latlng);
	
												// 마커 생성
												var marker = new kakao.maps.Marker({
													position : latlng	// 마커 위치
												});
	
												// 마커 지도에 표시
												marker.setMap(map);
											} 
											else {
												console.error("주소 검색 실패: ",status);
											}
										}
									);
								});
							}, 500);
						</script>
						<p id="spaceAddr" style="margin-bottom:50px;">
							<img id="addrIcon" alt="" src="/resources/images/space/icon/addr.svg">&nbsp; ${space.spaceAddr}
						</p>
						<span style="font-size: 24px; font-weight: bold; margin-top: 30px;">찾아오시는 길</span>
						<p>${space.spaceAddr} ${space.spaceAddrDesc}</p>
					</div>
                </div>
            </div>

            <h2 style="margin-bottom: 1px;">예약 내용</h2>
            <div class="detailPage">
                <div class="info-box">
                    <div class="details" style="width: 100%; margin-left: 15px; margin-right: 20px;">
                        <p>
                        	<strong class="strong">콘텐츠 종류</strong>
                        	 <c:choose>
                        	 	<c:when test="${space.spaceType eq 1}">파티룸</c:when>
                        	 	<c:when test="${space.spaceType eq 2}">연습실</c:when>
                        	 	<c:when test="${space.spaceType eq 3}">스터디룸</c:when>
                        	 	<c:when test="${space.spaceType eq 4}">공유주방</c:when>
                        	 	<c:when test="${space.spaceType eq 5}">스튜디오</c:when>
                        	 	<c:when test="${space.spaceType eq 6}">카페</c:when>
                        	 	<c:when test="${space.spaceType eq 7}">오피스</c:when>
                        	 	<c:when test="${space.spaceType eq 8}">스몰웨딩</c:when>
                        	 	<c:when test="${space.spaceType eq 9}">운동시설</c:when>
                        	 	<c:when test="${space.spaceType eq 10}">가정집</c:when>
                        	 	<c:when test="${space.spaceType eq 11}">실외촬영</c:when>
                        	 	<c:when test="${space.spaceType eq 12}">당일캠핑</c:when>
                        	 	<c:when test="${space.spaceType eq 13}">갤러리</c:when>
                        	 	<c:when test="${space.spaceType eq 14}">컨퍼런스</c:when>
                        	 </c:choose>
                        </p>
                        <hr>
                        <p><strong class="strong">인원 수</strong> ${inputPeopleValue}명</p>
                    </div>
                </div>
            </div>

            <h2 style="margin-bottom: 1px;">결제 금액</h2>
            <div class="detailPage">
                <div class="info-box_2">
                    <h2>결제</h2>
                    <div class="details_2">
                        <p><strong class="strong">총 금액</strong> <fmt:formatNumber value="${space.spaceHourlyRate * fn:length(reservationTimeItem)}" pattern="#,###" /></p>
                        <!-- <p><strong class="strong">쿠폰 사용</strong> (-) 0</p> -->
                        <hr>
                        <p><strong class="strong">최종 결제 금액</strong> <fmt:formatNumber value="${space.spaceHourlyRate * fn:length(reservationTimeItem)}" pattern="#,###" />원 (부가세 포함)</p>
                    </div>
                </div>
            </div>

            <div class="returnInfo">
                <p id="return"><b style="font-size: 18px;">spaceUp 환불 규정</b>

                    호스트 승인 전
                    • 호스트 승인 전에 예약 취소 시 100% 환불돼요.
                    
                    호스트 승인 후
                    • 게스트 취소 시 - 결제 후 2시간 이내 또는 사용일 4일 전까지 취소하면 100% 환불돼요.(사용일 3일 전 환불 불가)
                    • 호스트 귀책 사유 취소 시 - 100% 환불돼요.
                </p>
            </div>

            <div class="buttons">
            	<button type="button" id="btnReservation" name="btnReservation" class="btnReservation" onclick="fn_kakaoPayReady()">예약</button>
                <button type="button" id="btnCancel" name="btnCancel" class="btnReservation">취소</button>
            </div>
        </div>
    </div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
		$("#btnCancel").on("click", function() {
			location.href = "/space/spaceView?spaceId="+${space.spaceId};
		});
		
		function fn_kakaoPayReady() {
			console.log(${useDate});
			
			$.ajax({
				type : "POST",
				url : "/kakao/readyAjax",
				xhrFields: {
			        withCredentials: true, // 쿠키를 포함
			    },
			    crossDomain: true, // 크로스 도메인 요청 허용
			    headers: {
			        ajax: "true", // 사용자 정의 헤더 추가
			    },
				data : {
					spaceId: ${space.spaceId},
					useDate: ${useDateFormat},
					useStartTime: ${reservationTimeItem[0]},
					useEndTime: ${reservationTimeItem[fn:length(reservationTimeItem) - 1]} + 1,
					usePeople: ${inputPeopleValue},
					amount: ${space.spaceHourlyRate * fn:length(reservationTimeItem)},
					spaceName: "${space.spaceName}"
				},
				datatype : "JSON",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(res) {
					icia.common.log(res);

					if (res.code == 0) {
						let _width = 500;
						let _height = 500;

						let _left = Math
								.ceil((window.screen.width - _width) / 2);
						let _top = Math
								.ceil((window.screen.height - _height) / 2);

						kakaoPayPopup = window
								.open(
										res.data.next_redirect_pc_url,
										"카카오페이 결제",
										"width="
												+ _width
												+ ", height="
												+ _height
												+ ", left="
												+ _left
												+ ", top="
												+ _top
												+ ", resizable=false, scrollbars=false, status=false, titlebar=false, toolbar=false, menubar=false");
					} else {
						alert(res.msg);
					}
				},
				error : function(error) {
					icia.common.error(error);
				}
			});
		}
	</script>
</body>
</html>







