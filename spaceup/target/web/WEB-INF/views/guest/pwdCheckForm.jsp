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
    
        <div class="pwdConfirm-container">
            <h1>회원정보 변경</h1>
            
            <div class="container">
                <div class="info-section">
                    회원님의 개인 정보를 소중하게 보호하고 있습니다.<br>
                    회원님의 동의 없이 회원정보를 제3자에게 제공하지 않습니다.
                </div>
                <div class="divider"></div>
                <div class="notice">
                    고객님의 개인 정보 보호를 위해 비밀번호를 입력 후, 이용이 가능합니다.
                </div>

            <div class="confirm-container">
                <div class="form-group">
                    <label for="current-password">현재 비밀번호</label>
                    <div class="password-input">
                        <input type="password" id="current-password" placeholder="비밀번호를 입력하세요">
                        <button class="confirm-button">회원 확인</button>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
