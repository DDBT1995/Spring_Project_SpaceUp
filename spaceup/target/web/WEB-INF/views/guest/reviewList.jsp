<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 페이지</title>
    <link rel="stylesheet" href="/resources/css/guest/reviewList.css">
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
            <h1>리뷰 관리</h1>
            <div class="reviews">
                <div class="tabs">
                    <div class="tab active">작성가능 리뷰 (0)</div>
                    <div class="tab">작성한 리뷰 (0)</div>
                </div>

                <table class="review-table">
                    <thead>
                        <tr>
                            <th>예약번호</th>
                            <th>예약정보</th>
                            <th>호스트</th>
                            <th>금액</th>
                            <th>리뷰관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                112<br>
                            </td>
                            <td>
                                <div class="review-details"></div>
                                <a href="#"><img src="https://via.placeholder.com/50" alt="상품 이미지">
                                <div><b>VA gallery 신당 통건물 팝업 대관</b><br><span style="font-size: 12px; color: gray;">서울 중구</span></a></div>
                            </td>
                            <td>크리마<br>thecrema</td>
                            <td>
                                50,000 (총금액값)
                            </td>
                            <td>
                                <button class="manage-btn">작성</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                111<br>
                            </td>
                            <td>
                                <div class="review-details"></div>
                                <a href="#"><img src="https://via.placeholder.com/50" alt="상품 이미지">
                                <div><b>VA gallery 신당 통건물 팝업 대관</b><br><span style="font-size: 12px; color: gray;">서울 중구</span></a></div>
                            </td>
                            <td>크리마<br>thecrema</td>
                            <td>
                                50,000 (총금액값)
                            </td>
                            <td>
                                <button class="manage-btn">작성</button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <!-- 페이징 버튼 추가 -->
                <div class="pagination">
                    <button class="prev">&lt;</button>
                    <span>1</span>
                    <button class="next">&gt;</button>
                </div>
            </div>

            <div class="reviews">
                <div class="tabs">
                    <div class="tab">작성가능 리뷰 (0)</div>
                    <div class="tab active">작성한 리뷰 (0)</div>
                </div>

                <table class="review-table">
                    <thead>
                        <tr>
                            <th>작성일</th>
                            <th>예약정보</th>
                            <th>리뷰상세</th>
                            <th>리뷰관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                2024. 12. 02<br>
                            </td>
                            <td>
                                <div class="review-details"></div>
                                <a href="#"><img src="https://via.placeholder.com/50" alt="상품 이미지">
                                <div><b>VA gallery 신당 통건물 팝업 대관</b><br><span style="font-size: 12px; color: gray;">서울 중구</span></a></div>
                            </td>
                            <td>
                                답사도 다녀오고, 공간이 넓고 인테리어가 버릴곳 없...<br>
                                <span class="rating">★★★★★</span>&nbsp;&nbsp;
                                <span class="help">도움: 0</span></td>
                            <td>
                                <button class="manage-btn">조회</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                2024. 12. 02<br>
                            </td>
                            <td>
                                <div class="review-details"></div>
                                <a href="#"><img src="https://via.placeholder.com/50" alt="상품 이미지">
                                <div><b>VA gallery 신당 통건물 팝업 대관</b><br><span style="font-size: 12px; color: gray;">서울 중구</span></a></div>
                            </td>
                            <td>
                                답사도 다녀오고, 공간이 넓고 인테리어가 버릴곳 없...<br>
                                <span class="rating">★★★★★</span>&nbsp;&nbsp;
                                <span class="help">도움: 0</span></td>
                            <td>
                                <button class="manage-btn">조회</button>
                            </td>
                        </tr>
                    </tbody>
                </table>

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
