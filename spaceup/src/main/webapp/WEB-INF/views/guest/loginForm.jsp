<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/guest/loginForm.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    
    <script>
		$(document).ready(function(){
			$("#guestEmail").focus();
			
			$("#guestEmail").on("keypress", function(e){
				if(e.which == 13){
					login();
				}
			});
			
			$("#guestPwd").on("keypress", function(e){
				if(e.which == 13){
					login();
				}
			});
		});
		
		function login(){
			if($.trim($("#guestEmail").val()).length <= 0){
				
				Swal.fire({
			        icon: 'warning',
			        title: '이메일을 입력하세요.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB',
			        customClass: { container: 'my-alert-container' }
			    });
				
				// alert창이 생성된 후 10밀리초 대기 후 z-index를 조정
			    setTimeout(function() {
			        document.querySelector('.my-alert-container').style.zIndex = '2100';
			    }, 10);
				
				$("#guestEmail").val("");
				$("#guestEmail").focus();
				return;
			}
			
			if($.trim($("#guestPwd").val()).length <= 0){
				Swal.fire({
			        icon: 'warning',
			        title: '비밀번호를 입력하세요.',
			        text: '',			        
			        confirmButtonColor: '#71D3BB',
			        customClass: { container: 'my-alert-container' }
			    });
				
				// alert창이 생성된 후 10밀리초 대기 후 z-index를 조정
			    setTimeout(function() {
			        document.querySelector('.my-alert-container').style.zIndex = '2100';
			    }, 10);
				$("#guestPwd").val("");
				$("#guestPwd").focus();
				return;
			}
			
			$.ajax({
				type:"POST",
				url:"/guest/loginProc",
				data:{
					guestEmail: $("#guestEmail").val(),
					guestPwd: $("#guestPwd").val()
				},
				datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX","true");
				},
				success:function(response){
					icia.common.log(response);
					
					if(response.code == 1){
						location.href = "/space/spaceMain";
					}
					else if(response.code == 0){
						Swal.fire({
	    			        icon: 'error',
	    			        title: '탈퇴한 회원입니다.',
	    			        text: '',			        
	    			        confirmButtonColor: '#71D3BB',
	    			        customClass: { container: 'my-alert-container' }
	    			    });
	    			    
	    			    setTimeout(function() {
	    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
	    			    }, 10);	
					}
					else if(response.code == -1){
						Swal.fire({
	    			        icon: 'error',
	    			        title: '정지된 회원입니다.',
	    			        text: '',			        
	    			        confirmButtonColor: '#71D3BB',
	    			        customClass: { container: 'my-alert-container' }
	    			    });
	    			    
	    			    setTimeout(function() {
	    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
	    			    }, 10);						
					}
					else{
						Swal.fire({
					        icon: 'warning',
					        title: '이메일 또는 비밀번호를 확인하세요.',
					        text: '',			        
					        confirmButtonColor: '#71D3BB',
					        customClass: { container: 'my-alert-container' }
					    });
						
						// alert창이 생성된 후 10밀리초 대기 후 z-index를 조정
					    setTimeout(function() {
					        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    }, 10);
					}
				},
				complete:function(data){
					icia.common.log(data);
				},
				error:function(xhr, status, error){
					icia.common.error(error);
				}
			});
		}
	</script>
    
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
    <div class="login-container">
        <h5>로그인</h5>
        <img src="/resources/images/logo/logo.png" alt="spaceUp 로고">
        <form>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" id="guestEmail" name="guestEmail" value="" placeholder="이메일" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="guestPwd" name="guestPwd" value="" placeholder="비밀번호" required>
            </div>

            <button type="button" id="btnLogin" class="btnLogin" onclick="login()">로그인</button>
        </form>
        <div class="links">
            <a href="/guest/findEmailForm">이메일 찾기</a> |
            <a href="/guest/findPwdForm">비밀번호 찾기</a> |
            <a href="/guest/regForm"><b>회원가입</b></a>
        </div>
        <div class="footer" style="justify-content: center;">guest HERE</div>
    </div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
