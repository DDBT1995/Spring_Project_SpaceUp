<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로필 페이지</title>
<link rel="stylesheet" href="/resources/css/guest/reservationView.css">
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=0f979efa24339b22af634ee6af0fd743&libraries=services"></script>
<script type="text/javascript">
	//카카오페이 팝업창 객체
	let kakaoPayPopup = null;

	function fn_kakaoPayReady(goodsCode) {
		let formData = {
			goodsCode : goodsCode
		};

		$
				.ajax({
					type : "POST",
					url : "/kakao/readyAjax",
					data : formData,
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

	function fn_kakaoPayResult(code, msg) {
		if (kakaoPayPopup != null) {
			if (icia.common.type(kakaoPayPopup) == "object"
					&& !kakaoPayPopup.closed) {
				//카카오페이 팝업창이 객체이면서 닫히지 않았다면 창을 닫는다.
				kakaoPayPopup.close();
			}

			//카카오페이 팝업창 객체 초기화
			kakaoPayPopup = null;
		}

		icia.common.log("code : []" + code + "]");
		icia.common.log("msg : []" + msg + "]");

		if (code == 0) {
			alert(msg);
		} else {
			alert(msg);
		}

		/*
		팝업창이 닫히지 않고 alert(msg) 창이 먼저 뜨고 팝업창이 그대로 있을 경우
		바로위 if~else 절을 아래걸로 대체 함.
		
		 setTimeout(function() {
		     alert(msg);
		 }, 100);   
		 */
	}

	//결제취소 (환불)
	function fn_kakaoPayCancel(paymentId) {
		if (confirm("결제를 취소하시겠습니까?")) {
			console.log("Payment ID for cancel:", paymentId); // 디버깅 로그

			$.ajax({
				type : "POST",
				url : "/order/kakaoPay/refund",
				data : {
					paymentId : paymentId
				},
				dataType : "JSON",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("AJAX", "true");
				},
				success : function(response) {
					if (response.code === 0) {
						alert("결제가 취소되었습니다.");
						location.href = "/guest/myPage";
					} else if (response.code === -1) {
						alert("결제 취소 중 오류가 발생하였습니다.");
					} else if (response.code === -2) {
						alert("이미 결제취소 완료된 건입니다.");
					} else if (response.code === -3) {
						alert("결제 정보가 존재하지 않습니다.");
					} else {
						alert("예기치 못한 오류가 발생했습니다. 다시 시도해주세요.");
					}
				},
				error : function(xhr, status, error) {
					console.error("AJAX Error:", error); // 콘솔에 상세 에러 출력
					alert("결제 취소 요청 중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.");
				}
			});
		} else {
			alert("결제 취소를 취소하였습니다."); // 취소 알림
		}
	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div class="profile-container">
		<div class="profile-card">
			<div class="avatar">
           		<img src="/resources/images/guest/upload/${hexGuestEmail}.png" onerror="this.onerror=null; this.src='/resources/images/guest/upload/profileNull.svg'; this.style.filter='invert(99%) sepia(94%) saturate(618%) hue-rotate(84deg) brightness(91%) contrast(91%)';">
           	</div>
			<h2 class="profile-nickname">${guest.guestNickname}</h2>
			<div class="email">
				<p>${guest.guestEmail}</p>
			</div>
			<button class="edit-profile" onclick="location.href='/guest/pwdCheckForm'">회원정보 관리</button>
			<div class="points-coupons"></div>

			<div class="menu">
				<div class="sideMenu">
					<h3>예약정보</h3>
					<ul>
						<li><a href="/guest/myPage" class="active">공간예약 내역</a></li>
					</ul>
				</div>

				<hr>

				<div class="sideMenu">
					<h3>활동정보</h3>
					<ul>
						<li><a href="/guest/reviewList">리뷰 관리</a></li>
						<li><a href="/guest/QnAList">공간Q&A</a></li>
						<li><a href="/guest/likeyList">좋아요</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="reserv-container">
			<h1>예약 상세 정보</h1>
			<div class="detailPage">
				<div class="details" style="width: 100%; margin-left: 15px; margin-right: 20px;">
					<p>
						<strong class="strong">장소 이미지</strong><img style="max-width: 300px; max-height: 200px; border-radius: 10px;" src="http://spaceuphostcenter.sist.co.kr:8088//resources/images/space/upload/${reservation.spaceType}/${reservation.spaceId}/${reservation.spaceId}_1.jpg" alt="예약된 장소" style="width: 50%; height: 50%;">
					</p>
					<hr>
					<p>
						<strong class="strong">예약 번호</strong> ${reservation.reservationId }
					</p>
					<hr>
					<p>
						<strong class="strong">장소</strong>${space.spaceName}</p>
					<hr>
					<p>
						<fmt:parseDate value="${reservation.useDate}" pattern="yyyyMMdd" var="parsedDate" />
						<strong class="strong">일정</strong><fmt:formatDate value="${parsedDate}" pattern="yyyy년 MM월 dd일" /> ${reservation.useStartTime}시 ~ ${reservation.useEndTime}시
					</p>
					<p>
						<strong class="strong">시간</strong>
						<c:out value="${reservation.useEndTime - reservation.useStartTime}" />
						시간
					</p>
					<p>
						<strong class="strong">총인원</strong>${reservation.usePeople }명</p>
				</div>
			</div>

			<div class="detailPage">
				<div class="info-box_2">
					<div id="spaceLocationDiv">
						<span style="font-size: 24px; font-weight: bold;">위치</span>
						<div id="map" style="width: 100%; height: 300px; margin-bottom: 20px; margin-top: 10px;"></div>
						<script>
							// Kakao Maps API 초기화
							kakao.maps
									.load(function() {
										var mapContainer = document
												.getElementById('map'); // 지도 컨테이너
										var mapOptions = {
											center : new kakao.maps.LatLng(
													37.5665, 126.9780), // 초기 중심 좌표 (서울)
											level : 3
										// 확대 레벨
										};

										var map = new kakao.maps.Map(
												mapContainer, mapOptions);

										// 주소 -> 좌표 변환 객체 생성
										var geocoder = new kakao.maps.services.Geocoder();

										// 검색할 주소
										var address = "${space.spaceAddr}";

										// 주소를 좌표로 변환
										geocoder
												.addressSearch(
														address,
														function(result, status) {
															if (status === kakao.maps.services.Status.OK) {
																var latlng = new kakao.maps.LatLng(
																		result[0].y,
																		result[0].x);

																// 지도 중심을 변경
																map
																		.setCenter(latlng);

																// 마커 생성
																var marker = new kakao.maps.Marker(
																		{
																			position : latlng
																		// 마커 위치
																		});

																// 마커 지도에 표시
																marker
																		.setMap(map);
															} else {
																console
																		.error(
																				"주소 검색 실패: ",
																				status);
															}
														});
									});
						</script>
						<p id="spaceAddr" style="margin-bottom: 50px;">
							<img id="addrIcon" alt="" src="/resources/images/space/icon/addr.svg">&nbsp; ${space.spaceAddr}
						</p>
						<span style="font-size: 24px; font-weight: bold; margin-top: 30px;">찾아오시는 길</span>
						<p>${space.spaceAddr} ${space.spaceAddrDesc}</p>
					</div>
				</div>
			</div>

			<div class="detailPage">
				<div class="info-box_2">
					<h2>이용 금액</h2>
					<div class="details_2">
						<p>
							<strong class="strong">이용시간</strong>
							<c:out value="${reservation.useEndTime - reservation.useStartTime}" />
							시간
						</p>
						<p>
							<strong class="strong">이용금액(1시간)</strong>
							<fmt:formatNumber type="number" maxFractionDigits="3" groupingUsed="true" value="${space.spaceHourlyRate}" />
						</p>
						<hr>
						<p>
							<strong class="strong">총 금액 합계</strong>
							<fmt:formatNumber type="number" maxFractionDigits="3" groupingUsed="true" value="${(reservation.useEndTime - reservation.useStartTime) * space.spaceHourlyRate}" />
							원
						</p>
					</div>
				</div>
			</div>

			<div class="detailPage">
				<div class="info-box_2">
					<h2>결제</h2>
					<div class="details_2">
						<p>
							<strong class="strong">총 금액</strong>
							<fmt:formatNumber type="number" maxFractionDigits="3" groupingUsed="true" value="${payment.amount}" />
							원
						</p>
						<hr>
						<p>
							<strong class="strong">총 결제 금액</strong>
							<fmt:formatNumber type="number" maxFractionDigits="3" groupingUsed="true" value="${payment.amount}" />
							(부가세 포함)
						</p>
					</div>
				</div>
			</div>

			<div class="returnInfo">
				<p id="return">
					<b style="font-size: 18px;">spaceUp 환불 규정</b>
					
						호스트 승인 전
						• 호스트 승인 전에 예약 취소 시 100% 환불
						
						호스트 승인 후
						• 게스트 취소 시 - 결제 후 2시간 이내 또는 사용일 4일 전까지 취소하면 100% 환불
									  (사용일 3일 전 환불 불가)
						• 호스트 귀책 사유 취소 시 - 100% 환불
				</p>
			</div>
			
			<c:if test="${reservation.status eq 'P'}">
				<div class="buttons">
					<button type="button" id="btnCancel" name="btnCancel" onclick="fn_kakaoPayCancel(${payment.paymentId})">예약 취소</button>
					<!-- 주문정보 아이디넣기(reservationId) -->
				</div>
			</c:if>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
