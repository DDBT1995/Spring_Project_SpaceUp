<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/guest/likeyList.css">
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
            <h1>좋아요</h1>
            
           	<c:if test="${empty list}">
			    <div class="nono">
			    	<img src="/resources/images/guest/icon/empty_v2.png" />
			    	<p>좋아요 내역이 없습니다.</p>
			    </div>	
			</c:if>
<!---------------------------------------- 추가/변경한 부분 : aJax도 아래 있음 -------------------------------------------------------------->
			<!-- 좋아요 내역 -->	
            <div class="space-list">
              <c:forEach var="likey" items="${list}" varStatus="status">
                <div class="space-card">
                	<!-- 좋아요 버튼(이미지) -->
                    <button id="likeButton-${likey.spaceId}" type="button" class="likey-status" onclick="fn_AddLikey(${likey.spaceId})">
                        <img id="likeyImg-${likey.spaceId}" src="/resources/images/guest/icon/heart_filled.png" alt="좋아요" class="likey_Image"
                        style="width: 43px; height: 43px;">
                    </button>                    
                    <img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${likey.spaceType}/${likey.spaceId}/${likey.spaceId}_1.jpg" alt="공간 이미지" onerror="this.src='https://via.placeholder.com/300';">
<!---------------------------------------- 여기까지 -------------------------------------------------------------->
                    <div class="space-info"  onclick="fn_spaceView(${likey.spaceId})">
	                    <div class="space-title">
	                    	<h3>${likey.spaceName}</h3>                    
	                    </div>
	                    <hr>
	                    <p>${likey.hostNickname}</p>
	                    <div class="details">
	                        <p>${likey.spaceAddr}</p>	                        
	                    </div>
	                    <div class="price">
	                    	<fmt:formatNumber pattern="#,###">${likey.spaceHourlyRate}</fmt:formatNumber>원 / 시간
	                    </div>
                    </div>                    
                </div>
              </c:forEach>
            </div>
            
			<!-- 페이징 버튼 추가 -->
            <div class="pagination">
	            <c:if test="${!empty paging}">
	            	<!-- 이전 블럭 버튼 -->
	            	<c:if test="${paging.prevBlockPage gt 0}">	
		                <a class="prev" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">
		                	<img src="/resources/images/guest/icon/left_arrow.png" />
		                </a>
		            </c:if>
		            
		            <!-- 숫자 버튼 -->
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
				      <c:choose>
				      	<c:when test="${i ne curPage}"> 
		                	<a class="btn" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a>
						</c:when>
        				<c:otherwise>
				        	<a class="btn active" href="javascript:void(0)" onclick="fn_list(${i})" style="cursor:default;">${i}</a>
					  	</c:otherwise>
					  </c:choose>
					</c:forEach>
		            
		            <!-- 다음 블럭 버튼 -->    
		            <c:if test="${paging.nextBlockPage gt 0}">
		                <a class="next" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">
		                	<img src="/resources/images/guest/icon/right_arrow.png" />
		                </a>
		            </c:if>
	            </c:if>
            </div>            
        </div>
    </div>
    
    <!-- 폼 데이터 -->
	<form name="resForm" id="resForm" method="post">
		<input type="hidden" id="sapceId" name="sapceId" value="" />
		<input type="hidden" id="curPage" name="curPage" value="${curPage}" />
	</form>
	
<script>
function fn_list(curPage)
{
	document.resForm.sapceId.value = "";
	document.resForm.curPage.value = curPage;
	document.resForm.action = "/guest/likeyList";
	document.resForm.submit();
}

/////////////////////////////////////////////////////////////////////
///////////////////////////////추가한 부분///////////////////////////////
/////////////////////////////////////////////////////////////////////
// 좋아요 등록 aJax
function fn_AddLikey(spaceId)
{
	$.ajax({
		type:"POST",
		url:"/guest/addLikey",
		data:{
			spaceId: spaceId
		},
		datatype:"JSON",
        beforeSend:function(xhr){
        	xhr.setRequestHeader("AJAX", "true");
        },
        success:function(response){
        	if(response.code == 0)
       		{            	
        		let likeyImg = document.getElementById("likeyImg-" + spaceId);
        		
        		// 디버깅 출력
                console.log("Response message:", response.msg);
                console.log(document.getElementById("likeyImg-" + spaceId));
                console.log("spaceId:", spaceId);        		
                
                if(String(response.msg) == "Add likey success")
                {
                   	likeyImg.setAttribute("src", "/resources/images/guest/icon/heart_filled.png"); // 좋아요 이미지 변경                   	
                }
                else if(String(response.msg) == "Delete likey success")
                {
                    likeyImg.setAttribute("src", "/resources/images/guest/icon/heart_line.png"); // 좋아요 이미지 변경                                       
                }
             	// 애니메이션 효과 적용                
                likeyImg.classList.add('scale-up-center');

                // 애니메이션이 끝난 후 클래스 제거
                setTimeout(function() {
                    likeyImg.classList.remove('scale-up-center');
                }, 500);
       		}
        	else if(response.code == 400)
        	{
    		    Swal.fire({
    		        icon: 'error',
    		        title: '공간내역이 올바르지 않습니다.',
    		        text: '',			        
    		        confirmButtonColor: '#71D3BB'
    		    }).then((result) => {
    		        location.href = "/guest/likeyList"
    		    });
        	}
        	else if(response.code == 409)
        	{
    		    Swal.fire({
    		        icon: 'error',
    		        title: '이미 좋아요 등록을 하였습니다.',
    		        text: '',			        
    		        confirmButtonColor: '#71D3BB'
    		    }).then((result) => {
    		        location.href = "/guest/likeyList"
    		    });
        		alert("");
        	}
        	else if(response.code == 410)
        	{
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
        	{
    		    Swal.fire({
    		        icon: 'error',
    		        title: '좋아요 등록에 실패하였습니다.',
    		        text: '',			        
    		        confirmButtonColor: '#71D3BB'
    		    }).then((result) => {
    		        location.href = "/guest/likeyList"
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
		        location.href = "/guest/likeyList"
		    });
        }
	});
}

	function fn_spaceView(spaceId) {
	   window.open("/space/spaceView?spaceId="+spaceId, '_blank');
	}
</script>
    
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
