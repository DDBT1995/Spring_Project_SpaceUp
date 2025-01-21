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
	$(document).ready(function() {
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
		
		$(".moreDiv").on("click", function (e) {
    		// 기존 메뉴 제거
		    $(".actionMenu").remove();
		
		    // 클릭한 `moreDiv` 아래에 메뉴 동적 생성
		    const menu = $(`
		        <div class="actionMenu">
		            <button class="reportBtn" style="color: red;">신고</button>
		            <button class="editBtn">수정</button>
		            <button class="deleteBtn">삭제</button>
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
		        if (!$(e.target).closest(".moreDiv, .actionMenu").length) {
		            $(".actionMenu").remove();
		        }
		    });
		});
	});
</script>
</head>
<body class="view">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div id="spaceViewContainer">

		<!-- 상단 공간 이미지 -->
		<div id="spaceImgDiv">
			<div id="spaceImgDivLeft">
				<div class="thumnailDiv">
					<button class="btnShowImg" onclick="fn_showImgList(0)">
						<img alt="" src="/resources/images/space/spaceId/1.jpg">
					</button>
				</div>
			</div>

			<div id="spaceImgDivRight">
				<div class="noThumnailDiv">
					<button class="btnShowImg" onclick="fn_showImgList(1)">
						<img alt="" src="/resources/images/space/spaceId/2.jpg">
					</button>
				</div>

				<div class="noThumnailDiv">
					<button class="btnShowImg" onclick="fn_showImgList(2)">
						<img alt="" src="/resources/images/space/spaceId/3.jpg">
					</button>
				</div>

				<div class="noThumnailDiv">
					<button class="btnShowImg" onclick="fn_showImgList(3)">
						<img alt="" src="/resources/images/space/spaceId/4.jpg">
					</button>
				</div>

				<div class="noThumnailDiv">
					<button class="btnShowImg" onclick="fn_showImgList(4)">
						<img alt="" src="/resources/images/space/spaceId/5.jpg">
					</button>
					<button id="moreImgDiv" onclick="fn_showImgList(0)">
						+2
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
					
					
					<script type="text/javascript">
						const imageList = [
						    '/resources/images/space/spaceId/1.jpg', // 이미지 경로들
						    '/resources/images/space/spaceId/2.jpg', // 이미지 경로들
						    '/resources/images/space/spaceId/3.jpg', // 이미지 경로들
						    '/resources/images/space/spaceId/4.jpg', // 이미지 경로들
						    '/resources/images/space/spaceId/5.jpg', // 이미지 경로들
						    '/resources/images/space/spaceId/6.jpg', // 이미지 경로들
						    '/resources/images/space/spaceId/7.jpg', // 이미지 경로들
						    
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
					</script>
					
					
					
				</div>
			</div>
		</div>
		<!-- 컨텐츠, 예약 공간 -->
		<div id="spaceContentDiv">
			<div id="spaceContentLeftDiv">
				<div id="spaceInfoDiv">
					<a><span id="hostName">쌍용강북아카데미(호스트이름)</span></a>
					<div id="spaceNameDiv">
						<h1 id="spaceName">2층 A강의실(공간 이름)</h1>
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
						<img id="addrIcon" alt="" src="/resources/images/space/icon/addr.svg">&nbsp; 주소 서울시 마포구 어쩌구 123-1 2층 A강의실
					</p>
					<div id="reviewInfoDiv">
						<div id="starRatingDiv">
							<!-- 별점에 따라 별 찍어주기 -->
							<img src="/resources/images/space/icon/starGray.svg" width="17"> <img src="/resources/images/space/icon/starGray.svg" width="17"> <img src="/resources/images/space/icon/starGray.svg" width="17"> <img src="/resources/images/space/icon/starGray.svg" width="17"> <img src="/resources/images/space/icon/starGray.svg" width="17">
						</div>
						&nbsp; <span id="starScore">0.0</span> &nbsp;&nbsp;<span style="color: rgba(61, 61, 61, 0.2);">|</span>&nbsp;&nbsp; <span id="reviewCount">리뷰(0)</span>
					</div>
				</div>

				<div id="spaceViewTap">
					<button class="btnTab" data-target="#spaceDetail">공간정보</button>
					<button class="btnTab" data-target="#spaceNotes">주의사항</button>
					
					<button class="btnTab" data-target="#spaceReview">
						리뷰
						<!-- 후기 갯수 -->
						<span class="tabDetail">0</span>
					</button>
					<button class="btnTab" data-target="#spaceQnA">
						문의
						<!-- 공간QnA 갯수 -->
						<span class="tabDetail">0</span>
					</button>
					<button class="btnTab" data-target="#spaceRefund">환불규정</button>
				</div>

				<div id="spaceDetail">

					<div id="spaceDescDiv">
						<span style="font-size: 24px; font-weight: bold;">공간정보</span>
						<!-- 공간소개DB -->
						<p>아더공간: 특별한 모임과 이벤트를 위한 프라이빗 공간<br><br>아더공간은 인천 남동구에 위치한 아늑한 우드 인테리어의 프라이빗 공간으로, 다양한 모임, 기념일, 이벤트를 위한 최적의 장소입니다. <br>따뜻하고 감각적인 분위기 속에서 소중한 사람들과 특별한 시간을 보낼 수 있도록 세심하게 준비된 공간입니다.<br><br>주요 특징 및 어필 포인트<br><br>다양한 모임과 이벤트에 적합한 공간<br>아더공간은 소규모 모임부터 특별한 기념일까지, 다양한 이벤트를 위한 장소로 활용 가능합니다.<br><br>생일 및 기념일 파티: 특별한 날을 더욱 특별하게.<br>프라이빗 이벤트: 송년회, 회식, 소규모 축하 행사 등.<br>가족 및 친구 모임: 따뜻하고 아늑한 분위기에서 즐기는 프라이빗한 모임.<br>커플 이색 데이트: 요리와 보드게임, 불멍까지 즐길 수 있는 색다른 데이트 코스.<br><br>아늑하고 프라이빗한 공간<br>크기: 약 10평의 프라이빗 독립 공간으로 최대 8명까지 수용 가능.<br>따뜻한 우드 인테리어와 아늑한 분위기가 돋보이며, 외부 방해 없이 온전히 시간을 즐길 수 있습니다.<br><br>풍성한 무료 제공 서비스<br>간식 및 기본 음식: 라면, 시리얼, 우유 등 기본 간식 제공.<br>보드게임 16종: 다양한 게임으로 모임 분위기를 즐겁게 만듭니다.<br>블루투스 스피커 및 불멍 기능: 분위기를 살려주는 필수 아이템.<br><br>편리한 접근성과 부대시설<br>주차 공간: 공간 앞 2대 주차 가능, 인근 맥도날드 주차장도 추가 이용 가능.<br>장보기 편리함: 대형 식자재 마트와 모래내시장이 근처에 있어, 필요한 재료를 쉽게 준비할 수 있습니다.<br>음료 및 주류 반입 가능: 외부 음식과 음료를 자유롭게 반입하여 원하는 파티 스타일로 꾸밀 수 있습니다.<br><br>안전하고 편안한 환경<br>슬리퍼 착용 필수로 쾌적한 공간 유지.<br>CCTV 운영으로 안전하고 편안한 이용 보장.<br><br>추천 이유<br>“소중한 사람들과 특별한 순간을 만들고 싶다면 아더공간이 딱입니다!”<br><br>파티, 기념일, 소규모 이벤트를 위한 아늑한 공간.<br>공간 자체가 주는 따뜻한 분위기와 풍부한 무료 서비스로, 만족스러운 모임을 보장합니다.<br><br>영업 정보 및 예약 안내<br>영업시간: 24시간 운영 (휴무일 없음)<br>주차: 2대 가능 (추가 주차는 맥도날드 주차장 이용 가능)<br><br>아워플레이스를 통해 아더공간을 예약하고, 특별한 날을 더 특별하게 만들어 보세요!</p>
					</div>

					<div id="spaceTipDiv">
						<span style="font-size: 24px; font-weight: bold;">공간 이용 TIP</span>
						<p>패키지 상품 외 시간대 예약을 희망하실 경우, 문자 연락부탁드립니다.</p>
						<div id="spaceOptionDiv">
							<div id="spaceMaxCapacityDiv">
								<img src="/resources/images/space/icon/maxCapacity.svg" style="width: 32px; height: 32px;">
								<!-- 최대 인원 수(DB) -->
								<p>최대 10명</p>
							</div>
							<div id="spaceParkingDiv">
								<img src="/resources/images/space/icon/parking.svg" style="width: 32px; height: 32px;">
								<!-- 주차 가능 차량 수DB) -->
								<p>주차 2대 가능</p>
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
								var address = "서울 마포구 동교로15길 7 서교동주민자치회";

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
							<img id="addrIcon" alt="" src="/resources/images/space/icon/addr.svg">&nbsp; 주소 서울시 마포구 어쩌구 123-1 2층 A강의실
						</p>
					</div>
				</div>


				<div id="spaceNotes">
					<span style="font-size: 24px; font-weight: bold;">주의사항</span>
					<p>
						[시간 엄수]<br>- 계약된 시간을 꼭 준수하여 주시기 바랍니다.  <br>- 이용요금은 [시작 시간] 및 [종료 시간]으로 계약됩니다.<br>- 촬영 준비 및 세팅, 장비 철수 및 장소 원상복구 시간은 계약 시간에 포함 되어있습니다.<br>- 계약된 촬영 시간을 초과할 경우 호스트가 추가결제를 요청할 수 있습니다.<br><br>[파손 주의]<br>삼각대, 조명, 철제박스, 감독 의자, 기타 장비로 인한 나무 바닥과 벽지 파손에 꼭 주의해주세요.<br>- 준비물 : 간단한 돗자리나 모포, 테니스공을 준비해서 장비 밑에 꼭 깔아 놓아주세요.<br>- 파손 시 : 현장에서 함께 확인 &gt; 사진 촬영 &gt; 견적 확인 후, 배상 요청을 진행하게 됩니다.<br><br>[스탭 인원]<br>설정한 최대 스탭 인원이 지켜지지 않을 경우, 호스트가 촬영을 취소하거나 추가결제를 요청할 수 있습니다.<br><br>[취식 금지]<br>공간에서 취식은 항상 금지되어있습니다. 부득이한 경우 호스트에게 먼저 양해를 꼭 구해주세요.<br><br>[에티켓]<br>- 주변 주민들을 위해 기본 에티켓을 지켜주세요.<br>- 주변 야외 촬영은 불가능합니다.<br>- 촬영 도중 발생한 쓰레기는 모두 정리해주셔야 합니다.<br>- 주차는 안내된 주차대수만 제공됩니다.<br>- 기존의 가구 세팅 및 구조를 필요에 의해 변경하신 경우 마감 시간 전에 원상복구 해주셔야 합니다.
					</p>
				</div>
				

				<div id="spaceReview">
					<div class="headerDiv">
						<div class="headerLeftDiv">
							<span style="font-size: 24px; font-weight: bold;">리뷰</span>
							&nbsp;
							<span style="font-size: 24px; font-weight: bold; color: #36BC9B;">10</span>
						</div>
						
						<div class="headerRightDiv">
							<button class="btnReviewSort active" id="btnSortByLikey">추천순</button>
							<button class="btnReviewSort" id="btnSortByNew">최신순</button>
							<script type="text/javascript">
								document.addEventListener("DOMContentLoaded", function () {
								    const sortButtons = document.querySelectorAll(".btnReviewSort");
	
								    sortButtons.forEach(button => {
								        button.addEventListener("click", function () {
								            // 모든 버튼에서 active 클래스 제거
								            sortButtons.forEach(btn => btn.classList.remove("active"));
								            
								            // 클릭한 버튼에 active 클래스 추가
								            this.classList.add("active");
	
								            <!-- 선택된 정렬 방식 출력 (필요한 경우)
								            if (this.id === "btnSortByLikey") {
								                console.log("추천순으로 정렬");
								            } else if (this.id === "btnSortByNew") {
								                console.log("최신순으로 정렬");
								            }
								            -->
								        });
								    });
								});
							</script>
						</div>
					</div>
					
					<!-- 리뷰1 -->
					<div class="contentAllDiv">
						<!-- 리뷰1(작성자) -->
						<div class="contentDiv">
							<div class="contentLeftDiv">
								<div class="writerImg"></div>
							</div>
							
							<div class="contentRightDiv">
								<div class="writerDiv">
									<span style="font-size: 18px; font-weight: bold;">리뷰 작성자 닉네임(DB)</span>
									<div class="moreDiv">
										<img src="/resources/images/space/icon/more.svg">
									</div>
								</div>
								
								<div>
									<span>
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
									</span>
									<span style="font-size: 14px; color: rgb(174, 179, 184);">2024.11.28</span>
								</div>
								
								<div>
									<p style="margin-top: 10px; margin-bottom: 0;">
										응답 엄청 빠르시고요. 냉장고가 매우 크고 청소 상태도 양호해요. 다만 저희가 못 찾았는지 설거지 하는데 온수가 나오지 않아 찬물로 설거지하느라 힘들었어요. 보일러에 건전지 표시같은게 들어오던데 그래서 그런건지 모르겠어요. 
										공간도 넓고 계단도 생각보다는 덜 가파르고 손잡이도 있어서 잘 놀고 왔습니다. 저희는 재방문 의사 1000%입니다. 
		       						</p>
								</div>	
							</div>
						</div>
						
						<!-- 리뷰1 응답(판매자) -->
						<div class="contentDiv">
							<div class="contentLeftDiv">
							</div>
							<div class="contentRightDiv" style="margin-top: 20px;">
								<div class="replyContentDiv">
									<div class="writerDiv">
										<span style="font-size: 18px; font-weight: bold;">호스트 닉네임(DB)</span>
									</div>
									<div id="replyRegDiv">
										<span style="font-size: 14px; color: rgb(174, 179, 184);">2024.11.28</span>
									</div>
									<p style="margin-top: 10px; margin-bottom: 0;">
										소중한 후기 감사드립니다🥰 날씨도 한몫해주어 정말다행이였어요. 만족스러운 촬영이셨길 바랍니다🍀🍀
		       						</p>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 리뷰2 -->
					<div class="contentAllDiv">
						<!-- 리뷰2(구매자) -->
						<div class="contentDiv">
							<div class="contentLeftDiv">
								<div class="writerImg"></div>
							</div>
							
							<div class="contentRightDiv">
								<div class="writerDiv">
									<span style="font-size: 18px; font-weight: bold;">리뷰 작성자 닉네임(DB)</span>
									<div class="moreDiv">
										<img src="/resources/images/space/icon/more.svg">
									</div>
								</div>
								
								<div>
									<span>
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
										<img src="/resources/images/space/icon/starYellow.svg" style="width:15px;">
									</span>
									<span style="font-size: 14px; color: rgb(174, 179, 184);">2024.11.28</span>
								</div>
								
								<div>
									<p style="margin-top: 10px; margin-bottom: 0;">
										응답 엄청 빠르시고요. 냉장고가 매우 크고 청소 상태도 양호해요. 다만 저희가 못 찾았는지 설거지 하는데 온수가 나오지 않아 찬물로 설거지하느라 힘들었어요. 보일러에 건전지 표시같은게 들어오던데 그래서 그런건지 모르겠어요. 
										공간도 넓고 계단도 생각보다는 덜 가파르고 손잡이도 있어서 잘 놀고 왔습니다. 저희는 재방문 의사 1000%입니다. 
		       						</p>
								</div>
							</div>
						</div>
					</div>
					<div id="pagingDiv">
						<button class="btnPaging" style="color: #36BC9B;">1</button>
						<button class="btnPaging">2</button>
						<button class="btnPaging">3</button>
						<button class="btnPaging">4</button>
						<button class="btnPaging">5</button>
					</div>
				</div>

				<div id="spaceQnA">
					<div class="headerDiv">
						<div class="headerLeftDiv">
							<span style="font-size: 24px; font-weight: bold;">문의</span>
							&nbsp;
							<span style="font-size: 24px; font-weight: bold; color: #36BC9B;">5</span>
						</div>
						
						<div class="headerRightDiv">
							<div id="QnAWriteDiv">
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
						        
						        <div id="QnAContentHeaderDiv">
						        	<div>
						        		<span>내용</span>
						        	</div>
						        	<div>
						        		<span id="inputQuestionCount">0</span><span>/200자</span>
						        	</div>
						        </div>
						        
						        <div id="QnAContentDiv">
						        	<textarea maxlength="200" placeholder="질문을 작성하기 전에 확인해주세요!&#10;&#10;・ 장소에 대해 궁금한 점을 호스트에게 문의하는 공간이에요.&#10;・ 질문은 공개 상태로만 등록할 수 있어요.&#10;・ 개인정보를 공유 또는 요구하거나 아워플레이스를 통하지 않은 직거래 유도, 비방/욕설/명예훼손성 글을 등록하면 사전에 고지 없이 삭제 조치 될 수 있으며 서비스 이용에 제약이 있을 수 있습니다." style=" font-size: 14px; border: none; outline: none; width: 100%; resize: none;" ></textarea>
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
							});
						</script>
					</div>
					
					<!-- QnA1 -->
					<div class="contentAllDiv">
						<!-- QnA 질문(게스트) -->
						<div class="contentDiv">
							<div class="contentLeftDiv">
								<div class="writerImg"></div>
							</div>
							
							<div class="contentRightDiv">
								<div class="writerDiv">
									<span style="font-size: 18px; font-weight: bold;">QnA 작성자 닉네임(DB)</span>
								</div>
								<div>
									<span style="font-size: 14px; color: rgb(174, 179, 184);">2024.11.28</span>
								</div>
								
								<div>
									<p style="margin-top: 10px; margin-bottom: 0;">
										빠른 확인 감사드립니다 호스트님~~!
										이번 주 목요일 예약 예정인 점 미리 말씀드립니다 ^^ 확인 후 예약 진행하겠습니다 !
										감사합니다 !
									</p>
								</div>
							</div>
						</div>
						<!-- QnA1 호스트 -->
						<div class="contentDiv">
							<div class="contentLeftDiv">
							</div>
							<div class="contentRightDiv" style="margin-top: 20px;">
								<div class="replyContentDiv">
									<div class="writerDiv">
										<span style="font-size: 18px; font-weight: bold;">호스트 닉네임(DB)</span>
									</div>
									<div id="replyRegDiv">
										<span style="font-size: 14px; color: rgb(174, 179, 184);">2024.11.28</span>
									</div>
									<p style="margin-top: 10px; margin-bottom: 0;">
										소중한 후기 감사드립니다🥰 날씨도 한몫해주어 정말다행이였어요. 만족스러운 촬영이셨길 바랍니다🍀🍀
		       						</p>
								</div>
							</div>
						</div>
					</div>
					
					<!-- QnA2 -->
					<div class="contentAllDiv">
						<!-- QnA2 질문(게스트) -->
						<div class="contentDiv">
							<div class="contentLeftDiv">
								<div class="writerImg"></div>
							</div>
							
							<div class="contentRightDiv">
								<div class="writerDiv">
									<span style="font-size: 18px; font-weight: bold;">QnA 작성자 닉네임(DB)</span>
								</div>
								<div>
									<span style="font-size: 14px; color: rgb(174, 179, 184);">2024.11.28</span>
								</div>
								
								<div>
									<p style="margin-top: 10px; margin-bottom: 0;">
										안녕하세요 이번주 금요일 22시부터 24시 예약했는데 인원설정을 잘못해서 연락드립니다. 12명이 아닌 14명인데 괜찮을까요?
									</p>
								</div>
							</div>
						</div>
					</div>
					<div id="pagingDiv">
						<button class="btnPaging" style="color: #36BC9B;">1</button>
						<button class="btnPaging">2</button>
						<button class="btnPaging">3</button>
						<button class="btnPaging">4</button>
						<button class="btnPaging">5</button>
					</div>
				</div>

				<div id="spaceRefund">
					<div class="headerDiv">
						<span style="font-size: 24px; font-weight: bold;">환불규정</span>
					</div>
					<span>
						· 쉐어잇 및 호스트의 사유로 인한 취소 시 : 100% 환불<br>
						<br>
						· 천재지변 등 불가항력적 사유로 인한 취소 시 : 100% 환불<br>
						<br>
						· 결제 후, 3시간 이내 취소 시, 100% 환불됩니다.<br>
						   (단, 이용시작 시간 12시간 이내에 취소 시에는 환불 불가입니다.)<br>
						<br>
						· 견적상품은 예약접수 이후 대관계약서를 통해 환불 규정을 확인하실 수 있습니다.<br>
						<br>
						· 이용일 기준 1일 전까지 취소 시 : 100% 환불<br>
						<br>
					</span>
				</div>
			</div>

			
			<div id="spaceContentRightDiv">
				<div id="reservationDiv">
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
							55,000원 / 시간
						</span>
					</div>
					
					<div class="reservationDetailDiv" style="margin-top: 10px;">
						<span style="font-size: 18px; font-weight: bold; font-stretch: normal; line-height: 1.44; letter-spacing: -0.1px; color: rgb(27, 29, 31);">
							스케줄
						</span>
					</div>
					<div class="reservationDetailDiv" style="margin-top: 10px; font-size: 12px; font-weight: bold; font-stretch: normal; line-height: 1.17; letter-spacing: normal; color: rgb(158, 164, 170);">
						<span>공간 예약 날짜</span>
						<div id="inputDateDiv">
							<span>예약 날짜를 선택하세요</span>
						</div>
					</div>
					
					<input type="text" id="reservationDate" style="display: none;">
					
					<script>
							$(document).ready(function() {
						        // jQuery UI datepicker 초기화
						        $("#reservationDate").datepicker({
						            dateFormat: "yy-mm-dd", // 날짜 포맷 설정
						            minDate: 0,             // 오늘 이후 날짜만 선택 가능
						            onSelect: function(dateText) {
						                // 날짜가 선택되면 선택한 날짜를 #inputDateDiv에 표시
						                $('#inputDateDiv span').text(dateText);
						                $("#reservationDate").hide(); // 달력 숨기기
						            }
						        });
		
						        // #inputDateDiv 클릭 시 달력 보이기
						        $("#inputDateDiv").click(function() {
						            $("#reservationDate").datepicker("show"); // 달력 보이기
						        });
						    });
						</script>
					
					
					
					
					
					<div class="reservationDetailDiv" style="margin-top: 10px; padding-bottom: 10px; font-size: 12px; font-weight: bold; font-stretch: normal; line-height: 1.17; letter-spacing: normal; color: rgb(158, 164, 170); ">
						<span>인원 수</span>
					 	<div id="inputPeopleDiv">
					 		<span>이용 인원 수를 입력하세요</span>
					 		<div id="inputPeopleDropdownDiv">
						        <div id="inputTotalDiv">
						        	<span style="width: 75px; font-size: 16px; font-weight: bold; color: black;">총 인원 수</span>
						        	<div style="width: 140px;">
						        		<button id="btnPeopleMinus" class="btnPeopleMul" style="margin-left: 10px;">-</button>
						        		<input id="inputPeopleCount" type="number" value=0 style="border: solid 1px #dfe2e7; border-radius: 4px; text-align: center; font-size: 16px; width: 50px; height: 40px; outline: none; ">
						        		<button id="btnPeoplePlus" class="btnPeopleMul" style="margin-right: 10px;">+</button>
						        	</div>
						        </div>
						        <div id="inputPeopleRequestDiv">
						        	<div id="inputPeopleResetDiv"><span id="inputPeopleReset" style="cursor: pointer;">초기화</span></div>
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
				                $("#inputPeopleCount").val(curInputPeopleCount+1);
				            });
				            
				            $("#btnPeopleMinus").on("click", function() {
				                let curInputPeopleCount = parseInt($("#inputPeopleCount").val());
				                $("#inputPeopleCount").val(curInputPeopleCount-1);
				            });
				            
				            $("#inputPeopleSubmitDiv").on("click", function() {
				            	let curInputPeopleCount = parseInt($("#inputPeopleCount").val());
				            	
				            	$("#inputPeopleDiv").children('span').text("총 "+curInputPeopleCount+"명")
				            	$("#inputPeopleDiv").css("color","black");
				            	
				            	
				            	$("#inputPeopleDropdownDiv").hide();
				            });
				            
				        });
				    </script>
					
					<div class="reservationDetailDiv" style="margin-top: 10px; display: flex; align-items: center; justify-content: space-between;">
						<div class="btnreservationDiv" style="width: 60%;">
							<span style="font-weight: bold; font-size: 16px; line-height: 22px; text-align: center; letter-spacing: -0.1px; color: #9ea4aa;">예약 요청하기</span>
						</div>
						
						<div id="QnAWriteDiv2" class="btnreservationDiv" style="width: 35%;">
							<span style="font-weight: bold; font-size: 16px; line-height: 22px; text-align: center; letter-spacing: -0.1px; color: rgb(27, 29, 31);">
								질문하기
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>