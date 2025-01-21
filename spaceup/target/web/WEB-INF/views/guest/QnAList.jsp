<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 페이지</title>
    <link rel="stylesheet" href="/resources/css/guest/QnAList.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

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
            <h1>공간 Q&A</h1>

            <!-- 공간 당 문의 -->
            <div class="detailPage">
                <hr>
                <div class="info-box">
                    <img src="images\background\background(1).jpg" alt="예약된 장소">
                    <div class="details" style="text-align: right;">
                        <p>홍대 인근 아트마이 스튜디오</p>
                    </div>                   
                </div>

                <!-- QnA 목록-->
                <hr style="border-width: 1px 0 0 0;">
                <div class="details">
                    <span>
                        <span class="qna-regDate">2024-11-29 &nbsp;| &nbsp; </span>
                        <span class="qna-answerCnt">호스트 답변 0</span>
                    </span>                
                    <div class="qna-body">몇 명까지 이용 가능한가요?</div>
                </div>
                <hr>
            </div>

            <div class="detailPage">
                <hr>
                <div class="info-box">
                    <img src="images\background\background(1).jpg" alt="예약된 장소">
                    <div class="details" style="text-align: right;">
                        <p>홍대 인근 아트마이 스튜디오</p>
                    </div>                   
                </div>

                <!-- QnA 목록-->
                <hr style="border-width: 1px 0 0 0;">
                <div class="details">
                    <span>
                        <span class="qna-regDate">2024-11-29 &nbsp;| &nbsp; </span>
                        <span class="qna-answerCnt">호스트 답변 0</span>
                    </span>                
                    <div class="qna-body">몇 명까지 이용 가능한가요?</div>
                </div>
                <hr>
            </div>

            <div class="detailPage">
                <hr>
                <div class="info-box">
                    <img src="images\background\background(1).jpg" alt="예약된 장소">
                    <div class="details" style="text-align: right;">
                        <p>홍대 인근 아트마이 스튜디오</p>
                    </div>                   
                </div>

                <!-- QnA 목록-->
                <hr style="border-width: 1px 0 0 0;">
                <div class="details">
                    <span>
                        <span class="qna-regDate">2024-11-29 &nbsp;| &nbsp; </span>
                        <span class="qna-answerCnt">호스트 답변 0</span>
                    </span>                
                    <div class="qna-body">몇 명까지 이용 가능한가요?</div>
                </div>
                <hr>
            </div>

            <!-- 페이징 버튼 추가 -->
            <div class="pagination">
                <button class="prev">&lt;</button>
                <span>1</span>
                <button class="next">&gt;</button>
            </div>
        </div>
    </div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>