<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<title><spring:eval expression="@env['site.title']" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/space/spaceView.css">
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0f979efa24339b22af634ee6af0fd743&libraries=services"></script>

<script>
	const isEmpty = (value) => {
		if ($.trim(value).length <= 0) return true
	    if (value === null) return true
	    if (typeof value === 'undefined') return true
	    if (typeof value === 'string' && value === '') return true
	    if (Array.isArray(value) && value.length < 1) return true
	    if (typeof value === 'object' && value.constructor.name === 'Object' && Object.keys(value).length < 1 && Object.getOwnPropertyNames(value) < 1) return true
	    if (typeof value === 'object' && value.constructor.name === 'String' && Object.keys(value).length < 1) return true // new String()

	    return false
	}
</script>
</head>
<body class="view">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div id="spaceViewContainer">

		<!-- 상단 공간 이미지 -->
		<div id="spaceImgDiv">
		
			
			<c:if test="${not empty spaceImgNames}">
				<div id="spaceImgDivLeft">
					<div class="thumnailDiv">
						<button class="btnShowImg" onclick="fn_showImgList(0)">
							<img alt="" src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${space.spaceType}/${space.spaceId}/${spaceImgNames[0]}">
						</button>
					</div>
				</div>
				
				<div id="spaceImgDivRight">
					<c:forEach var="spaceImgName" items="${spaceImgNames}" varStatus="status" begin="1" end="4">
						<c:choose>
							<c:when test="${status.last}">
								<div class="noThumnailDiv">
									<button class="btnShowImg" onclick="fn_showImgList(${status.index})">
										<img alt="" src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${space.spaceType}/${space.spaceId}/${spaceImgName}">
									</button>
									<button id="moreImgDiv" onclick="fn_showImgList(0)">
										+${fn:length(spaceImgNames)}
										<!-- 등록된 이미지 숫자 - 5(보여지는 이미지) -->
										<img alt="" src="/resources/images/space/icon/moreImg.svg">
									</button>
									
									<!-- 이미지뷰어 -->
									<div id="fullImageView" class="full-image-view">
									    <!-- 이미지 레이아웃 -->
									    <div class="image-container">
									        <!-- 닫기 버튼 -->
									        <span id="closeBtn" class="close-btn">X</span>
									
									        <!-- 이전 버튼 -->
									        <button id="prevBtn" class="nav-btn">◁</button>
									
									        <!-- 이미지 -->
									        <img id="viewedImage" src="" alt="상품 이미지">
									
									        <!-- 다음 버튼 -->
									        <button id="nextBtn" class="nav-btn">▷</button>
									    </div>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="noThumnailDiv">
									<button class="btnShowImg" onclick="fn_showImgList(${status.index})">
										<img alt="" src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${space.spaceType}/${space.spaceId}/${spaceImgName}">
									</button>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
			</c:if>
			
			<c:if test="${empty spaceImgNames}">
				<div class="topNoneImg">
					<img alt="" src="/resources/images/space/icon/imagebear.jpg";>			
				</div>
			</c:if>
			

			
		</div>
		<!-- 컨텐츠, 예약 공간 -->
		<div id="spaceContentDiv">
			<div id="spaceContentLeftDiv">
				<div id="spaceInfoDiv">
					<a><span id="hostName"><c:out value="${space.hostNickname }"></c:out></span></a>
					<div id="spaceNameDiv">
						<h1 id="spaceName"><c:out value="${space.spaceName}"></c:out></h1>
						<button id="btnSpaceShare">
							<img class="addrIcon" alt="" src="https://img.shareit.kr/front-assets/icons/shareLink_lineRegular_gray014.svg?version=1.0">
						</button>
						<div id="copyNotification" class="copy-notification">
						    링크가 복사되었습니다.
						</div>
						
						<script type="text/javascript">
							$('#btnSpaceShare').on('click', function() {
							    const currentUrl = window.location.href;
	
							    // 가상 input 요소 생성
							    const tempInput = $('<input>');
							    $('body').append(tempInput);
							    tempInput.val(currentUrl).select(); // URL을 input에 설정하고 선택
	
							    // 클립보드에 복사
							    document.execCommand('copy');
							    
							    // 복사 완료 후 알림 표시
							    const notification = $('#copyNotification');
							    notification.text('링크가 복사되었습니다.');
							    notification.addClass('show'); // 알림 박스 보이기
	
							    // 2초 후에 알림 박스 숨기기
							    setTimeout(function() {
							        notification.removeClass('show'); // 알림 박스 숨기기
							    }, 2000);
	
							    // 사용 후 input 요소 제거
							    tempInput.remove();
							});
						</script>
						
					</div>
					<p id="spaceAddr">
						<img id="addrIcon" alt="" src="/resources/images/space/icon/addr.svg">&nbsp; 주소 ${space.spaceAddr} ${space.spaceAddrDesc}
					</p>
					<div id="reviewInfoDiv">
						<div id="starRatingDiv">
							<!-- 별점에 따라 별 찍어주기 -->
							<fmt:parseNumber var="reviewScoreAvgInt" value="${space.reviewScoreAvg}" integerOnly="true" />
							
							<c:forEach begin="1" end="5" var="i">
								<c:choose>
									<c:when test="${reviewScoreAvgInt ge i}">
										<img src="/resources/images/space/icon/starYellow.svg" width="17">
									</c:when>
									<c:otherwise>
										<img src="/resources/images/space/icon/starGray.svg" width="17">
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
						&nbsp; <span id="starScore"><c:out value="${space.reviewScoreAvg}"></c:out></span> &nbsp;&nbsp;<span style="color: rgba(61, 61, 61, 0.2);">|</span>&nbsp;&nbsp; <span id="reviewCount">리뷰(${space.reviewCnt})</span>
					</div>
				</div>

				<div id="spaceViewTap">
					<button class="btnTab" data-target="#spaceDetail">공간정보</button>
					<button class="btnTab" data-target="#spaceNotes">주의사항</button>
					
					<button class="btnTab" data-target="#spaceReview">
						리뷰
						<!-- 후기 갯수 -->
						<span class="tabDetail"><c:out value="${space.reviewCnt}"></c:out></span>
					</button>
					<button class="btnTab" data-target="#spaceQnA">
						문의
						<!-- 공간QnA 갯수 -->
						<span class="tabDetail"><c:out value="${space.spaceQuestionCnt}"></c:out></span>
					</button>
					<button class="btnTab" data-target="#spaceRefund">환불규정</button>
				</div>

				<div id="spaceDetail">

					<div id="spaceDescDiv">
						<span style="font-size: 24px; font-weight: bold;">공간정보</span>
						<!-- 공간소개DB -->
						<p><c:out value="${space.spaceDesc}" escapeXml="false"></c:out></p>
					</div>

					<div id="spaceTipDiv">
						<span style="font-size: 24px; font-weight: bold;">공간 이용 TIP</span>
						<p><c:out value="${space.spaceTip}" escapeXml="false"></c:out></p>
						<div id="spaceOptionDiv">
							<div id="spaceMaxCapacityDiv">
								<img src="/resources/images/space/icon/maxCapacity.svg" style="width: 32px; height: 32px;">
								<!-- 최대 인원 수(DB) -->
								
								<c:choose>
								<c:when test="${space.spaceMaxCapacity eq 100}">
									<p>인원 제한 없습니다.</p>
								</c:when>
								<c:otherwise>
									<p>최대 <c:out value="${space.spaceMaxCapacity}"></c:out> 명</p>
								</c:otherwise>
								</c:choose>
							</div>
							<div id="spaceParkingDiv">
								<img src="/resources/images/space/icon/parking.svg" style="width: 32px; height: 32px;">
								<!-- 주차 가능 차량 수DB) -->
								<c:choose>
							    <c:when test="${space.spaceParking + 0 gt 0}">
							        <p>주차 <fmt:formatNumber value="${space.spaceParking}" type="number" maxFractionDigits="0" />대 가능</p>
							    </c:when>
							    <c:otherwise>
							        <p>주차 정보 없습니다.</p>
							    </c:otherwise>
							</c:choose>
							</div>
						</div>
					</div>

					<div id="spaceLocationDiv">
						<span style="font-size: 24px; font-weight: bold;">위치</span>
						<div id="map"></div>
						<script>
							// Kakao Maps API 초기화
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
						</script>
						<p id="spaceAddr">
							<img id="addrIcon" alt="" src="/resources/images/space/icon/addr.svg">&nbsp; ${space.spaceAddr} ${space.spaceAddrDesc}
						</p>
					</div>
				</div>


				<div id="spaceNotes">
					<span style="font-size: 24px; font-weight: bold;">주의사항</span>
					<p>
						${space.spaceNotice}
					</p>
				</div>
				

				<div id="spaceReview">
					<div class="headerDiv">
						<div class="headerLeftDiv">
							<span style="font-size: 24px; font-weight: bold;">리뷰</span>
							&nbsp;
							<span id="reviewCntTagId" style="font-size: 24px; font-weight: bold; color: #36BC9B;">${space.reviewCnt}</span>
						</div>
						
						<div class="headerRightDiv">
							<button class="btnReviewSort active" id="btnSortByLikey" value="1">추천순</button>
							<button class="btnReviewSort" id="btnSortByNew" value="2">최신순</button>
							<script type="text/javascript">
								
							</script>
						</div>
					</div>
					
					<div id="reviewListBox"></div>
						<c:if test="${space.reviewCnt eq 0}">
							<div id="noReview">
								<p>작성된 리뷰가 없습니다.</p>
							</div>
						</c:if>
					<div id="reviewPagingDiv"></div>
				</div>
				
				<!-- 리뷰 수정 modal -->
				
				<div id="rvUpdateOverlay">
				    <!-- 흰색 슬라이드 div -->
				    <div id="rvUpdateSlideUpDiv">
				        <div id="rvUpdateHeaderDiv">
			        		<span style="font-size: 16px; font-weight: bold; color: rgb(27, 29, 31); width: 100%; text-align: center;">리뷰 수정 내용을 입력하세요.</span>
				        	<button id="btnRvUpdateClose" style="width: fit-content; position: absolute; top: 23px; right: 26px; background: transparent; border: none; outline:none;">
				        		<img src="/resources/images/space/icon/close.svg" style="display: block; width: 18px;">
				        	</button>
				        </div>
				        
				        <div id="rvUpdateHeaderDiv">
			        		<span style="font-size: 12px; font-weight: bold; color: #828181b3; width: 100%; text-align: center;">500자 내로 입력바랍니다!</span>
				        </div>
				        
				        
				        <div class="reviewScoreSelectBox">
				        	<p>평점 수정</p>
				        	<div class="reviewScoreSelect">
				        		<input type="radio" id="option1" name="reviewScore" value="1">
						        <label for="option1">1점</label>
						        <input type="radio" id="option2" name="reviewScore" value="2">
						        <label for="option2">2점</label>
						        <input type="radio" id="option3" name="reviewScore" value="3">
						        <label for="option3">3점</label>
						        <input type="radio" id="option4" name="reviewScore" value="4">
						        <label for="option4">4점</label>
						        <input type="radio" id="option5" name="reviewScore" value="5">
						        <label for="option5">5점</label>
				        	</div>
					    </div>
				        
				        <div id="rvUpdateContentHeaderDiv">
				        	<div>
				        		<span>내용</span>
				        	</div>
				        	<div>
				        		<span id="inputRvUpdateCount">0</span><span>/500자</span>
				        	</div>
				        </div>
				        
				        <div id="rvUpdateContentDiv">
				        	<textarea id="rvUpdateContentTextarea" maxlength="500" style=" font-size: 14px; border: none; outline: none; width: 100%; resize: none; height: 100%" ></textarea>
				        </div>
				        
				        <div id="rvUpdateFooterDiv">
				        	<span style="color: white; font-weight: bold;">수정하기</span>
				        </div>
				        
				        <script>
					        $(document).ready(function () {
					            const maxLength = 500; // 최대 글자 수

					            $("#rvUpdateContentDiv textarea").on("input", function () {
					                const textLength = $(this).val().length; // 입력된 글자 수
					                const $counter = $("#inputRvUpdateCount");
					                $counter.text(textLength); // 글자 수 업데이트

					                // 글자 수 제한 초과 여부 확인
					                if (textLength >= maxLength) {
					                    $counter.addClass("over-limit"); // 빨간색 클래스 추가
					                } else {
					                    $counter.removeClass("over-limit"); // 클래스 제거
					                }
					            });
					        });
					    </script>
				    </div>
				</div>
				
				<script type="text/javascript">
					$(document).ready(function () {
					    // "문의하기" 클릭 시
					    $("body").on("click", "#rvUpdateWriteDiv", function (e) {
					        $("#rvUpdateOverlay").fadeIn(300); // 검은 배경 표시
					        $("#rvUpdateSlideUpDiv").css("bottom", "200px"); // 흰색 div 슬라이드업
					        $("#rvUpdateContentTextarea").val($(".reviewContent"+e.target.dataset.reviewid).text());
					        document.getElementById('rvUpdateFooterDiv').dataset.reviewid = e.target.dataset.reviewid;
					        $('input:radio[name="reviewScore"]').prop("checked", false);
					    });

					    // 검은 배경 클릭 시 닫기
					    $("#rvUpdateOverlay").on("click", function (e) {
					        if ($(e.target).is("#rvUpdateOverlay")) { // 흰색 div 외의 검은 배경을 클릭한 경우
					            $("#rvUpdateOverlay").fadeOut(300); // 검은 배경 숨기기
					            $("#rvUpdateSlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
					        }
					    });
					    
					    $('#btnRvUpdateClose').on('click', function () {
					    	$("#rvUpdateOverlay").fadeOut(300); // 검은 배경 숨기기
				            $("#rvUpdateSlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
					    });
					    
					});
					
					$("#rvUpdateFooterDiv").on("click", function(e) {
						if($('input:radio[name="reviewScore"]:checked').val() == null) {
							Swal.fire({
		    			        icon: 'warning',
		    			        title: '별점을 선택해주세요.',
		    			        text: '',			        
		    			        confirmButtonColor: '#71D3BB',
		    			        customClass: { container: 'my-alert-container' }
		    			    });
		    			    
		    			    setTimeout(function() {
		    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
		    			    }, 10);
		    			    
							return;
						}
						
						if(isEmpty($("#rvUpdateContentTextarea").val())) {
							Swal.fire({
		    			        icon: 'warning',
		    			        title: '리뷰 내용을 입력해주세요.',
		    			        text: '',			        
		    			        confirmButtonColor: '#71D3BB',
		    			        customClass: { container: 'my-alert-container' }
		    			    });
		    			    
		    			    setTimeout(function() {
		    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
		    			    }, 10);
							return;
						}
						
						$.ajax({
							type: "POST",
							url: "/space/reviewUpdate",
							data: {
								reviewId: e.currentTarget.dataset.reviewid,
								reviewContent: $("#rvUpdateContentTextarea").val(),
								reviewScore: $('input:radio[name="reviewScore"]:checked').val()
							},
							datatype: "JSON",
							success: function(response) {
								if(response.code == 0) {
									alert(response.msg);
								} else if(response.code == -1) {
									alert(response.msg);
								} else if(response.code == -2) {
									alert(response.msg);
								}
							},
							error: function(error) {
								Swal.fire({
			    			        icon: 'error',
			    			        title: '리뷰 수정이 실패하였습니다.',
			    			        text: '',			        
			    			        confirmButtonColor: '#71D3BB',
			    			        customClass: { container: 'my-alert-container' }
			    			    });
			    			    
			    			    setTimeout(function() {
			    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
			    			    }, 10);
							},
							complete: function() {
								$("#rvUpdateOverlay").fadeOut(300); // 검은 배경 숨기기
					            $("#rvUpdateSlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
					            fn_review();
							}
						});
					});
				</script>

				<div id="spaceQnA">
					<div class="headerDiv">
						<div class="headerLeftDiv">
							<span style="font-size: 24px; font-weight: bold;">문의</span>
							&nbsp;
							<span id="QnACntTagId" style="font-size: 24px; font-weight: bold; color: #36BC9B;">${space.spaceQuestionCnt}</span>
						</div>
						
						<div class="headerRightDiv">
							<div id="QnAWriteDiv" class="QnAWriteDiv">
								<img src="/resources/images/space/icon/write.svg" style="padding-left: 5px;">
								&nbsp;
								<span style="padding-right: 5px; font-size: 14px; font-weight: bold; color: rgb(69, 75, 80);">문의하기</span>
							</div>
						</div>
						
						
						<div id="QnAOverlay">
						    <!-- 흰색 슬라이드 div -->
						    <div id="QnASlideUpDiv">
						        <div id="QnAHeaderDiv">
					        		<span style="font-size: 16px; font-weight: bold; color: rgb(27, 29, 31); width: 100%; text-align: center;">궁금한 내용을 적어주세요</span>
						        	<button id="btnQnAClose" style="width: fit-content; position: absolute; top: 23px; right: 26px; background: transparent; border: none; outline:none;">
						        		<img src="/resources/images/space/icon/close.svg" style="display: block; width: 18px;">
						        	</button>
						        </div>
						        
						        <div id="QnAHeaderDiv">
					        		<span style="font-size: 12px; font-weight: bold; color: #828181b3; width: 100%; text-align: center;">호스트가 확인 후 답변을 드릴거에요!</span>
						        </div>
						        
						        <div class="questionCategorySelectBox" style="display:flex; justify-content:center;">
						        	
						        	<select id="questionCategorySelect" name="questionCategorySelect">
						        		<option value="0" selected disabled style="color: rgb(189, 189, 189);">Q&A유형을 선택하세요</option>
						        		<option value="1">공간문의</option>
						        		<option value="2">가격문의</option>
						        		<option value="3">기타</option>
						        	</select>
						        </div>
						        
						        <div id="QnAContentHeaderDiv">
						        	<div>
						        		<span>내용</span>
						        	</div>
						        	<div>
						        		<span id="inputQuestionCount">0</span><span>/200자</span>
						        	</div>
						        </div>
						        
						        <div id="QnAContentDiv">
						        	<textarea id="questionContentInsert" maxlength="200" placeholder="질문을 작성하기 전에 확인해주세요!&#10;&#10;・ 장소에 대해 궁금한 점을 호스트에게 문의하는 공간이에요.&#10;・ 질문은 공개 상태로만 등록할 수 있어요.&#10;・ 개인정보를 공유 또는 요구하거나 아워플레이스를 통하지 않은 직거래 유도, 비방/욕설/명예훼손성 글을 등록하면 사전에 고지 없이 삭제 조치 될 수 있으며 서비스 이용에 제약이 있을 수 있습니다." style=" font-size: 14px; border: none; outline: none; width: 100%; resize: none;" ></textarea>
						        </div>
						        
						        <div id="QnaFooterDiv">
						        	<span style="color: white; font-weight: bold;">문의하기</span>
						        </div>
						        
						        <script>
							        $(document).ready(function () {
							            const maxLength = 200; // 최대 글자 수
	
							            $("#QnAContentDiv textarea").on("input", function () {
							                const textLength = $(this).val().length; // 입력된 글자 수
							                const $counter = $("#inputQuestionCount");
	
							                $counter.text(textLength); // 글자 수 업데이트
	
							                // 글자 수 제한 초과 여부 확인
							                if (textLength >= maxLength) {
							                    $counter.addClass("over-limit"); // 빨간색 클래스 추가
							                } else {
							                    $counter.removeClass("over-limit"); // 클래스 제거
							                }
							            });
							        });
							    </script>
						    </div>
						</div>
						<script type="text/javascript">
							$(document).ready(function () {
							    // "문의하기" 클릭 시
							    $("#QnAWriteDiv, #QnAWriteDiv2").on("click", function () {
							        $("#QnAOverlay").fadeIn(300); // 검은 배경 표시
							        $("#QnASlideUpDiv").css("bottom", "200px"); // 흰색 div 슬라이드업
							    });
	
							    // 검은 배경 클릭 시 닫기
							    $("#QnAOverlay").on("click", function (e) {
							        if ($(e.target).is("#QnAOverlay")) { // 흰색 div 외의 검은 배경을 클릭한 경우
							            $("#QnAOverlay").fadeOut(300); // 검은 배경 숨기기
							            $("#QnASlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
							        }
							    });
							    
							    $('#btnQnAClose').on('click', function () {
							    	$("#QnAOverlay").fadeOut(300); // 검은 배경 숨기기
						            $("#QnASlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
							    });
							    
							    $("#QnaFooterDiv").on("click", function() {
							    	if($("#questionCategorySelect").val() == null) {
							    		Swal.fire({
					    			        icon: 'warning',
					    			        title: '질문 유형을 선택해주세요.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
							    		return;
							    	}
							    	
							    	if(isEmpty($("#questionContentInsert").val())) {
							    		Swal.fire({
					    			        icon: 'warning',
					    			        title: '문의 내용을 입력해주세요.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
							    		return;
							    	}
							    	
							    	$.ajax({
							    		type: "POST",
							    		url: "/space/questionInsert",
							    		data: {
							    			spaceId: ${space.spaceId},
							    			questionContent: $("#questionContentInsert").val(),
							    			questionCategory: $("#questionCategorySelect").val()
							    		},
							    		datatype: "JSON",
							    		success: function(response) {
							    			if(response.code == 0) {
							    				alert(response.msg);
							    			} else if(response.code == -1) {
							    				alert(response.msg);
							    			} else if(response.code == 400) {
							    				alert(response.msg);
							    				location.href = "/guest/loginForm";
							    			}
							    		},
							    		complete: function() {
							    			$("#questionContentInsert").val("");
							    			$("#QnAOverlay").fadeOut(300); // 검은 배경 숨기기
								            $("#QnASlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
								            $("select[name=questionCategorySelect]").val('0').prop("selected", true);
								            $("#noQuestion").hide();
								            fn_question();
							    		}
							    	});
							    });
							});
						</script>
					</div>
					
					<!-- QnA1 -->
					<div id="qnaListBox"></div>
						<c:if test="${space.spaceQuestionCnt eq 0}">
							<div id="noQuestion">
								<p>작성된 질문이 없습니다.</p>
							</div>
						</c:if>
					<div id="qnaPagingDiv"></div>
					
				</div>
				
				<!-- 질문 수정 modal -->
				
				<div id="qnaUpdateOverlay">
				    <!-- 흰색 슬라이드 div -->
				    <div id="qnaUpdateSlideUpDiv">
				        <div id="qnaUpdateHeaderDiv">
			        		<span style="font-size: 16px; font-weight: bold; color: rgb(27, 29, 31); width: 100%; text-align: center;">질문 수정 내용을 입력하세요.</span>
				        	<button id="btnQnaUpdateClose" style="width: fit-content; position: absolute; top: 23px; right: 26px; background: transparent; border: none; outline:none;">
				        		<img src="/resources/images/space/icon/close.svg" style="display: block; width: 18px;">
				        	</button>
				        </div>
				        
				        <div id="qnaUpdateHeaderDiv">
			        		<span style="font-size: 12px; font-weight: bold; color: #828181b3; width: 100%; text-align: center;">500자 내로 입력바랍니다!</span>
				        </div>
				        
				        <div class="questionCategorySelectBox" style="display:flex; justify-content:center;">
				        	<select id="questionCategoryUpdateSelect">
				        		<option value="0" selected disabled style="color: rgb(189, 189, 189);">Q&A유형을 선택하세요</option>
				        		<option value="1">공간문의</option>
				        		<option value="2">가격문의</option>
				        		<option value="3">기타</option>
				        	</select>
				        </div>
				        
				        <div id="qnaUpdateContentHeaderDiv">
				        	<div>
				        		<span>내용</span>
				        	</div>
				        	<div>
				        		<span id="inputQnaUpdateCount">0</span><span>/500자</span>
				        	</div>
				        </div>
				        
				        <div id="qnaUpdateContentDiv">
				        	<textarea id="qnaUpdateContentTextarea" maxlength="500" style=" font-size: 14px; border: none; outline: none; width: 100%; resize: none; height: 100%" ></textarea>
				        </div>
				        
				        <div id="qnaUpdateFooterDiv">
				        	<span style="color: white; font-weight: bold;">수정하기</span>
				        </div>
				        
				        <script>
					        $(document).ready(function () {
					            const maxLength = 500; // 최대 글자 수

					            $("#qnaUpdateContentDiv textarea").on("input", function () {
					                const textLength = $(this).val().length; // 입력된 글자 수
					                const $counter = $("#inputQnaUpdateCount");
					                $counter.text(textLength); // 글자 수 업데이트

					                // 글자 수 제한 초과 여부 확인
					                if (textLength >= maxLength) {
					                    $counter.addClass("over-limit"); // 빨간색 클래스 추가
					                } else {
					                    $counter.removeClass("over-limit"); // 클래스 제거
					                }
					            });
					        });
					    </script>
				    </div>
				</div>
				
				<script type="text/javascript">
					$(document).ready(function () {
					    // "문의하기" 클릭 시
					    $("body").on("click", "#qnaUpdateWriteDiv", function (e) {
					        $("#qnaUpdateOverlay").fadeIn(300); // 검은 배경 표시
					        $("#qnaUpdateSlideUpDiv").css("bottom", "200px"); // 흰색 div 슬라이드업
					        let content = $(".qnaContent"+e.target.dataset.spacequestionid).html();
					        content = content.replace(/<br>/g, "\n");
					        $("#qnaUpdateContentTextarea").val(content);
					        document.getElementById('qnaUpdateFooterDiv').dataset.spacequestionid = e.target.dataset.spacequestionid;
					        let questionCategory = e.target.dataset.questioncategory;
					        $("select[id=questionCategoryUpdateSelect]").val(questionCategory).prop("selected", true);
					    });

					    // 검은 배경 클릭 시 닫기
					    $("#qnaUpdateOverlay").on("click", function (e) {
					        if ($(e.target).is("#qnaUpdateOverlay")) { // 흰색 div 외의 검은 배경을 클릭한 경우
					            $("#qnaUpdateOverlay").fadeOut(300); // 검은 배경 숨기기
					            $("#qnaUpdateSlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
					        }
					    });
					    
					    $('#btnQnaUpdateClose').on('click', function () {
					    	$("#qnaUpdateOverlay").fadeOut(300); // 검은 배경 숨기기
				            $("#qnaUpdateSlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
					    });
					});
					
					$("#qnaUpdateFooterDiv").on("click", function(e) {
						if($("#questionCategoryUpdateSelect").val() == null) {
							Swal.fire({
		    			        icon: 'warning',
		    			        title: '질문 유형을 선택해주세요.',
		    			        text: '',			        
		    			        confirmButtonColor: '#71D3BB',
		    			        customClass: { container: 'my-alert-container' }
		    			    });
		    			    
		    			    setTimeout(function() {
		    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
		    			    }, 10);
				    		return;
				    	}
				    	
				    	if(isEmpty($("#qnaUpdateContentTextarea").val())) {
				    		Swal.fire({
		    			        icon: 'warning',
		    			        title: '문의 내용을 입력해주세요.',
		    			        text: '',			        
		    			        confirmButtonColor: '#71D3BB',
		    			        customClass: { container: 'my-alert-container' }
		    			    });
		    			    
		    			    setTimeout(function() {
		    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
		    			    }, 10);
		    			    
				    		return;
				    	}
						
						$.ajax({
							type: "POST",
							url: "/space/questionUpdate",
							data: {
								spaceQuestionId: e.currentTarget.dataset.spacequestionid,
								questionCategory: $("#questionCategoryUpdateSelect").val(),
								questionContent: $("#qnaUpdateContentTextarea").val()
							},
							datatype: "JSON",
							success: function(response) {
								if(response.code == 0) {
									Swal.fire({
				    			        icon: 'success',
				    			        title: response.msg,
				    			        text: '',			        
				    			        confirmButtonColor: '#71D3BB',
				    			        customClass: { container: 'my-alert-container' }
				    			    });
				    			    
				    			    setTimeout(function() {
				    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
				    			    }, 10);
								} else if(response.code == -1) {
									alert(response.msg);
								} else if(response.code == -2) {
									alert(response.msg);
								}
							},
							error: function(error) {
								Swal.fire({
			    			        icon: 'error',
			    			        title: '질문 수정이 실패하였습니다.',
			    			        text: '',			        
			    			        confirmButtonColor: '#71D3BB',
			    			        customClass: { container: 'my-alert-container' }
			    			    });
			    			    
			    			    setTimeout(function() {
			    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
			    			    }, 10);
							},
							complete: function() {
								$("#qnaUpdateOverlay").fadeOut(300); // 검은 배경 숨기기
					            $("#qnaUpdateSlideUpDiv").css("bottom", "-100%"); // 흰색 div 다시 아래로
					            fn_question();
							}
						});
					});
				</script>

				<div id="spaceRefund">
	               <div class="returnInfo">
	                  <p id="return">
	                     <b style="font-size: 18px;">spaceUp 환불 규정</b><br />
	                     호스트 승인 전
	                     • 호스트 승인 전에 예약 취소 시 100% 환불돼요.
	                     
	                     호스트 승인 후 
	                     • 게스트 취소 시 - 결제 후 2시간 이내 또는 사용일 4일 전까지 취소하면 100% 환불돼요.(사용일 3일 전 환불 불가)
	                     • 호스트 귀책 사유 취소 시 - 100% 환불돼요.
	                  </p>
	               </div>
	            </div>

			</div>

			
			<div id="spaceContentRightDiv">
				<div id="reservationDiv" class="reservationDiv">
					<div class="reservationDetailDiv">
						<span style="font-size: 12px; font-weight: normal; font-stretch: normal; line-height: 1.33; letter-spacing: normal; color: rgb(69, 75, 80);">
							*현재 단계에서는 요금이 청구되지 않습니다.
						</span>
					</div>
					
					<div class="reservationDetailDiv" style="margin-top: 6px; padding-bottom:10px; border-bottom: 1px solid rgb(223, 226, 231);">
						<span style="font-size: 16px; font-weight: bold; font-stretch: normal; line-height: 1.44; letter-spacing: -0.1px; color: rgb(27, 29, 31);">
							예약 날짜와 시간을 선택해보세요.
						</span>
						<br>
						<span style="font-size: 18px; font-weight: bold; font-stretch: normal; line-height: 1.44; letter-spacing: -0.1px; color: rgb(27, 29, 31);">
							<fmt:formatNumber value="${space.spaceHourlyRate}" pattern="#,###" />원 / 시간
						</span>
						<br><br>
						<div class="h_center">
						   <p>최소 ${space.minReservationTime}시간부터</p>
						</div>
					</div>
					
					<div class="reservationDetailDiv" style="margin-top: 10px;">
						<span style="font-size: 18px; font-weight: bold; font-stretch: normal; line-height: 1.44; letter-spacing: -0.1px; color: rgb(27, 29, 31);">
							스케줄
						</span>
					</div>
					<div class="reservationDetailDiv" style="margin-top: 10px; font-size: 12px; font-weight: bold; font-stretch: normal; line-height: 1.17; letter-spacing: normal; color: rgb(158, 164, 170);">
						<span>공간 예약 날짜</span>
						<div id="inputDateDiv">
							<span id="dateSelect">예약 날짜를 선택하세요</span>
						</div>
					</div>
					
					<form name="reservationForm" id="reservationForm" class="reservationForm" method="post" action="/space/spaceReservationForm">
						<!-- 예약 시간대 출력하는 영역 -->
						<div class="reservationTimeItemListBox"></div>
						<input id="inputPeopleValue" value="" style="display: none;" name="inputPeopleValue"/>
						<input id="useDate" value="" style="display: none;" name="useDate"/>
						<input id="spaceIdInput" value="${space.spaceId}" style="display: none;" name="spaceId"/>
				    </form>
					
					<input type="text" id="reservationDate" style="display: none;">
					
					<script>
					$.datepicker.setDefaults({
					    closeText: "닫기",               // 닫기 버튼 텍스트
					    prevText: "이전",               // 이전 버튼 텍스트
					    nextText: "다음",               // 다음 버튼 텍스트
					    currentText: "오늘",            // 오늘 버튼 텍스트
					    monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
					                 "7월", "8월", "9월", "10월", "11월", "12월"], // 월 이름
					    monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월",
					                      "7월", "8월", "9월", "10월", "11월", "12월"], // 월 이름 (짧은 형식)
					    dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"], // 요일 이름
					    dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],                // 요일 이름 (짧은 형식)
					    dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],                  // 요일 이름 (최소 형식)
					    weekHeader: "주",                // 주 헤더 텍스트
					    dateFormat: "yy-mm-dd",         // 날짜 형식
					    firstDay: 0,                    // 주 시작 요일 (일요일: 0, 월요일: 1)
					    isRTL: false,                   // 오른쪽에서 왼쪽 텍스트 정렬 여부
					    showMonthAfterYear: true,       // 연도 뒤에 월 표시
					    yearSuffix: "년"                // 연도 뒤에 붙는 텍스트
					});

					
							$(document).ready(function() {
						        // jQuery UI datepicker 초기화
						        $("#reservationDate").datepicker({
						        	beforeShow: function (input, inst) {
					                    // 로그인 체크 로직
						        		<c:if test="${empty loginEmail}">
							        		Swal.fire({
						    			        icon: 'warning',
						    			        title: '로그인 후 이용가능합니다.',
						    			        text: '',			        
						    			        confirmButtonColor: '#71D3BB',
						    			    });
							        		
								            return false;
							        	</c:if>
					                },
						            dateFormat: "yy-mm-dd", // 날짜 포맷 설정
						            minDate: 0,             // 오늘 이후 날짜만 선택 가능
						            beforeShowDay: function(date) {
						                var day = date.getDay();
						                
						                
						                
				                		if(${space.spaceCloseDay} == 1) {
											return [true];
										} else if(${space.spaceCloseDay} == 2) {
											return [(day != 0 && day != 6)];
										} else if(${space.spaceCloseDay} == 3) {
											return [(day != 1 && day != 2 && day != 3 && day != 4 && day != 5)];
										} else if (${space.spaceCloseDay} == 4) {
								            let str = "${space.spaceCloseDayHost}";
								            const arr = str.split(","); // 문자열을 배열로 변환
								            
								            // 요일 문자열을 숫자 요일로 매핑
								            const dayMap = { "일": 0, "월": 1, "화": 2, "수": 3, "목": 4, "금": 5, "토": 6 };
								            const disabledDays = arr.map(day => dayMap[day]); // 비활성화된 요일 숫자 배열

								            return [!disabledDays.includes(day)]; // day가 비활성화된 요일에 포함되지 않으면 true
								        } else {
								            return [false];
								        }
						            },
						            onSelect: function(dateText) {
						                // 날짜가 선택되면 선택한 날짜를 #inputDateDiv에 표시
						                $(".reservationForm").css("display", "block");
						                $('#inputDateDiv span').text(dateText);
						                $("#useDate").val(dateText);
						                $("#reservationDate").hide(); // 달력 숨기기
						                
						                $.ajax({
						                	type: "POST",
						                	url: "/space/reservationTimeView",
						                	data: {
						                		spaceId: ${space.spaceId},
						                		useDate: $("#dateSelect").text()
						                	},
						                	success: function(response) {
						                		let timeData = response.data;
						                		
						                		$(".reservationTimeItemListBox").html("");
						                		
						                		const currentDate = new Date();
						                		
						                        const hours = currentDate.getHours();
						                        
						                        const year = currentDate.getFullYear();
						                        const month = String(currentDate.getMonth() + 1).padStart(2, "0"); // 월은 0부터 시작하므로 +1 필요
						                        const day = String(currentDate.getDate()).padStart(2, "0"); // 일

						                        const formattedDate = year+"-"+month+"-"+day;
						                		
						                		for(let i=${space.spaceStartTime}; i <= ${space.spaceEndTime}; i++) {
						                			$(".reservationTimeItemListBox").append(`
								                		<input type="checkbox" class="reservationTimeItem" id="reservationTimeItem\${i}" value="\${i}" name="reservationTimeItem" disabled>
								        				<label class="reservationCheckLabel reservationTimeItemDisabled" for="reservationTimeItem\${i}">\${i}</label>
								                	`);
						                		}
						                		
						                		for(let i=0; i<timeData.length; i++) {
						                			for(let j=timeData[i][0]; j<timeData[i][1];j++) {
						                				if(formattedDate == dateText) {
						                					if(hours < j) {
							                					$("#reservationTimeItem"+j).prop("disabled",false);
								                				$("label[for='reservationTimeItem" + j + "']").removeClass("reservationTimeItemDisabled");
								                			}
						                				} else {
						                					$("#reservationTimeItem"+j).prop("disabled",false);
							                				$("label[for='reservationTimeItem" + j + "']").removeClass("reservationTimeItemDisabled");
						                				}
						                			}
						                		}
						                		
						                		// `space.spaceEndTime`이 `timeData`의 범위에 포함되는지 확인하여 마지막 시간 활성화 여부 결정
						                        let lastTime = ${space.spaceEndTime};
						                        let isLastTimeAvailable = false;

						                        // `timeData`에서 마지막 시간 확인
						                        for (let i = 0; i < timeData.length; i++) {
						                            // 시간 범위가 현재 시간(`lastTime`)을 포함하는지 확인
						                            if (lastTime >= timeData[i][0] && lastTime <= timeData[i][1]) {
						                                isLastTimeAvailable = true;
						                                break;
						                            }
						                        }

						                        // `space.spaceEndTime`이 사용 가능한 시간대에 포함되면 활성화
						                        if (isLastTimeAvailable) {
						                            $("#reservationTimeItem" + lastTime).prop("disabled", false);
						                            $("label[for='reservationTimeItem" + lastTime + "']").removeClass("reservationTimeItemDisabled");
						                        }
						                        
						                	},
						                	error: function(error) {
						                		console.log("reservationSelect Error");
						                	}
						                });
						            }
						        });
		
						        // #inputDateDiv 클릭 시 달력 보이기
						        $("#inputDateDiv").click(function() {
						            $("#reservationDate").datepicker("show"); // 달력 보이기
						        });
						        
						        
						        $(".reservationTimeItemListBox").on("click", ".reservationCheckLabel", function(e) {
						        	// 클릭된 label의 for 속성 값 가져오기
						            var checkboxId = $(this).attr('for');
						            
						            // 해당 id를 가진 checkbox의 value 가져오기
						            var checkboxValue = parseInt($("#" + checkboxId).val());
						        	
						         	// 모든 체크박스에서 체크된 값들을 가져오기
						            let checkedValues = [];
						            $('input[class="reservationTimeItem"]:checked').each(function() {
						                checkedValues.push($(this).val());
						            });
						            
						            if($("#" + checkboxId).prop("checked") == false && !$("#" + checkboxId).prop("disabled")) {
							            if(checkedValues.length > 0) {
							            	if(checkboxValue - 1 != checkedValues[checkedValues.length-1] && checkboxValue + 1 != checkedValues[checkedValues.length-1] 
							            	&& checkboxValue + 1 != checkedValues[0]) {
							            		$("#" + checkboxId).prop("checked", true);
							            		Swal.fire({
							    			        icon: 'warning',
							    			        title: '연속된 시간을 선택해주세요.',
							    			        text: '',			        
							    			        confirmButtonColor: '#71D3BB',
							    			        customClass: { container: 'my-alert-container' }
							    			    });
							    			    
							    			    setTimeout(function() {
							    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
							    			    }, 10);
						            		}
							            }
						            	
						            } else if($("#" + checkboxId).prop("checked") == true) {
						            	if(checkedValues.length > 2) {
						            		let checkValueFront = false;
						            		let checkValueBack = false;
						            		
							            	for(let i=0; i<checkedValues.length; i++) {
							            		if(checkboxValue-1 == checkedValues[i]) {
							            			checkValueFront = true;
							            		}
							            		if(checkboxValue+1 == checkedValues[i]) {
							            			checkValueBack = true;
							            		}
							            		
							            		checkedValues.sort((a, b) => a - b); // 값 정렬
							            		
							            		if(checkValueFront && checkValueBack) {
							            			$("#" + checkboxId).prop("checked", true);
								            		Swal.fire({
								    			        icon: 'warning',
								    			        title: '연속된 시간을 선택해주세요.',
								    			        text: '',			        
								    			        confirmButtonColor: '#71D3BB',
								    			        customClass: { container: 'my-alert-container' }
								    			    });
								    			    
								    			    setTimeout(function() {
								    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
								    			    }, 10);
							            			$("#" + checkboxId).prop("checked", false);
							            			return;
							            		}
							            	}
							            }
						            }
						            
						        });
						        
						     	// 상태 변경 이벤트
						        $(".reservationTimeItemListBox").on("change", ".reservationTimeItem", function () {
						        	let checkedValues = [];
						            $('input[class="reservationTimeItem"]:checked').each(function() {
						                checkedValues.push($(this).val());
						            });
						            
						        	if(${space.minReservationTime} <= checkedValues.length && $("#inputPeopleValue").val() > 0) {
						            	$(".reservationSubmitBtn").css("color", "white");
						            	$(".btnreservationDiv").css("background-color", "#36BC9B");
						            }
						            
						            if(${space.minReservationTime} > (checkedValues.length) && $("#inputPeopleValue").val() > 0) {
						            	$(".reservationSubmitBtn").css("color", "#9ea4aa");
						            }
						        });
						        
						        
						        
						        $(".btnreservationDiv").on("click", function() {
						        	<c:if test="${empty loginEmail}">
						        	$("#" + checkboxId).prop("checked", true);
				            		Swal.fire({
				    			        icon: 'warning',
				    			        title: '로그인부터 해주세요.',
				    			        text: '',			        
				    			        confirmButtonColor: '#71D3BB',
				    			        customClass: { container: 'my-alert-container' }
				    			    });
				    			    
				    			    setTimeout(function() {
				    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
				    			    }, 10);
							            return;
							        </c:if>
						        	
						        	// 체크된 체크박스 값 가져오기
						            let checkedValues = [];
						            $('input[class="reservationTimeItem"]:checked').each(function() {
						                checkedValues.push($(this).val());
						            });

						        	if(${space.minReservationTime} > checkedValues.length) {
						        		$("#" + checkboxId).prop("checked", true);
					            		Swal.fire({
					    			        icon: 'warning',
					    			        title: '최소 시간이 선택되지 않았습니다.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
						        		return;
						        	};
						        	
						        	if($("#inputPeopleCount").val() == "" || parseInt($("#inputPeopleCount").val()) <= 0) {
						        		$("#" + checkboxId).prop("checked", true);
					            		Swal.fire({
					    			        icon: 'warning',
					    			        title: '인원이 선택되지 않았습니다.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
						        		return;
						        	}
						        	
						        	let selectedValues;
						        	
						        	setTimeout(() => {
						        	    selectedValues = $(".reservationTimeItem:checked").map(function() {
						        	        return this.value;
						        	}).get();
						        	
						        	$.ajax({
						        		type: "POST",
						        		url: "/space/reservationCheck",
						        		data: {
						        			spaceId: ${space.spaceId},
						        			useDate: $("#useDate").val(),
						        			reservationTimeItem: selectedValues,
						        	        inputPeopleValue: $("#inputPeopleCount").val()
						        		},
						        		success: function(response) {
						        			if(response.code == 0) {
						        				Swal.fire({
							    			        icon: 'success',
							    			        title: response.msg,
							    			        text: '',			        
							    			        confirmButtonColor: '#71D3BB',
							    			        customClass: { container: 'my-alert-container' }
							    			    }).then((result) => {
							    			    	document.reservationForm.submit()
							    			    });
							    			    
							    			    setTimeout(function() {
							    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
							    			    }, 10);
						        				
						        			} else if (response.code == -1) {
						        				alert(response.msg);
						        			} else if (response.code == -2) {
						        				alert(response.msg);
						        			}
						        		}
						        	});
						        	}, 100); // 약간의 딜레이를 주어 DOM 업데이트 완료 보장
						        	
						        });
						        
						        
						        
						    });
						</script>
					
					
					
					
					
					<div class="reservationDetailDiv" style="margin-top: 10px; padding-bottom: 10px; font-size: 12px; font-weight: bold; font-stretch: normal; line-height: 1.17; letter-spacing: normal; color: rgb(158, 164, 170); ">
						<span>인원 수</span>
					 	<div id="inputPeopleDiv">
					 		<span>이용 인원 수를 입력하세요</span>
					 		<div id="inputPeopleDropdownDiv">
						        <div id="inputTotalDiv">
						        	<span style="width: 75px; font-size: 14px; font-weight: bold; color: black;">총 인원 수</span>
						        	<div style="display: flex; align-items: center; justify-content: space-between; width: 140px;">
						        		<button id="btnPeopleMinus" class="btnPeopleMul" style="outline: none; cursor: pointer;"><img src="/resources/images/space/icon/btnMinus.svg"></button>
						        		<input id="inputPeopleCount" type="number" value=0 style="border: solid 1px #dfe2e7; border-radius: 4px; text-align: center; font-size: 16px; width: 70px; height: 40px; outline: none; ">
						        		<button id="btnPeoplePlus" class="btnPeopleMul" style="outline: none; cursor: pointer;"><img src="/resources/images/space/icon/btnPlus.svg"></button>
						        	</div>
						        </div>
						        <div id="inputPeopleRequestDiv">
						        	<div id="inputPeopleResetDiv"><span id="inputPeopleReset" style="cursor: pointer; color: #3b3e4d;">초기화</span></div>
						        	<div id="inputPeopleSubmitDiv"><span id="inputPeopleSubmit">완료</span></div>
						        </div>
						    </div>
						</div>
					</div>
					
					
					
					<!-- 인원 수 입력 div(dropdown) -->		
						<script>
						$(document).ready(function () {
				            // #inputPeopleDiv 클릭 시 드롭다운 보이기/숨기기
				            $("#inputPeopleDiv").on("click", function (e) {
				                $("#inputPeopleDropdownDiv").toggle();
				                e.stopPropagation(); // 클릭 이벤트 전파 중단 (드롭다운을 클릭해도 닫히지 않도록)
				            });
	
				            // #inputPeopleDropdownDiv 클릭 시 이벤트 전파 중단
				            $("#inputPeopleDropdownDiv").on("click", function (e) {
				                e.stopPropagation(); // 드롭다운 내부 클릭 시 이벤트 전파 중단
				            });
	
				            // 문서의 다른 부분 클릭 시 드롭다운 닫기
				            $(document).on("click", function (e) {
				                if (!$(e.target).closest("#inputPeopleDiv").length) {
				                    $("#inputPeopleDropdownDiv").hide();
				                }
				            });
				            
				            $("#inputPeopleReset").on("click", function() {
				                // #inputPeopleCount 값 초기화
				                $("#inputPeopleCount").val('0');
				            });
				            
				            $("#btnPeoplePlus").on("click", function() {
				                let curInputPeopleCount = parseInt($("#inputPeopleCount").val());
				                
				              	if(curInputPeopleCount < ${space.spaceMaxCapacity}) {
				              		$("#inputPeopleCount").val(curInputPeopleCount+1);
				            	} else {
				            		Swal.fire({
				    			        icon: 'warning',
				    			        title: "최대인원 "+${space.spaceMaxCapacity}+"명입니다.",
				    			        text: '',			        
				    			        confirmButtonColor: '#71D3BB',
				    			        customClass: { container: 'my-alert-container' }
				    			    });
				    			    
				    			    setTimeout(function() {
				    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
				    			    }, 10);
				            	}
				                
				            });
				            
				            $("#btnPeopleMinus").on("click", function() {
				                let curInputPeopleCount = parseInt($("#inputPeopleCount").val());
				                if(curInputPeopleCount > 0) {
				                	$("#inputPeopleCount").val(curInputPeopleCount-1);
				                }
				            });
				            
				            $("#inputPeopleSubmitDiv").on("click", function() {
				            	let curInputPeopleCount = parseInt($("#inputPeopleCount").val());
				            	
				            	
				            	$("#inputPeopleDiv").children('span').text("총 "+curInputPeopleCount+"명")
				            	$("#inputPeopleValue").val(curInputPeopleCount);
				            	$("#inputPeopleDiv").css("color","black");
				            	
				            	// 체크된 체크박스 값 가져오기
					            let checkedValues = [];
					            $('input[class="reservationTimeItem"]:checked').each(function() {
					                checkedValues.push($(this).val());
					            });
				            	
				            	if(${space.minReservationTime} <= checkedValues.length && $("#inputPeopleValue").val() > 0) {
					            	$(".reservationSubmitBtn").css("color", "white");
					            	$(".btnreservationDiv").css("background-color", "#36BC9B");
					            } else {
					            	$(".reservationSubmitBtn").css("color", "#9ea4aa");
					            }
				            	
				            	
				            	$("#inputPeopleDropdownDiv").hide();
				            });
				            
				        });
				    </script>
				    
				    <script>
				    $(document).ready(function () {
				        const reservationDiv = $("#reservationDiv");
				        const inputDateDiv = $("#inputDateDiv");
				        
				     	// #inputDateDiv 값 변경 감지
				        inputDateDiv.on("input change", function () {
				            if ($(this).text() || $(this).val()) {
				                // 값이 있을 경우 sticky로 복원
				                reservationDiv.css({
				                    position: "sticky",
				                    top: "150px", // sticky에서 사용할 top 값
				                    width: "", // 원래 상태로 복원
				                });
				            }
				        });

				        // #inputDateDiv 클릭 시 sticky를 absolute로 변경
				        inputDateDiv.on("click", function (e) {
				            // 현재 위치 계산
				            const rect = reservationDiv[0].getBoundingClientRect();
				            const currentTop = rect.top + window.scrollY - 640;

				            // absolute로 전환 및 고정
				            reservationDiv.css({
				                position: "absolute",
				                top: currentTop + "px",
				                width: reservationDiv.width() + "px", // 너비 유지
				            });

				            e.stopPropagation(); // 이벤트 전파 방지 (document 클릭 이벤트에 영향을 주지 않도록)
				        });

				        // 문서의 다른 부분 클릭 시 sticky로 복원
				        $(document).on("click", function (e) {
				            // #reservationDiv를 sticky로 복원
				            reservationDiv.css({
				                position: "sticky",
				                top: "150px", // sticky에서 사용할 top 값
				                width: "", // 원래 상태로 복원
				            });
				        });

				        // #inputDateDiv 안에서 클릭 이벤트 전파 방지
				        inputDateDiv.add("#reservationDate").on("click", function (e) {
				            e.stopPropagation();
				        });
				    });

				    </script>
					
					<div class="reservationDetailDiv" style="margin-top: 10px; display: flex; align-items: center; justify-content: space-between;">
						<div class="btnreservationDiv" style="width: 60%;">
							<span class="reservationSubmitBtn" style="font-weight: bold; font-size: 16px; line-height: 22px; text-align: center; letter-spacing: -0.1px; color: #9ea4aa;">예약 요청하기</span>
						</div>
						
						<div id="QnAWriteDiv2" class="btnQnADiv" style="width: 35%;">
							<span style="font-weight: bold; font-size: 16px; line-height: 22px; text-align: center; letter-spacing: -0.1px; color: rgb(27, 29, 31);">
								질문하기
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<button class="toTopBtn">
		<img src="/resources/images/space/icon/topButton.svg" />
	</button>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<script>
		$(".toTopBtn").on("click", function() {
	        $('html, body').animate({ scrollTop: 0 }, 500);
	    });
	
		let curPage = 1;
		let reviewSort = 1;
		
		function fn_review(curPage) {
			$.ajax({
				type: "GET",
				url: "/space/reviewList",
				data: {
					curPage: curPage,
					spaceId: "${space.spaceId}",
					reviewSort: reviewSort
				},
				datatype: "JSON",
				beforSend: function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success: function(resAjax) {
					let reviewList = resAjax.reviewList;
					let paging = resAjax.paging;
					let curPage = resAjax.curPage;
					reviewSort = resAjax.reviewSort;
					const loginEmail = "${loginEmail}";
					
					$("#reviewListBox").empty();
					$("#reviewPagingDiv").empty();
					
					reviewList.forEach(item => {
						console.log("게스트이메일 : " + item.guestEmail);
						console.log("로그인이메일 : " + loginEmail);
						let stars = ''; // 별점 HTML 생성
	                    for (let i = 0; i < 5; i++) {
	                        if (item.reviewScore > i) {
	                            stars += '<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">';
	                        } else {
	                            stars += '<img src="/resources/images/space/icon/starGray.svg" style="width:15px;">';
	                        }
	                    }
						
						if(item.status == "Y") {
							$("#reviewListBox").append(
								'<div class="reviewAllDiv">' +
									'<div class="contentDiv">' +
										'<div class="contentLeftDiv">' +
											'<div class="writerImg"><img src="/resources/images/guest/upload/' + item.guestEmail + '.png" onerror="this.onerror=null; this.src=\'/resources/images/guest/upload/profileNull.svg\';" /></div>' +
										'</div>' +
										
										'<div class="contentRightDiv">' +
											'<div class="writerDiv">' +
												'<span style="font-size: 18px; font-weight: bold;">' + item.guestNickname + '</span>' +
												(loginEmail != '' ? 
								                        '<div class="moreDiv">' +
								                            '<img src="/resources/images/space/icon/more.svg" data-reviewid="' + item.reviewId + '" data-loginemail="' + item.guestEmail + '">' +
								                        '</div>' : '' ) +
											'</div>' +
											
											'<div class="contentInfo">' +
												'<span style="margin-top: 5px;">' +
												stars +
												'</span>' +
												'<span class="infoDevider">' +
												"｜" +
												'</span>' +
												'<span style="font-size: 14px; color: rgb(174, 179, 184);">'+ item.regDate +'</span>' +
											'</div>' +
											
											'<div>' +
												'<p style="margin-top: 10px; margin-bottom: 0; overflow-wrap: break-word;" class="reviewContent'+ item.reviewId +'">' +
												item.reviewContent +
					       						'</p>' +
											'</div>' +	
										'</div>' +
										
									'</div>');
									
									if(item.reviewLikey != null) {
										$("#reviewListBox").append(
											'<div class="reviewLikeyBox" id="reviewLikeySelect" data-reviewid="'+item.reviewId+'" style="border-color: #00c292; color: #00c292">' +
										        '<span>도움돼요! </span>' +
										        '<span id="totalLikeyCnt">' + item.reviewLikeyCnt + '</span>' +
										    '</div>');
									} else {
										$("#reviewListBox").append(
											'<div class="reviewLikeyBox" id="reviewLikeySelect" data-reviewid="'+item.reviewId+'">' +
										        '<span>도움돼요! </span>' +
										        '<span id="totalLikeyCnt">' + item.reviewLikeyCnt + '</span>' +
											'</div>');
									}
									$("#reviewListBox").append('</div>');
									
									<!-- 리뷰1 응답(판매자) -->
									if(item.reviewReply.replyId != "") {
										if(item.reviewReply.status == "Y") {
											$("#reviewListBox").append(
												'<div class="contentDiv">' +
													'<div class="contentRightDiv" style="margin-top: 20px;">' +
														'<div class="replyContentDiv">' +
															'<div class="writerDiv">' +
																'<span style="font-size: 18px; font-weight: bold;">' + item.reviewReply.hostNickname + '</span>' +
															'</div>' +
															'<div id="replyRegDiv">' +
																'<span style="font-size: 14px; color: rgb(174, 179, 184);">' + item.reviewReply.regDate + '</span>' +
															'</div>' +
															'<p style="margin-top: 10px; margin-bottom: 0; overflow-wrap: break-word;">' +
															item.reviewReply.replyContent +
								       						'</p>' +
														'</div>' +
													'</div>' +
												'</div>'
											)											
										} else {
											$("#reviewListBox").append(
													'<div class="contentDiv">삭제된 답변입니다.</div>'
											)
										}
									};
									
								$("#reviewListBox").append(
										'</div>' +
										'<hr class="reviewHr">'
										);
						} else {
							$("#reviewListBox").append(
								'<div class="contentAllDiv">삭제된 리뷰입니다.</div>'
							)
						}
						
					});
					
					
					if(paging != null) {
						if(paging.prevBlockPage != 0) {
							$("#reviewPagingDiv").append('<button class="btnPaging reviewCurPage" data-page="'+paging.prevBlockPage+'"><</button>');
						}
						
						for(let i = paging.startPage; i <= paging.endPage; i++) {
							if(curPage != i) {
								$("#reviewPagingDiv").append('<button class="btnPaging" data-page="'+i+'">'+i+'</button>');
							} else {
								$("#reviewPagingDiv").append('<button class="btnPaging" data-page="'+i+'" style="color: #36BC9B;">'+i+'</button>');
							}
						}
						
						if(paging.nextBlockPage != 0) {
							$("#reviewPagingDiv").append('<button class="btnPaging reviewCurPage" data-page="'+paging.nextBlockPage+'">></button>');
						}
					}
					
					$("#reviewCntTagId").text(resAjax.totalReviewCntY);
				},
				error: function(xhr, status, error) {
					console.log("에러####@@@@");
				}
			});
		};
			
			
		$("#reviewPagingDiv").on("click", ".btnPaging", function() {
	        let page = $(this).data("page");
	        fn_review(page);
	    });
		
		
	    const sortButtons = document.querySelectorAll(".btnReviewSort");

	    sortButtons.forEach(button => {
	        button.addEventListener("click", function () {
	            // 모든 버튼에서 active 클래스 제거
	            sortButtons.forEach(btn => btn.classList.remove("active"));
	            
	            // 클릭한 버튼에 active 클래스 추가
	            this.classList.add("active");
	            reviewSort = this.value;
	            fn_review();
	        });
	    });
	    
	    // 처음 페이지 로드될 때 reviewList 출력
		fn_review();
	    
	    //
	    
	    //
		
		const stickyHeight = $('#spaceViewTap').outerHeight(); // Sticky 메뉴 높이 계산
		const headerHeight = $('header').outerHeight(); // 헤더 높이 계산
		const totalOffset = headerHeight + stickyHeight; // 전체 오프셋 (헤더 + 스티키 메뉴 높이)
	
		// 버튼 클릭 시 스크롤 이동
		$('.btnTab').on('click', function() {
			const target = $($(this).data('target')); // data-target 속성 참조
			if (target.length) {
				const targetOffset = target.offset().top - totalOffset; // 스크롤 위치 계산
				$('html, body').animate({
					scrollTop : targetOffset
				}, 500); // 부드러운 스크롤
			}
		});
	
		// 스크롤 이벤트로 현재 섹션 확인 후 active 클래스 변경
		const sections = $('#spaceContentLeftDiv > div'); // 섹션들 선택
		$(window).on('scroll', function() {
			const scrollPosition = $(window).scrollTop(); // 현재 스크롤 위치
	
			let activeSection = null; // 활성화된 섹션을 추적하기 위한 변수
	
			// 각 섹션을 반복하면서 현재 섹션 찾기
			sections.each(function() {
				const sectionTop = $(this).offset().top
						- totalOffset; // 섹션 상단 위치
				const sectionBottom = sectionTop
						+ $(this).outerHeight(); // 섹션 하단 위치
				const sectionId = $(this).attr('id'); // 섹션 ID
	
				// 스크롤 위치가 섹션의 상단과 하단 사이에 있을 때만
				if (scrollPosition >= sectionTop
						&& scrollPosition < sectionBottom) {
					activeSection = sectionId; // 활성화된 섹션을 추적
				}
			});
	
			// 활성화된 섹션에 맞는 버튼에 active 클래스 추가
			if (activeSection) {
				// 모든 버튼의 active 클래스 제거
				$('.btnTab').removeClass('active');
	
				// 현재 섹션에 해당하는 버튼에 active 클래스 추가
	
				const target = "#" + activeSection
				const activeButton = $(".btnTab[data-target='"
						+ target + "']");
				activeButton.addClass('active'); // 버튼에 active 클래스 추가
			}
		});
		// 페이지 로드 후 스크롤 위치에 맞는 버튼 활성화
		$(window).trigger('scroll'); // 페이지 로드 후 초기화
		
		$("body").on("click", ".moreDiv", function (e) {
			let reviewId = e.target.dataset.reviewid;
			let loginEmail = e.target.dataset.loginemail;
			
    		// 기존 메뉴 제거
		    $(".actionMenu").remove();
		
		    // 클릭한 `moreDiv` 아래에 메뉴 동적 생성
		    const menu = $(`
		        <div class="actionMenu">
		    `);
		    
		    if("${loginEmail}" != loginEmail) {
		    	menu.append(`
			            	<button class="reportBtn" style="color: red;" data-reviewid="\${reviewId}">신고</button>
			            </div>
			            `);
		    } else {
		    	menu.append(`
			            <button class="editBtn" id="rvUpdateWriteDiv" data-reviewid="\${reviewId}">수정</button>
			            <button class="deleteBtn" id="rvDeleteBtn" data-reviewid="\${reviewId}">삭제</button>
			        </div>
			    `);
		    }
		
		    // 클릭한 요소의 위치 계산
		    const offset = $(this).offset();
		
		    // 메뉴 위치 설정
		    menu.css({
		        top: offset.top + $(this).outerHeight(), // 클릭한 `moreDiv` 아래쪽
		        left: offset.left,                      // `moreDiv`의 왼쪽 정렬
		    });
		
		    // 메뉴 추가 및 표시
		    $("body").append(menu);
		    menu.show();
		
		    // 메뉴 외부 클릭 시 닫기
		    $(document).on("click", function (e) {
		        if (!$(e.target).closest(".moreDiv, .actionMenu").length) {
		            $(".actionMenu").remove();
		        }
		    });
		});
		
		$("body").on("click", ".reportBtn", function(e) {
			let reviewId = e.target.dataset.reviewid;
			
			let reportModal = $(`
					<div class="darkModalBackground">
			        <div class="modalBox">
			            <div class="reportAlertText">
			                <p>이 문의/답변을 신고하시는 이유를 알려주세요.<br/> 신고가 접수되면 SpaceUp에서 확인할 예정입니다.<br/> 내용은 상대방에게 공개되지 않습니다.</p>
			            </div>
			            <textarea id="reportReason"></textarea>
			            <div class="reportBtnBox">
			                <button class="reportSubmit" data-reviewid="\${reviewId}">작성</button>
			                <button class="reportClose">닫기</button>
			            </div>
			        </div>
			    </div>
			`);
			
			$(".view").prepend(reportModal);
		});

		
		$("body").on("click", ".reportClose", function() {
			$(".darkModalBackground").remove();
		});
		
		$("body").on("click", ".reportSubmit", function(e) {
			let reviewId = e.target.dataset.reviewid;
			
			$.ajax({
				type: "POST",
				url: "/space/reviewReport",
				data: {
					spaceId: ${space.spaceId},
					reportReason: $("#reportReason").val(),
					reviewId: reviewId
				},
				datatype: "JSON",
				success: function(response) {
					if(response.code == 0) {
						alert(response.msg);
						$(".darkModalBackground").remove();
					} else if(response.code == -1) {
						alert(response.msg);
						location.href = "/space/spaceList";
					} else if(response.code == -2) {
						alert(response.msg);
					}
				}
			});
		});
		
		$("body").on("click", "#rvDeleteBtn", function(e) {
			$(".actionMenu").remove();
			if(confirm("삭제하시겠습니까?")) {
				$.ajax({
					type: "POST",
					url: "/space/reviewDelete",
					data: {
						reviewId: e.target.dataset.reviewid
					},
					datatype: "JSON",
					success: function(response) {
						if(response.code == 0) {
							Swal.fire({
		    			        icon: 'success',
		    			        title: '리뷰가 삭제되었습니다.',
		    			        text: '',			        
		    			        confirmButtonColor: '#71D3BB',
		    			        customClass: { container: 'my-alert-container' }
		    			    });
		    			    
		    			    setTimeout(function() {
		    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
		    			    }, 10);
						} else if(response.code == -1) {
							alert(response.msg);
						} else if(response.code == -2) {
							alert(response.msg);
						}
					},
					complete: function() {
						fn_review();
					}
				});
			}
		});
		
		// spaceView 상단 이미지 리스트
		const imageList = [
			<c:forEach var="spaceImgName" items="${spaceImgNames}">
		    	'http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${space.spaceType}/${space.spaceId}/${spaceImgName}', // 이미지 경로들
		    </c:forEach>
		];
	
	
		let currentImageIndex = 0; // 현재 보여지는 이미지 인덱스
	
		// 이미지 뷰어 열기 함수
		function fn_showImgList(index) {
			currentImageIndex = index;
			
		    // 전체 화면 이미지 뷰어 보이기
		    $('#fullImageView').css('display', 'flex'); // 보이도록 설정
	
		    // 휠 스크롤 비활성화
		    $('body').css('overflow', 'hidden');
	
		    // 첫 번째 이미지 로드
		    loadImage(currentImageIndex);
	
		    // 배경 클릭 시 이미지 뷰어 닫기
		    $('#fullImageView').on('click', function (e) {
		        if (e.target === this) {
		            $('#fullImageView').css('display', 'none'); // 닫기
		            $('body').css('overflow', 'auto');
		        }
		    });
	
		    // 닫기 버튼 클릭 시 이미지 뷰어 닫기
		    $('#closeBtn').on('click', function () {
		        $('#fullImageView').css('display', 'none'); // 닫기
		        $('body').css('overflow', 'auto');
		    });
	
		    // 이전 버튼 클릭 시
		    $('#prevBtn').on('click', function (e) {
		        e.stopPropagation(); // 이벤트 버블링 방지
		        currentImageIndex = (currentImageIndex > 0) ? currentImageIndex - 1 : imageList.length - 1;
		        loadImage(currentImageIndex);
		    });
	
		    // 다음 버튼 클릭 시
		    $('#nextBtn').on('click', function (e) {
		        e.stopPropagation(); // 이벤트 버블링 방지
		        currentImageIndex = (currentImageIndex < imageList.length - 1) ? currentImageIndex + 1 : 0;
		        loadImage(currentImageIndex);
		    });
		}
	
		// 이미지 로드 함수
		function loadImage(index) {
		    $('#viewedImage').attr('src', imageList[index]);
		}
		
		// spaceQuestion 기능
		let qnaCurPage = 1;
		
		function fn_question(curPage) {
			$.ajax({
				type: "GET",
				url: "/space/spaceQuestionList",
				data: {
					curPage: curPage,
					spaceId: "${space.spaceId}",
				},
				datatype: "JSON",
				beforSend: function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success: function(resAjax) {
					let sQList = resAjax.sQList;
					let paging = resAjax.paging;
					let curPage = resAjax.curPage;
					
					const loginEmail = "${loginEmail}";
					
					$("#qnaListBox").empty();
					$("#qnaPagingDiv").empty();
					
					sQList.forEach(item => {
						
						if(item.status == "Y") {
							$("#qnaListBox").append(
								'<div class="contentAllDiv">' +
									'<div class="contentDiv">' +
										'<div class="contentLeftDiv">' +
										'<div class="writerImg"><img src="/resources/images/guest/upload/' + item.guestEmail + '.png" onerror="this.onerror=null; this.src=\'/resources/images/guest/upload/profileNull.svg\';" /></div>' +
										'</div>' +
										
										'<div class="contentRightDiv">' +
											'<div class="writerDiv">' +
												'<span style="font-size: 18px; font-weight: bold;">' + item.guestNickname + '</span>' +
												(item.guestEmail == loginEmail ? 
								                        '<div class="sQMoreDiv">' +
								                            '<img src="/resources/images/space/icon/more.svg" data-spacequestionid="' + item.spaceQuestionId + '" data-questioncategory="' + item.questionCategory + '">' +
								                        '</div>' : 
								                        '') +
											'</div>' +
											
											'<div>' +
												'<span>' +
												'</span>' +
												'<span style="font-size: 14px; color: rgb(174, 179, 184);">'+ item.regDate +'</span>' +
											'</div>' +
											
											'<div>' +
												'<p style="margin-top: 10px; margin-bottom: 0; width: 90%; overflow-wrap: break-word;" class="qnaContent'+ item.spaceQuestionId +'">' +
												item.questionContent +
					       						'</p>' +
											'</div>' +	
										'</div>' +
									'</div>');
							
									<!-- 리뷰1 응답(판매자) -->
									if(item.spaceAnswer != null) {
										if(item.spaceAnswer.status == "Y") {
											$("#qnaListBox").append(
												'<div class="contentDiv">' +
													'<div class="contentRightDiv" style="margin-top: 20px;">' +
														'<div class="replyContentDiv">' +
															'<div class="writerDiv2">' +
																'<span style="margin-right: 5px;">' +
																"└" +
																'</span>' +
																'<img src="/resources/images/space/icon/answer.svg" />' +
																'<span style="font-size: 18px; font-weight: bold;">' + item.spaceAnswer.hostNickname + '</span>' +
															'</div>' +
															'<div id="replyRegDiv">' +
																'<span style="font-size: 14px; color: rgb(174, 179, 184);">' + item.spaceAnswer.regDate + '</span>' +
															'</div>' +
															'<p style="margin-top: 10px; margin-bottom: 0; margin-left: 15px; width: 90%; overflow-wrap: break-word;">' +
															item.spaceAnswer.answerContent +
								       						'</p>' +
														'</div>' +
													'</div>' +
												'</div>'
											)											
										} else {
											$("#qnaListBox").append(
												'<div class="contentDiv">삭제된 답변입니다.</div>'
											)
										}
									};
									
								$("#qnaListBox").append(
										'</div>' +
										'<hr class="reviewHr">'
										);
						} else {
							$("#qnaListBox").append(
								'<div class="contentAllDiv">삭제된 질문입니다.</div>'
							)
						}
						
					});
					
					
					if(paging != null) {
						if(paging.prevBlockPage != 0) {
							$("#qnaPagingDiv").append('<button class="btnPaging reviewCurPage" data-page="'+paging.prevBlockPage+'"><</button>');
						}
						
						for(let i = paging.startPage; i <= paging.endPage; i++) {
							if(curPage != i) {
								$("#qnaPagingDiv").append('<button class="btnPaging" data-page="'+i+'">'+i+'</button>');
							} else {
								$("#qnaPagingDiv").append('<button class="btnPaging" data-page="'+i+'" style="color: #36BC9B;">'+i+'</button>');
							}
						}
						
						if(paging.nextBlockPage != 0) {
							$("#qnaPagingDiv").append('<button class="btnPaging reviewCurPage" data-page="'+paging.nextBlockPage+'">></button>');
						}
					}
					
					$("#QnACntTagId").text(resAjax.sQTotalCntY);
				},
				error: function(xhr, status, error) {
					console.log("에러####@@@@");
				}
			});
		};
			
			
		$("#qnaPagingDiv").on("click", ".btnPaging", function() {
	        let page = $(this).data("page");
	        fn_question(page);
	    });
	    
	    // 처음 페이지 로드될 때 QnAList 출력
		fn_question();
		
		$("body").on("click", ".sQMoreDiv", function (e) {
			let spaceQuestionId = e.target.dataset.spacequestionid;
			let questionCategory = e.target.dataset.questioncategory;
			
    		// 기존 메뉴 제거
		    $(".actionMenu").remove();
		
		    // 클릭한 `moreDiv` 아래에 메뉴 동적 생성
		    const menu = $(`
		        <div class="sQactionMenu">
		            <button class="editBtn" id="qnaUpdateWriteDiv" data-spacequestionid="\${spaceQuestionId}" data-questioncategory="\${questionCategory}">수정</button>
		            <button class="deleteBtn" id="qnaDeleteBtn" data-spacequestionid="\${spaceQuestionId}">삭제</button>
		        </div>
		    `);
		
		    // 클릭한 요소의 위치 계산
		    const offset = $(this).offset();
		
		    // 메뉴 위치 설정
		    menu.css({
		        top: offset.top + $(this).outerHeight(), // 클릭한 `moreDiv` 아래쪽
		        left: offset.left,                      // `moreDiv`의 왼쪽 정렬
		    });
		
		    // 메뉴 추가 및 표시
		    $("body").append(menu);
		    menu.show();
		
		    // 메뉴 외부 클릭 시 닫기
		    $(document).on("click", function (e) {
		        if (!$(e.target).closest(".sQMoreDiv, .sQactionMenu").length) {
		            $(".sQactionMenu").remove();
		        }
		    });
		});
		
		
		
		
		
		
		
		$("body").on("click", "#qnaDeleteBtn", function(e) {
			$(".actionMenu").remove();
			if(confirm("삭제하시겠습니까?")) {
				$.ajax({
					type: "POST",
					url: "/space/questionDelete",
					data: {
						spaceQuestionId: e.target.dataset.spacequestionid
					},
					datatype: "JSON",
					success: function(response) {
						if(response.code == 0) {
							Swal.fire({
		    			        icon: 'success',
		    			        title: '문의가 삭제되었습니다.',
		    			        text: '',			        
		    			        confirmButtonColor: '#71D3BB',
		    			        customClass: { container: 'my-alert-container' }
		    			    });
		    			    
		    			    setTimeout(function() {
		    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
		    			    }, 10);
						} else if(response.code == -1) {
							alert(response.msg);
						} else if(response.code == -2) {
							alert(response.msg);
						}
					},
					complete: function() {
						$(".sQactionMenu").remove();
						fn_question();
					}
				});
			}
		});
		
		$("body").on("click", "#reviewLikeySelect", function(e) {
			$.ajax({
				type: "GET",
				url: "/space/reviewLikeySelect",
				data: {
					reviewId: e.currentTarget.dataset.reviewid
				},
				datatype: "JSON",
				success: function(response) {
					if(response.code == -1) {
						//alert(response.msg);
					} else if(response.code == 400) {
						//alert(response.msg);
						location.href = "/guest/loginForm";
					} else {
						//alert(response.msg);
					}
					fn_review();
				}, error: function() {
					console.log("reviewLikey Ajax error");
				}
			});
		});
		
	</script>
	
	
</body>
</html>




















































