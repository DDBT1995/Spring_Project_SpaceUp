<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/guest/guest.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script>
$(document).ready(function(){
	$("#btnChkPwd").on("click", function(){
		
		// 비밀번호 입력 체크
		if($.trim($("#guestPassword").val()).length <= 0)
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '비밀번호를 입력하세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestPassword").val("");
			$("#guestPassword").focus();
			
			return;
		}
		
		fn_pwdCheck();
	});
});

function fn_pwdCheck()
{
	// 비밀번호 일치 확인 aJax
	$.ajax({
		type:"POST",
		url:"/guest/pwdCheckProc",
		data:{
			guestPassword: $("#guestPassword").val()
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{	// 비밀번호 일치
				location.href = "/guest/updateForm";
			}
			else if(response.code == -1)
			{	// 비밀번호 불일치
			    Swal.fire({
			        icon: 'error',
			        title: '비밀번호가 일치하지 않습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/pwdCheckForm"
			    });				
			}
			else if(response.code == -99)
			{	// 정지된 회원
			    Swal.fire({
			        icon: 'error',
			        title: '정지된 회원입니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/loginForm"
			    });	
			}
			else if(response.code == 400)
			{	// 잘못된 요청
			    Swal.fire({
			        icon: 'error',
			        title: '비밀번호가 없습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/pwdCheckForm"
			    });	
			}
			else if(response.code == 404)
			{	// 게스트 정보 DB에 없음
			    Swal.fire({
			        icon: 'error',
			        title: '회원 정보가 올바르지 않습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/loginForm"
			    });	
			}
			else if(response.code == 410)
			{	// 로그인되지 않음
			    Swal.fire({
			        icon: 'error',
			        title: '로그인 되어있지 않습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/loginForm"
			    });	
			}
			else
			{	// 기타 오류
			    Swal.fire({
			        icon: 'error',
			        title: '비밀번호 확인 중 오류가 발생하였습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/pwdCheckForm"
			    });	
			}
		},
		error:function(error){
			icia.common.error(error);
		    Swal.fire({
		        icon: 'error',
		        title: '서버 통신 중 오류가 발생하였습니다.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    }).then((result) => {
		        location.href = "/guest/pwdCheckForm"
		    });
		}
	});
}	

function searchFn() {
	if(window.event.keyCode == 13) {
		// 비밀번호 입력 체크
		if($.trim($("#guestPassword").val()).length <= 0)
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '비밀번호를 입력하세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestPassword").val("");
			$("#guestPassword").focus();
			
			return;
		}
		
		fn_pwdCheck();
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
	                       <input type="password" id="guestPassword" name="guestPassword" placeholder="비밀번호를 입력하세요" onkeyup="searchFn()">
	                       <button class="confirm-button" id="btnChkPwd">확인</button>
	                   </div>
	               </div>
	           </div>
	           </div>
	       </div>
	   </div>       
   </div>
   
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
