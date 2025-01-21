<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/guest/showEmailForm.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

    <div class="titles">
        <h3>이메일 찾기</h3>
    </div>

    <div class="find-container">
    	
    	<c:choose>
			<c:when test="${empty list}">
				<h5>등록된 이메일이 없습니다.</h5>
				<button type="button" id="btnFindEmail" class="btnFind" onclick="location.href='/guest/findEmailForm'">이메일 찾기</button>&ensp;
				<button type="button" id="btnLogin" class="btnLogin" onclick="location.href='/guest/loginForm'">로그인</button>
			</c:when>

			<c:otherwise>
				<h5>${listCount}개의 이메일을 찾았습니다.</h5>

				<c:forEach var="item" items="${list}">
			        <form>
			            <div class="form-group">
			                <p class="emailFind" id="guestEmail">${item.guestEmail}</p>
			                <p class="regDateFind" id="regDate">가입일: ${item.regDate}</p>
			            </div>
			        </form>
		    	</c:forEach>
		    	<button type="button" id="btnFindPwd" class="btnFind" onclick="location.href='/guest/findPwdForm'">비밀번호 찾기</button>&ensp;
				<button type="button" id="btnLogin" class="btnLogin" onclick="location.href='/guest/loginForm'">로그인</button>
			</c:otherwise>
		</c:choose>
   
        
        
    </div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
    
</body>
</html>