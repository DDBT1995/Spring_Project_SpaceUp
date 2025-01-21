<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/guest/findPwdForm.css">

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
        <h3>비밀번호 찾기</h3>
    </div>

    <div class="find-container">
        <form>
            
            <div class="alret">가입하신 이메일 주소로 온 인증번호를 입력하시면,
                               비밀번호 재설정 화면으로 전환됩니다.
            </div>
                 
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" id="guestEmail" name="guestEmail" value="" placeholder="이메일을 입력해 주세요."/>&nbsp;
					<button type="button" id="btnSendAuthCode" class="btnOk" onclick="emailDupChk()" class="btnSendAuthCode">인증하기</button>
            </div>
            <div id="emailAuthDiv" class="form-group" style="display: none;">
                <input type="text" id="guestAuthCode" name="guestAuthCode" value="" placeholder="인증코드를 입력해 주세요."/>&nbsp;
                <button type="button" id="btnCheckAuthCode" class="btnCertify" onclick="checkAuthCode()" style="background: rgb(54 132 188 / 80%);">확인</button>
				<div id="timerDisplay" style="display: flex; margin-left: 50px; margin-top: 5px; color: red;">남은 시간 05:00</div>
            </div>
            <script type="text/javascript">
	            var timer; // 타이머 변수
	        	var timeLeft = 300; // 5분 (300초)
	        	
	        	function emailDupChk(){
					$.ajax({
            			type: "POST",
            			url: "/guest/emailDupChk",
            			data: {
        	        		guestEmail: $("#guestEmail").val()
            			},
            			datatype: "JSON",
            			beforeSend: function(xhr){
            				xhr.setRequestHeader("AJAX","true");
            			},
            			success: function(response){
            				console.log(response);
            				
            				if(response.code == 0){
            					sendAuthCode();
            				}
            				else{
            					Swal.fire({
    		    			        icon: 'error',
    		    			        title: '등록되지 않은 이메일 입니다.',
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
	        	
	        	//인증하기 버튼 클릭 시 인증 메일 전송
                function sendAuthCode(){
            		//이메일 전송
            		$.ajax({
        				type: "POST",
        	        	url: "/guest/emailAuth",
        	        	data: {
        	        		guestEmail: $("#guestEmail").val()
        	        	},
        	        	dataType : 'json',
        	        	success : function(response) {
        	        		if(response.code == 1){
        	        			Swal.fire({
			    			        icon: 'success',
			    			        title: '인증 코드가 전송 되었습니다.',
			    			        text: '',			        
			    			        confirmButtonColor: '#71D3BB',
			    			        customClass: { container: 'my-alert-container' }
			    			    });
			    			    
			    			    setTimeout(function() {
			    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
			    			    }, 10);
	        	    			
	    						$("#btnSendAuthCode").text("재전송");
	    						$("#guestAuthCode").val("");
	        	    			$('#emailAuthDiv').css('display', 'block');  // display를 flex로 변경하여 보이게 함
	    						$('#guestAuthCode').text("");
	    						
	        	    			if (timer) {
	        	    				clearInterval(timer); // 이전 타이머 종료
	    				        }
	    				        // 타이머 시간 초기화 (5분)
	    				        timeLeft = 300;
	    						startTimer();  // 타이머 시작
        	        		}
        	        		
        	        		else{
        	        			alert(response.msg);
        	        		}
        	       		}
        	        });             		
				}
	        	
	        	function startTimer() {
                    // 타이머가 이미 실행 중이면 다시 시작하지 않도록 막음
                    if (timer) clearInterval(timer);

                    // 1초마다 타이머 업데이트
                    timer = setInterval(function() {
                        var minutes = Math.floor(timeLeft / 60);
                        var seconds = timeLeft % 60;

                        // 타이머 표시 업데이트
                        $('#timerDisplay').text('남은 시간 ' + formatTime(minutes) + ':' + formatTime(seconds));

                        // 시간이 끝났을 때 처리
                        if (timeLeft <= 0) {
                            clearInterval(timer); // 타이머 멈춤
                            $('#emailAuthDiv').css('display', 'none'); // 인증 버튼 비활성화
                        } else {
                            timeLeft--; // 남은 시간 1초씩 차감
                        }
                    }, 1000);  // 1초마다 실행
                }

                // 시간을 2자리 형식으로 표시하는 함수
                function formatTime(time) {
                    return time < 10 ? '0' + time : time;
                }
                
             // 인증 코드 확인
                function checkAuthCode() {
                    // 인증 코드 검증 로직 추가
                	$.ajax({
            			type: "POST",
            			url: "/guest/verifyAuthCode",
            			data: {
            				guestAuthCode: $("#guestAuthCode").val()
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
			    			        title: '인증이 완료되었습니다.',
			    			        text: '',			        
			    			        confirmButtonColor: '#71D3BB',
			    			        customClass: { container: 'my-alert-container' }
			    			    });
			    			    
			    			    setTimeout(function() {
			    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
			    			    }, 10);
			    			    
            					sessionStorage.setItem('guestEmail', $("#guestEmail").val());
            					location.href="/guest/changePwdForm";
            				}
            				else{
            					Swal.fire({
    		    			        icon: 'error',
    		    			        title: '인증번호가 일치하지 않습니다.',
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
            </script>
        </form>
    </div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>