<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/guest/guest.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script>
// 프로필 사진과 파일 입력 요소 선택
document.addEventListener('DOMContentLoaded', () => {
    const profileImg = document.getElementById('profileImg');
    const svgImg = document.getElementById('svgImg');
    const fileInput = document.getElementById('fileInput');

    // 프로필 사진 클릭 시 파일 선택 창 열기
    profileImg.addEventListener('click', () => {
        fileInput.click();
    });
    
    // svg 이미지 클릭 시 파일 선택 창 열기
    svgImg.addEventListener('click', () => {
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

$(document).ready(function(){
	$("#guestPassword1").focus();
	
	// 닉네임 중복 확인에 대한 상태
	let initialNickname = $("#guestNickname").val(); // 초기 닉네임 저장
	let isNickChecked = false; // 닉네임 중복 확인 여부
	
	// 회원 탈퇴 버튼 눌렀을 경우
	$("#btnDel").on("click", function(){		
	    Swal.fire({
	    	icon: 'warning',
	        title: '정말 탈퇴하시겠습니까?',
	        text: "회원 탈퇴 시 같은 이메일로는 재가입 할 수 없습니다.",	        
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '승인',
	        cancelButtonText: '취소',
	        reverseButtons: true, // 버튼 순서 거꾸로	        
	      }).then((result) => {
	        if (result.isConfirmed)
	        {
	        	fn_guestDelete();
	        }
	      });
	});
	
	// 중복 확인 버튼 눌렀을 경우
	$("#nickCheck").on("click", function(){
		// 공백 체크 정규식
		var emptCheck = /\s/g;
		
		// 닉네임 정규식: 2~16자, 영어 또는 숫자 또는 한글(한글 초성과 모음은 불가능)
		var nickCheck = /^(?=.*[a-zA-Z0-9가-힣])[a-zA-Z0-9가-힣]{2,16}$/;
		
		// 닉네임 입력 체크
		if($.trim($("#guestNickname").val()).length <= 0)
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '닉네임을 입력하세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestNickname").val("");
			$("#guestNickname").focus();
			return;
		}
		
		// 닉네임 공백 체크
		if(emptCheck.test($("#guestNickname").val()))
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '닉네임은 공백을 포함될 수 없습니다.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
			
			$("#guestNickname").val("");
			$("#guestNickname").focus();
			return;
		}
		
		// 닉네임 정규식 체크
		if(!nickCheck.test($("#guestNickname").val()))
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '영문/한글/숫자 조합 2-15자로 입력해주세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestNickname").val("");
			$("#guestNickname").focus();
			return;
		}		
		
		// 닉네임 중복체크 aJax		
		const currentNickname = $("#guestNickname").val();	// 변경할 닉네임
		
	    if (currentNickname == initialNickname)
	    {
	        isNickChecked = true;	// 닉네임 변경 없으면 중복 확인 완료 상태로 간주
	        
		    Swal.fire({
		        icon: 'warning',
		        title: '기존 닉네임 입니다.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
	        
	        return;
	    }
    
		$.ajax({
			type: "POST",
			url: "/guest/nickCheck",
			data:{
				guestNickname: $("#guestNickname").val()
			},
			datatype: "JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{	// 닉네임 중복 없음
				    Swal.fire({
				        icon: 'success',
				        title: '사용 가능한 닉네임 입니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    });
				
					isNickChecked = true;
				}
				else if(response.code == 100)
				{	// 닉네임 중복
				    Swal.fire({
				        icon: 'error',
				        title: '중복된 닉네임 입니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    });
				
					$("#guestNickname").focus();
					isNickChecked = false;
				}
				else if(response.code == 400)
				{	// 파라미터 값 없음
				    Swal.fire({
				        icon: 'error',
				        title: '닉네임을 다시 확인해주세요.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    });
				
					$("#guestNickname").focus();
					isNickChecked = false;
				}
				else if(response.code == 500)
				{	// 업데이트 건수 없음
				    Swal.fire({
				        icon: 'error',
				        title: '닉네임 중복 체크 중 오류가 발생하였습니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    });
				
					$("#guestNickname").focus();
					isNickChecked = false;
				}
				else
				{	// 나머지 오류
				    Swal.fire({
				        icon: 'error',
				        title: '닉네임 중복 체크 중 오류가 발생하였습니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    });
				
					$("#guestNickname").focus();
					isNickChecked = false;
				}
			},
			error:function(error){
				icia.common.error(error);
				
			    Swal.fire({
			        icon: 'error',
			        title: '닉네임 중복 체크 중 오류가 발생하였습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    });
				
				isNickChecked = false;
			}
		});
	});
	
	// 수정 완료 버튼 눌렀을 경우
	$("#btnModi").on("click", function(){
		// 공백 정규표현식
		var emptCheck = /\s/g;
		
		// 전화번호 정규표현식
		var telCheck = /^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/;
		
		// 비밀번호 정규식: 8~20자, 1개이상의 특수기호 포함
		var PwdCheck = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,20}$/;
		
		// 닉네임 정규식: 2~16자, 영어 또는 숫자 또는 한글(한글 초성과 모음은 불가능)
		var nickCheck = /^[a-zA-Z0-9가-힣]{2,15}$/;
		
		// 비밀번호 입력 체크
		if($.trim($("#guestPassword1").val()).length <= 0)
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '비밀번호를 입력하세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestPassword1").val("");
			$("#guestPassword1").focus();
			return;
		}
		
		// 비밀번호 정규식표현 체크
		if(!PwdCheck.test($("#guestPassword1").val()))
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '영문/숫자/특수문자 조합 8-20자로 입력해 주세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestPassword1").focus();
			return;
		}
		
		// 비밀번호 확인 입력 체크
		if($.trim($("#guestPassword2").val()).length <= 0)
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '비밀번호 확인을 입력하세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestPassword2").val("");
			$("#guestPassword2").focus();
			return;
		}
		
		// 비밀번호 일치 체크
		if($("#guestPassword1").val() != $("#guestPassword2").val())
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '비밀번호가 일치하지 않습니다.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestPassword2").focus();
			return;
		}
		
		// 비밀번호 hidden값에 넣기
		$("#guestPassword").val($("#guestPassword1").val());
		
		// 닉네임 입력 체크
		if($.trim($("#guestNickname").val()).length <= 0)
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '닉네임을 입력하세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestNickname").val("");
			$("#guestNickname").focus();
			return;
		}
		
		// 전화번호 입력 체크
		if($.trim($("#guestTel").val()).length <= 0)
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '전화번호를 입력하세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestTel").val("");
			$("#guestTel").focus();
			return;
		}
		
		// 전화번호 정규표현식 확인
		if(!telCheck.test($("#guestTel").val()))
		{
		    Swal.fire({
		        icon: 'warning',
		        title: '전화번호 형식이 올바르지 않습니다.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
			$("#guestTel").focus();
			return;
		}
		
		// 닉네임이 변경되었고, 중복확인을 하지 않았다면 요청 중단
	    const currentNickname = $("#guestNickname").val();	// 변경할 닉네임
		    
	    if (currentNickname != initialNickname && !isNickChecked)
	    {
		    Swal.fire({
		        icon: 'warning',
		        title: '닉네임 중복확인을 해주세요.',
		        text: '',			        
		        confirmButtonColor: '#71D3BB'
		    });
		    
	        return false;
	    }
		
		// 회원 정보 수정 aJax multipart
		let form = $("#updateForm")[0];
		let formData = new FormData(form);
		
		$.ajax({
			type:"POST",
			enctype:"multipart/form-data",
			url:"/guest/updateProc",
			data: formData,
			processData:false,
			contentType:false,
			cache:false,
			timeout:600000,
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response){
				if(response.code == 0)
				{
				    Swal.fire({
				        icon: 'success',
				        title: '회원정보가 수정되었습니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    }).then((result) => {
				        location.href = "/guest/updateForm"
				    });
				}
				else if(response.code == 400)
				{
				    Swal.fire({
				        icon: 'error',
				        title: '비밀번호가 없습니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    }).then((result) => {
				        location.href = "/guest/loginForm"
				    });
				    
					$("#guestPassword1").focus();
				}
				else if(response.code == 404)
				{
				    Swal.fire({
				        icon: 'error',
				        title: '회원정보가 존재하지 않습니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    }).then((result) => {
				        location.href = "/guest/loginForm"
				    });
				}
				else if(response.code == 410)
				{
				    Swal.fire({
				        icon: 'error',
				        title: '로그인이 되어있지 않습니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    }).then((result) => {
				        location.href = "/guest/loginForm"
				    });
				}
				else if(response.code == 430)
				{
				    Swal.fire({
				        icon: 'error',
				        title: '회원 이메일 계정 정보가 다릅니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    }).then((result) => {
				        location.href = "/guest/updateForm"
				    });				    
				}
				else if(response.code == 500)
				{
				    Swal.fire({
				        icon: 'error',
				        title: '회원정보수정 중 오류가 발생하였습니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    }).then((result) => {
				        location.href = "/guest/updateForm"
				    });				    
				    
					$("#guestPassword1").focus();
				}
				else
				{
				    Swal.fire({
				        icon: 'error',
				        title: '회원정보수정 중 오류가 발생하였습니다.',
				        text: '',			        
				        confirmButtonColor: '#71D3BB'
				    }).then((result) => {
				        location.href = "/guest/updateForm"
				    });
				    
					$("#guestPassword1").focus();
				}
			},
			error:function(xhr, status, error){
				icia.common.error(error);
			    Swal.fire({
			        icon: 'error',
			        title: '서버 통신 중 오류가 발생하였습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/updateForm"
			    });
			}
		});		
	});
	
	$("#guestNickname").on("input", function() {
		const currentNickname = $("#guestNickname").val();	// 변경할 닉네임
		if (currentNickname != initialNickname)
		{
		    isNickChecked = false; // 닉네임 변경 시 중복 확인 상태 초기화
		}
	});
});

function fn_guestDelete()
{
	// 회원탈퇴 aJax
	$.ajax({
		type: "POST",
		url: "/guest/deleteProc",
		datatype: "JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{
			    Swal.fire({
			        icon: 'success',
			        title: '회원 탈퇴가 완료되었습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/loginForm"
			    });
			}
			else if(response.code == -99)
			{
			    Swal.fire({
			        icon: 'error',
			        title: '이미 정지된 회원입니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/logout"
			    });
			}
			else if(response.code == 404)
			{
			    Swal.fire({
			        icon: 'error',
			        title: '이미 정지된 회원입니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/logout"
			    });
				alert("회원정보가 존재하지 않습니다.");
				location.href = "/guest/logout";
			}
			else if(response.code == 410)
			{
			    Swal.fire({
			        icon: 'error',
			        title: '로그인이 되어있지 않습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/logout"
			    });
			}
			else if(response.code == 500)
			{
			    Swal.fire({
			        icon: 'error',
			        title: '회원탈퇴 중 오류가 발생하였습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			    	location.href = "/guest/updateForm"
			    });
			}
			else
			{
			    Swal.fire({
			        icon: 'error',
			        title: '회원탈퇴 중 오류가 발생하였습니다.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB'
			    }).then((result) => {
			        location.href = "/guest/updateForm"
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
		        location.href = "/guest/updateForm"
		    });
		}
	});
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
			<div class="points-coupons"></div>

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
        <h1>회원정보수정</h1>
        <form method="post" name="updateForm" id="updateForm" enctype="multipart/form-data">
                           
        <div class="container">
        	<div class="profile-group">
                    <div class="profile-picture">
                        <!-- 기본 프로필 사진 -->
                        <img id="profileImg" name="profileImg" src="/resources/images/guest/upload/${hexGuestEmail}.png" alt="Profile Picture" onerror="this.src='https://via.placeholder.com/120';"	title="프로필 사진은 .png 파일만 가능합니다.">
                        <!-- 아이콘 -->
                        <div class="icon" id="icon-upload">
                            <!-- 아이콘 SVG 삽입 -->
                            <img id="svgImg" src="/resources/images/guest/icon/my_profile_edit.svg" alt="Upload Icon">
                        </div>
                        <!-- 파일 선택 입력 -->
                        <input type="file" id="fileInput" name="fileInput" accept="image/png">
                        
                    </div>
                </div>
                
               <div class="update-container">                
                    <div class="updateForm-group">
	                    <label for="email">이메일</label>
	                    <input type="text" id="guestEmail" name="guestEmail" value="${guest.guestEmail}" readonly>
	                </div>
	                <div class="updateForm-group">
	                    <label for="password">새 비밀번호</label>
	                    <input type="password" id="guestPassword1" name="guestPassword1" value="${guest.guestPwd}" autoComplete="off">
	                </div>
	                <div class="updateForm-group">
	                    <label for="password">새 비밀번호 확인</label>
	                    <input type="password" id="guestPassword2" name="guestPassword2" value="${guest.guestPwd}" autoComplete="off">
	                </div>
	                <div class="updateForm-group2">
	                    <label for="nickname">닉네임</label><br />
	                    <input type="text" id="guestNickname" name="guestNickname" value="${guest.guestNickname}">
	                    <button type="button" id="nickCheck">중복확인</button>	                    
	                </div>
	                <div class="updateForm-group">
	                    <label for="tel">전화번호</label>
	                    <input type="text" id="guestTel" name="guestTel" value="${guest.guestTel}">
	                </div>
	                <div class="updateForm-group">
	                    <label for="birth">생년월일</label>
	                    <input type="text" id="guestBirth" name="guestBirth" value="${guest.guestBirth}" disabled>
	                </div>
                </div>
             
                <!-- 원래 탈퇴, 수정 버튼 자리 -->
        </div>        
  
        <div class="btndel">
        	<button type="button" id="btnDel" class="btnDel">회원 탈퇴 ></button>
        </div>

       <div class="buttons">
           <button type="button" id="btnModi" class="btnModi">수정 완료</button>
       </div>
        
        <input type="hidden" id="guestPassword" name="guestPassword" value="${guest.guestPwd}" />
     </form>
    
    </div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
