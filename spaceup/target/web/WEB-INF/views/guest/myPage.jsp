<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 페이지</title>
    <link rel="stylesheet" href="/resources/css/guest/guest.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div>
	    <div class="profile-container">
	        <div class="profile-card">
	            <div class="avatar">
	                <img src="https://img.hourplace.co.kr/image/user/156203/2024/11/26/04623d03-a00d-4307-a735-bd7df696d8b4?s=2000x2000&t=inside&q=80&f=jpeg" alt="User Avatar">
	            </div>
	            <h2>닉네임</h2>
	            <div class="email">
	                <p>test@sist.co.kr</p>
	            </div>
	            <button class="edit-profile">회원정보 관리</button>
	            <div class="points-coupons">
	            </div>
	
	            <div class="menu">
	                <div class="sideMenu">
	                <h3>예약정보</h3>
	                <ul>
	                    <li><a href="guestMyPage.html" class="active">공간예약 내역</a></li>
	                </ul>
	                </div>
	
	                <hr>
	                
	                <div class="sideMenu">
	                <h3>활동정보</h3>
	                <ul>
	                    <li><a href="guestReviewLIst.html">리뷰 관리</a></li>
	                    <li><a href="guestQnAList.html">공간Q&A</a></li>
	                    <li><a href="guestLIkeyList.html">좋아요</a></li>
	                </ul>
	                </div>
	            </div>
	        </div>
	    
	        <div class="reserv-container">
	            <h1>공간예약 내역</h1>
	            <div class="tabs">
	                <div class="tab active">전체 (0)</div>
	                <div class="tab">진행중 (0)</div>
	                <div class="tab">완료 (0)</div>
	                <div class="tab">취소/환불 (0)</div>
	            </div>
	            <div class="search-bar">
	                <input type="text" placeholder="예약번호를 입력해 주세요">
	                <button><img loading="lazy" src="https://img.shareit.kr/front-assets/icons/magnifier_lineBold_gray024.svg?version=1.0" alt="검색" class="Standardstyle__Image-sc-e72szk-0"></button>
	            </div>
	            <div class="space-list">
	                <div class="space-card">
	                    <div class="status">진행중</div>
	                    <img src="/resources/images/space/spaceId/1.jpg" alt="공간 이미지">
	                    <div class="space-info">
	                    <h3>가나다라마바사사</h3>
	                    <hr>
	                    <p>예약번호 67302</p>
	                    <div class="details">
	                        <span>예약날짜 2024.11.22</span>
	                    </div>
	                    </div>
	                    <div class="button-group">
	                        <button>예약 상세보기</button>
	                    </div>
	                </div>
	                <div class="space-card">
	                    <div class="status">진행중</div>
	                    <img src="https://via.placeholder.com/300" alt="공간 이미지">
	                    <div class="space-info">
	                    <h3>체험 테마 스튜디오</h3>
	                    <hr>
	                    <p>예약번호 67227</p>
	                    <div class="details">
	                        <span>예약날짜 2024.11.20</span>
	                    </div>
	                    </div>
	                    <div class="button-group">
	                        <button>예약 상세보기</button>
	                    </div>
	                </div>
	                <div class="space-card">
	                    <div class="status">진행중</div>
	                    <img src="https://via.placeholder.com/300" alt="공간 이미지">
	                    <div class="space-info">
	                    <h3>체험 테마 스튜디오</h3>
	                    <hr>
	                    <p>예약번호 67227</p>
	                    <div class="details">
	                        <span>예약날짜 2024.11.20</span>
	                    </div>
	                    </div>
	                    <div class="button-group">
	                        <button>예약 상세보기</button>
	                    </div>
	                </div>
	                <div class="space-card">
	                    <div class="status">진행중</div>
	                    <img src="https://via.placeholder.com/300" alt="공간 이미지">
	                    <div class="space-info">
	                    <h3>체험 테마 스튜디오</h3>
	                    <hr>
	                    <p>예약번호 67227</p>
	                    <div class="details">
	                        <span>예약날짜 2024.11.20</span>
	                    </div>
	                    </div>
	                    <div class="button-group">
	                        <button>예약 상세보기</button>
	                    </div>
	                </div>
	                <div class="space-card">
	                    <div class="status">진행중</div>
	                    <img src="https://via.placeholder.com/300" alt="공간 이미지">
	                    <div class="space-info">
	                    <h3>체험 테마 스튜디오</h3>
	                    <hr>
	                    <p>예약번호 67227</p>
	                    <div class="details">
	                        <span>예약날짜 2024.11.20</span>
	                    </div>
	                    </div>
	                    <div class="button-group">
	                        <button>예약 상세보기</button>
	                    </div>
	                </div>
	            </div>
	            <!-- 페이징 버튼 추가 -->
	            <div class="pagination">
	                <button class="prev">&lt;</button>
	                <span>1</span>
	                <button class="next">&gt;</button>
	            </div>
	        </div>
	    </div>
    </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
