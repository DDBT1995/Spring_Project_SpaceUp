<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/guest/guest.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div>
	    <div class="profile-container">
	        <div class="profile-card">
	            <div class="avatar">
                	<img src="/resources/images/guest/upload/${hexGuestEmail}.png" onerror="this.onerror=null; this.src='/resources/images/guest/upload/profileNull.svg'; this.style.filter='invert(99%) sepia(94%) saturate(618%) hue-rotate(84deg) brightness(91%) contrast(91%)';">
                </div>
	            <h2>${guest.guestNickname}</h2>
	            <div class="email">
	                <p>${guest.guestEmail}</p>
	            </div>
	            <button class="edit-profile" onclick="location.href='/guest/pwdCheckForm'">회원정보 관리</button>
	            <div class="points-coupons">
	            </div>
	
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
	        	<h1>공간 예약 내역</h1>
	        			    
			    <!-- 탭 -->
			    <div class="tabs">
			        <div class="tab all ${status == '' ? 'active' : ''}" onclick="activateTab(this); fn_list(${curPage}, '')">전체</div>
			        <div class="tab progress ${status == 'P' ? 'active' : ''}" onclick="activateTab(this); fn_list(${curPage}, 'P')">진행중</div>
			        <div class="tab completed ${status == 'C' ? 'active' : ''}" onclick="activateTab(this); fn_list(${curPage}, 'C')">완료</div>
			        <div class="tab cancelled ${status == 'D' ? 'active' : ''}" onclick="activateTab(this); fn_list(${curPage}, 'D')">취소</div>
			    </div>	    	    

	            <!-- 예약조회 검색 -->
	            <div class="search-bar">
	                <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" placeholder="예약번호를 입력해 주세요" onkeyup="searchFn()">
	                <button type="button" id="btnSearch"><img src="https://img.shareit.kr/front-assets/icons/magnifier_lineBold_gray024.svg?version=1.0" alt="검색" class="Standardstyle__Image-sc-e72szk-0"></button>
	            </div>
	            
	            <c:if test="${empty list}">
				    <div class="nono">
				    	<img src="/resources/images/guest/icon/empty_v2.png" />
				    	<p>예약 내역이 없습니다.</p>
				    </div>				    
				</c:if>
				
	            <!-- 예약 리스트 -->
	            <div class="tab-content" id="all">
		        	<div class="space-list">
		            	<c:forEach var="reservation" items="${list}" varStatus="status">
			                <div class="space-card">
			                    <div class="status ${reservation.status}">
							    	<c:choose>
				                        <c:when test="${reservation.status == 'P'}">진행 중</c:when>
				                        <c:when test="${reservation.status == 'C'}">완료</c:when>
				                        <c:when test="${reservation.status == 'D'}">취소</c:when>
				                        <c:otherwise>알 수 없음</c:otherwise>
				                    </c:choose>
			                    </div>
			                    <img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${reservation.spaceType}/${reservation.spaceId}/${reservation.spaceId}_1.jpg" alt="공간 이미지" onerror="this.src='https://via.placeholder.com/300';">
			                    <div class="space-info">
			                    <h3 id="spaceName" onclick="fn_spaceView(${reservation.spaceId})">${reservation.spaceName}</h3>
			                    <hr>
			                    <p>예약번호 ${reservation.reservationId}</p>
			                    <div class="details">
			                        <span>예약날짜 <c:out value="${fn:substring(reservation.regDate, 0, 10)}"/></span>
			                    </div>
			                    </div>
			                    <div class="button-group">
			                        <button type="button" id="regDetail" onclick="fn_reservationView(${reservation.reservationId})">예약 상세보기</button>
			                    </div>
			                    
			                </div>
		                </c:forEach>
		            </div>      
	            </div>
	            <form id="reservationIdForm" name="reservationIdForm" method="get">
					<input type="hidden" name="reservationId" id="reservationId">
               	</form>
	            <script type="text/javascript">
					function fn_reservationView(reservationId){
						
						document.reservationIdForm.reservationId.value = reservationId;
						document.reservationIdForm.action = "/guest/reservationView";
						document.reservationIdForm.submit();
					}
					
					function fn_spaceView(spaceId) {
					   window.open("/space/spaceView?spaceId="+spaceId, '_blank');
					}
				</script>
			    
			    <!-- 페이징 버튼 추가 -->
	            <div class="pagination">
		            <c:if test="${!empty paging}">
		            	<!-- 이전 블럭 버튼 -->
		            	<c:if test="${paging.prevBlockPage gt 0}">	
			                <a class="prev" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage}, '${status}')">
			                	<img src="/resources/images/guest/icon/left_arrow.png" />
			                </a>
			            </c:if>
			            
			            <!-- 숫자 버튼 -->
						<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
					      <c:choose>
					      	<c:when test="${i ne curPage}"> 
			                	<a class="btn" href="javascript:void(0)" onclick="fn_list(${i}, '${status}')">${i}</a>
							</c:when>
	        				<c:otherwise>
					        	<a class="btn active" href="javascript:void(0)" onclick="fn_list(${i}, '${status}')" style="cursor:default;">${i}</a>
						  	</c:otherwise>
						  </c:choose>
						</c:forEach>
			            
			            <!-- 다음 블럭 버튼 -->    
			            <c:if test="${paging.nextBlockPage gt 0}">
			                <a class="next" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage}, '${status}')">
			                	<img src="/resources/images/guest/icon/right_arrow.png" />
			                </a>
			            </c:if>
		            </c:if>
	            </div>		
	        </div>
	    </div>
    </div>
    
    <!-- 폼 데이터 -->
	<form name="resForm" id="resForm" method="post">
		<input type="hidden" id="reservationId" name="reservationId" value="" />
		<input type="hidden" id="searchValue" name="searchValue" value="${searchValue}" />
		<input type="hidden" id="curPage" name="curPage" value="${curPage}" />
		<input type="hidden" id="status" name="status" value="${status}" />
	</form>
    
<script>
// 탭 전환
function activateTab(selectedTab) {
    const tabs = document.querySelectorAll('.tab');
    tabs.forEach(tab => {
        tab.classList.remove('active');
    });
    selectedTab.classList.add('active');

    // 활성화된 탭 이름 저장
    activeTab = selectedTab.textContent.trim();
}

$(document).ready(function(){
	// 검색 버튼 눌렀을 경우
	$("#btnSearch").on("click", function(){
		document.resForm.reservationId = "";
		document.resForm.searchValue.value = $("#_searchValue").val();		
		document.resForm.curPage.value = "1";
		document.resForm.action = "/guest/myPage";
		document.resForm.submit();
	});
	
	
});

function searchFn() {
	if(window.event.keyCode == 13) {
		document.resForm.reservationId = "";
		document.resForm.searchValue.value = $("#_searchValue").val();		
		document.resForm.curPage.value = "1";
		document.resForm.action = "/guest/myPage";
		document.resForm.submit();
	}
	
}

function fn_list(curPage, status)
{
    // 탭을 전환할 경우 curPage를 초기화
    if (status != document.resForm.status.value)
    {
        curPage = 1; // 새로운 탭에서는 첫 페이지로 설정
        document.resForm.searchValue.value = ""; // 검색 값 초기화
    }
    
	document.resForm.reservationId.value = "";
	document.resForm.status.value = status;
	document.resForm.curPage.value = curPage;
	document.resForm.action = "/guest/myPage";
	document.resForm.submit();
}
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>