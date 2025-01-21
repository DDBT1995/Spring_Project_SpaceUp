<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<meta charset="UTF-8">
<title>Document</title>
<link rel="stylesheet" href="/resources/css/header.css">
<script src="https://kit.fontawesome.com/a5c51740a4.js" crossorigin="anonymous"></script>
</head>
<style>
</style>
<body class="headerBody">
    <header>
        <div class="headerBox">
            <div class="headerLeft">
                <div class="headerLeftMenuBox">
                    <i>
                        <img src="/resources/images/header/hambuger.svg" alt="hambugerBtn" class="headerLeftMenuHbg">
                    </i>
                    <div class="headerLeftMenuListBox">
                        <ul class="headerLeftMenuListUl">
                            <a href="#">
                                <li>
                                    <i class="fa-solid fa-video"></i>
                                    <p>드라마/영화/촬영</p>
                                </li>
                            </a>
                            <a href="#">
                                <li>
                                    <i class="fa-solid fa-champagne-glasses"></i>
                                    <p>파티</p>
                                </li>
                            </a>
                            <a href="#">
                                <li>
                                    <i class="fa-regular fa-calendar-days"></i>
                                    <p>스터디/모임</p>
                                </li>
                            </a>
                            <a href="#">
                                <li>
                                    <i class="fa-solid fa-dumbbell"></i>
                                    <p>레저/헬스</p>
                                </li>
                            </a>
                            <a href="#">
                                <li>
                                    <i class="fa-solid fa-gamepad"></i>
                                    <p>게임/이벤트</p>
                                </li>
                            </a>
                            <a href="#">
                                <li>
                                    <i class="fa-solid fa-headset"></i>
                                    <p>회의</p>
                                </li>
                            </a>
                        </ul>
                    </div>
                </div>
                <div class="headerLeftLogoBox">
                    <i>
                        <a href="#" class="headerLeftLogoLink">
                            <img src="/resources/images/logo/spaceUpLogo.png" alt="로고 이미지">
                        </a>
                    </i>
                </div>
            </div>
    
            <div class="headerCenter">
                <form class="headeSearchForm">
                    <label for="headerSearchInput" class="headerSearchInputLabel">
                        <input type="text" id="headerSearchInput" class="headerSearchInput" name="mainSearch">
                        <button class="headerSearchBtn">
                            <img src="/resources/images/header/searchIcon.svg">
                        </button>
                    </label>
                </form>
            </div>
    
            <div class="headerRight">
                <div class="headerRightLogoutBox">
                    <span>로그인</span>
                    <span>회원가입</span>
                </div>

                <div class="headerRightLoginBox">
                    <div class="headerUserMenuBox">
                        <img class="headerRightUserImg" src="/resources/images/header/userImg.png">
                        <div class="headerUserMenu">
                            <div class="HRuserId">
                                <ul>
                                    <li>너구리</li>
                                </ul>
                            </div>
                            <hr/>
                            <ul class="HRuserMenu">
                                <a href="#">
                                    <li>프로필</li>
                                </a>
                                <a href="#">
                                    <li>나의 문의</li>
                                </a>
                                <a href="#">
                                    <li>예약 내역</li>
                                </a>
                                <a href="#">
                                    <li>리뷰 내역</li>
                                </a>
                            </ul>
                            <hr/>
                            <ul>
                                <a href="#">
                                    <li>로그아웃</li>
                                </a>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <a href="#">
                            <i class="fa-regular fa-heart"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <script>
        $(".headerRightLogoutBox").css("display", "none");

        $(".headerRightUserImg").on("click", function(e) {
            e.stopPropagation();
            $(".headerUserMenu").toggle();
        });

        $(".headerLeftMenuHbg").on("click", function(e) {
            e.stopPropagation();
            $(".headerLeftMenuListBox").toggle();
        });

        $(document).on("click", function () {
            $(".headerLeftMenuListBox").hide();
            $(".headerUserMenu").hide();
        });
    </script>
</body>
</html>