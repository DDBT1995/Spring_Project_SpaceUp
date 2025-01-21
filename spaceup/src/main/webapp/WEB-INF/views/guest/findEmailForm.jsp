<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/resources/css/guest/findEmailForm.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<div class="titles">
		<h3>이메일 찾기</h3>
	</div>

	<div class="find-container">
		<form>
			<div class="form-group">
				<label for="tel">전화번호</label> <input type="text" id="guestTel" name="guestTel" value="" placeholder="ex&#41;01011112222" required>
			</div>
		</form>

		<button type="button" id="btnFindEmail" class="btnFindEmail" onclick="findGuestEmail()">찾기</button>
		<script type="text/javascript">
		
			function findGuestEmail(){
				$.ajax({
					type:"POST",
					url:"/guest/findEmailProc",
					data:{
						guestTel:$("#guestTel").val()
					},
					datatype:"JSON",
					beforeSend:function(xhr){
						xhr.setRequestHeader("AJAX","true");
					},
					success:function(response){
						if(response.code == 1){
							location.href = "/guest/showEmailForm"
						}
						else if(response.code == 0 || response.code == 400){
							Swal.fire({
		    			        icon: 'error',
		    			        title: '일치하는 회원정보가 없습니다.',
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
		    			        icon: 'error',
		    			        title: '이메일 찾기 중 오류가 발생하였습니다.',
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
					error:function(xhr, status, error){
						icia.common.error(error);
					}
				});
			}        
        </script>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>

</body>
</html>