<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/guest/changePwdForm.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

    <div class="titles">
        <h3>비밀번호 변경하기</h3>
    </div>

    <div class="find-container">
        <form>
            <div class="form-group">
                <label for="password">새 비밀번호</label>
                <input type="password" id="guestPwd1" name="guestPwd1" value="" oninput="checkPwd1();" placeholder="영문/숫자/특수문자 조합 8-20자로 입력해 주세요." required>
                <input type="hidden" id="pwdFlag" value="">
                <div style="display: flex; margin-left: 70px; margin-top: 5px;"><small id="pwd1Note"></small></div>
                
            </div>
            <div class="form-group">
                <label for="password">새 비밀번호 확인</label>
                <input type="password" id="guestPwd2" name="guestPwd2" value="" placeholder="비밀번호 확인" required>
            </div>
			<input type="hidden" value="" id="guestPwd">
            <button type="button" id="btnUpdatePwd" class="btnUpdatePwd" onclick="updatePwd()">변경</button>
        </form>
        
        <script type="text/javascript">
        	function updatePwd(){
        		if($("#pwdFlag") == "0"){
        			Swal.fire({
    			        icon: 'error',
    			        title: '옳지 않은 형식의 비밀번호 입니다.',
    			        text: '',			        
    			        confirmButtonColor: '#71D3BB',
    			        customClass: { container: 'my-alert-container' }
    			    });
    			    
    			    setTimeout(function() {
    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
    			    }, 10);
    			    
        			$("#pwd1Note").text("");
        			$("#guestPwd1").focus();
        			$("#guestPwd1").value("");
        			return;
        		}
        		
        		if ($("#guestPwd1").val() != $("#guestPwd2").val()){
        			Swal.fire({
    			        icon: 'error',
    			        title: '비밀번호가 일치하지 않습니다.',
    			        text: '',			        
    			        confirmButtonColor: '#71D3BB',
    			        customClass: { container: 'my-alert-container' }
    			    });
    			    
    			    setTimeout(function() {
    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
    			    }, 10);
    			    
    				$("#pwd1Note").text("");
    				$("#pwdFlag").val("0");
        			$("#guestPwd1").focus();
        			$("#guestPwd1").value("");
        			$("#guestPwd2").value("");
    				return;
    			}
        		
        		$("#guestPwd").val($("#guestPwd1").val());
        		
        		$.ajax({
    	   			type: "POST",
    	   			url: "/guest/updatePwdProc",
    	   			data: {
    	   				guestEmail: sessionStorage.getItem('guestEmail'),
    	   				guestPwd: $("#guestPwd").val()
    	   			},
    	   			datatype: "JSON",
    	   			beforeSend: function(xhr){
    	   				xhr.setRequestHeader("AJAX","true");
    	   			},
    	   			success: function(response){
    	   				icia.common.log(response);
    	   				if(response.code == 1){
    	   					Swal.fire({
		    			        icon: 'success',
		    			        title: '비밀번호가 변경되었습니다.',
		    			        text: '',			        
		    			        confirmButtonColor: '#71D3BB',
		    			        customClass: { container: 'my-alert-container' }
		    			    }).then((result) => {
		    			        location.href = "/guest/loginForm"
		    			    });
		    			    
		    			    setTimeout(function() {
		    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
		    			    }, 10);
    	   				}
    	   				else{
    	   					Swal.fire({
    	    			        icon: 'error',
    	    			        title: '비밀번호 변경 중 오류가 발생하였습니다.',
    	    			        text: '',			        
    	    			        confirmButtonColor: '#71D3BB',
    	    			        customClass: { container: 'my-alert-container' }
    	    			    });
    	    			    
    	    			    setTimeout(function() {
    	    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
    	    			    }, 10);	
    	   				}
    	   			},
    	   			complete:function(data){
    	   				icia.common.log(data);
    	   			},
    	   			error: function(xhr, status, error){
    	   				icia.common.error(error);
    	   			}
        		});
        	}
        	
        	function checkPwd1(){
        		let pwd1Reg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,20}$/;
        		
        		$("#pwdFlag").val("0");
    			$("#pwd1Note").text("");
    			
        		if(!pwd1Reg.test($("#guestPwd1").val())){
        			$("#pwd1Note").css("color", "red");
        			$("#pwd1Note").css("font-size", "12px");
        			$("#pwd1Note").css("margin-bottom", "10px");
        			$("#pwd1Note").text("영문/숫자/특수문자 조합 8-20자로 입력해 주세요.");
        			return;
        		}
        		$("#pwdFlag").val("1");
        	}
        </script>
        
    </div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>