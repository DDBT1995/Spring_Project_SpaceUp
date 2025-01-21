<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/header.css">
<script src="https://kit.fontawesome.com/a5c51740a4.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
</head>

<%
if (com.sist.web.util.CookieUtil.getCookie(request, (String) request.getAttribute("AUTH_COOKIE_NAME")) != null) { //로그인 했을 경우
    String cookieUserId = com.sist.web.util.CookieUtil.getValue(request, (String)request.getAttribute("AUTH_COOKIE_NAME"));
%>

<body class="headerBody">
   <header>
      <div class="headerBox">
         <div class="headerLeft">
            <div class="headerLeftLogoBox">
               <i> <a href="/space/spaceMain" class="headerLeftLogoLink"> <img src="/resources/images/logo/logo.png" alt="로고 이미지" style="width: 115px; height: 60px;">
               </a>
               </i>
            </div>
         </div>
         
        <div class="headerCenter"> 
	        <div class="Searchstyle__Search-sc-alcl5p-0 gbZxlb">
				<form class="SearchInputstyle__Form-sc-1dhon1d-1 bZbpPt" action="/space/spaceList" method="get">
					<label for="header-pc-search-input" class="SearchInputstyle__Label-sc-1dhon1d-0 jIQesR">
						<input
						type="text" id="header-pc-search-input" autocomplete="off"
						placeholder="빛나는 새해를 위해, 계획세우기 좋은 공간 ☀️" maxlength="100"
						class="SearchInputstyle__Input-sc-1dhon1d-2 hSdaIa" value=""
						style="background: transparent; border: none; outline-style: none; padding: 5px;" name="spaceName" id="spaceNameSearch">
						<button type="submit" id="gtm_GNB_PC_Life_Search_Button" style="background: transparent; border: none; cursor: pointer;">
							<img loading="lazy"
								src="https://img.shareit.kr/front-assets/icons/magnifier_lineBold_gray064.svg?version=1.0"
								alt="검색" class="Standardstyle__Image-sc-e72szk-0 drsVEN">
						</button>
					</label>
				</form>
			</div>
		</div>

         <div class="headerRight">
            <div class="headerRightLoginBox">
               <div class="headerUserMenuBox">
                  <img class="headerRightUserImg" src="/resources/images/guest/upload/<%=cookieUserId %>.png" 
     onerror="this.onerror=null; this.src='/resources/images/guest/upload/profileNull.svg'; this.style.filter='invert(99%) sepia(94%) saturate(618%) hue-rotate(84deg) brightness(91%) contrast(91%)';" />
                  
                  <div class="headerUserMenu">
                     <div class="triangle"></div>
                     <div class="HRuserId">
                        <ul>
                           <a href="/guest/myPage">
                              <li>마이페이지</li>
                           </a>
                        </ul>
                     </div>
                     <ul>
                        <a href="/guest/logout">
                           <li>로그아웃</li>
                        </a>
                     </ul>
                  </div>
               </div>
            </div>
            <div class="headerRightLogin2">
               <span onclick="hostCenter()">호스트 센터 ></span>
            </div>
		</div>
      </div>
   </header>

   <%
   } else { // 로그인 안 했을 경우
   %>

<body class="headerBody">
   <header>
      <div class="headerBox">
         <div class="headerLeft">
            <div class="headerLeftLogoBox">
               <i> <a href="/space/spaceMain" class="headerLeftLogoLink"> <img src="/resources/images/logo/logo.png" alt="로고 이미지" style="width: 115px; height: 60px;">
               </a>
               </i>
            </div>
         </div>

         <div class="headerCenter">
			<div class="Searchstyle__Search-sc-alcl5p-0 gbZxlb">
				<form class="SearchInputstyle__Form-sc-1dhon1d-1 bZbpPt" action="/space/spaceList" method="get">
					<label for="header-pc-search-input" class="SearchInputstyle__Label-sc-1dhon1d-0 jIQesR"> <input type="text" id="header-pc-search-input" autocomplete="off" placeholder="빛나는 새해를 위해, 계획세우기 좋은 공간 ☀️" maxlength="100" class="SearchInputstyle__Input-sc-1dhon1d-2 hSdaIa" value="" style="background: transparent; border: none; outline-style: none; padding: 5px;" name="spaceName" id="spaceNameSearch">
						<button type="submit" id="gtm_GNB_PC_Life_Search_Button" style="background: transparent; border: none; cursor: pointer;">
							<img loading="lazy" src="https://img.shareit.kr/front-assets/icons/magnifier_lineBold_gray064.svg?version=1.0" alt="검색" class="Standardstyle__Image-sc-e72szk-0 drsVEN">
						</button>
					</label>
				</form>
			</div>
		</div>

         <div class="headerRight">
            <div class="headerRightLogin">
               <a href="/guest/loginForm"><span>로그인</span></a>
            </div>
            <div class="headerRightLogin2">
               <span onclick="hostCenter()">호스트 센터 ></span>
            </div>
         </div>
      </div>
   </header>

   <%
   }
   %>

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

      $(document).on("click", function() {
         $(".headerLeftMenuListBox").hide();
         $(".headerUserMenu").hide();
      });
      
      function hostCenter() {
      	window.open("http://spaceuphostcenter.sist.co.kr:8088/index");
      };
   </script>
</body>
</html>
