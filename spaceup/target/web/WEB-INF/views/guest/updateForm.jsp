<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 페이지</title>
    <link rel="stylesheet" href="/resources/css/guest/guest.css">

    <script>
        // 프로필 사진과 파일 입력 요소 선택
        document.addEventListener('DOMContentLoaded', () => {
            const profileImg = document.getElementById('profile-img');
            const fileInput = document.getElementById('file-input');

            // 프로필 사진 클릭 시 파일 선택 창 열기
            profileImg.addEventListener('click', () => {
                fileInput.click();
            });

            // 파일 선택 후 이미지 미리보기
            fileInput.addEventListener('change', (event) => {
                const file = event.target.files[0]; // 선택한 파일
                if (file) {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        profileImg.src = e.target.result; // 프로필 이미지를 변경
                    };
                    reader.readAsDataURL(file);
                }
            });
        });
    </script>

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
            <h1>회원정보수정</h1>            
            <div class="container">
                <form>
                    <div class="profile-group">
                        <div class="profile-picture">
                            <!-- 기본 프로필 사진 -->
                            <img id="profile-img" src="https://via.placeholder.com/120" alt="Profile Picture" title="프로필 사진 변경하기">
                            <!-- 아이콘 -->
                            <div class="icon" id="icon-upload">
                                <!-- 아이콘 SVG 삽입 -->
                                <img src="C:\Users\user\Documents\my_profile_edit (1).svg" alt="Upload Icon">
                            </div>
                            <!-- 파일 선택 입력 -->
                            <input type="file" id="file-input" accept="image/*">
                        </div>
                    </div>
                    
                    <div class="update-container">
                    <div class="updateForm-group">
                        <label for="email">이메일*</label>
                        <input type="text" id="guestEmail" name="guestEmail" value="이메일주소" disabled>
                    </div>
                    <div class="updateForm-group">
                        <label for="password">새 비밀번호</label>
                        <input type="password" id="guestPassword" name="guestPassword" placeholder="영문/숫자 조합 8-20자로 입력해 주세요." required>
                    </div>
                    <div class="updateForm-group">
                        <label for="password">새 비밀번호 확인</label>
                        <input type="password" id="guestPasswordConfirm" name="guestPasswordConfirm" placeholder="영문/숫자 조합 8-20자로 입력해 주세요." required>
                    </div>
                    <div class="updateForm-group">
                        <label for="nickname">닉네임</label>
                        <input type="text" id="guestNickname" name="guestNickname" value="닉네임" placeholder="사용하실 닉네임을 입력해 주세요." required>
                    </div>
                    <div class="updateForm-group">
                        <label for="tel">전화번호</label>
                        <input type="text" id="guestTel" name="guestTel" value="전화번호값" placeholder="ex&#41;01011112222" required>
                    </div>
                    <div class="updateForm-group">
                        <label for="birth">생년월일</label>
                        <input type="text" id="guestBirth" name="guestBirth" value="생년월일값" placeholder="ex&#41;13970515" disabled>
                    </div>
                    </div>
                    
                    <button type="button" id="btnDel" class="btnDel">회원 탈퇴</button>
                </form>
                <div class="buttons">
                    <button type="button" id="btnReg" class="btnReg">수정 완료</button>
                </div>
            </div>
            
            
        </div>
    </div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
