<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/guest/reviewList.css">
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
            <h1>리뷰 관리</h1>
            <div class="reviews">
			    <div class="tabs">
				    <div class="tab reviewable <c:if test='${tab == "reviewable"}'>active</c:if>'" onclick="fn_setTab('reviewable')">
				        작성가능 리뷰 (<span>${totalCount}</span>)
				    </div>
				    <div class="tab myReview <c:if test='${tab == "myReview"}'>active</c:if>'" onclick="fn_setTab('myReview')">
				        작성한 리뷰 (<span>${myReviewCount}</span>)
				    </div>
				</div>
			
			    <!-- 작성 가능한 리뷰 테이블 -->
			    <div class="reviewable-table" style="<c:if test='${tab == "myReview"}'>display:none;</c:if>">
			        <c:if test='${empty reviewable}'>
					    <div class="nono">
					    	<img src="/resources/images/guest/icon/empty_v2.png" />
					    	<p>작성 가능한 리뷰 내역이 없습니다.</p>
					    </div>	
			        </c:if>
			        
			        <c:if test='${!empty reviewable}'>
			            <table class="review-table">
			                <thead>
			                    <tr>
			                        <th>예약번호</th>
			                        <th>예약정보</th>
			                        <th>호스트</th>
			                        <th>이용날짜</th>
			                        <th>리뷰관리</th>
			                    </tr>
			                </thead>
			                <tbody>
			                    <c:forEach var="reviewable" items="${reviewable}" varStatus="status">
			                        <tr>
			                            <td>${reviewable.reservationId}</td>
			                            <td>
			                                <div class="review-details">
			                                <a href="/space/spaceView?spaceId=${reviewable.spaceId}">
			                                    <img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${reviewable.spaceType}/${reviewable.spaceId}/${reviewable.spaceId}_1.jpg" onerror="this.src='https://via.placeholder.com/50'" alt="상품 이미지" style="width:120px; height:80px;">
			                                    <div>
			                                        <b>${reviewable.spaceName}</b><br>
			                                        <span style="font-size: 12px; color: gray;">${reviewable.spaceAddr}</span>
			                                    </div>
			                                </a>
			                                </div>
			                            </td>
			                            <td>${reviewable.hostNickname}</td>
			                            <td>${reviewable.useDate}</td>
			                            <td>
			                                <button class="manage-btn" id="btnReview" data-reservationId="${reviewable.reservationId}" onclick="fn_submitReview(${reviewable.reservationId})">작성</button>
			                            </td>
			                        </tr>
			                        
			                        <!-- 리뷰 쓰기 -->											    
								    <div id="QnAOverlay_${reviewable.reservationId}" class="QnAOverlay" style="display: none;">
									    <!-- 흰색 슬라이드 div -->
									    <div id="QnASlideUpDiv_${reviewable.reservationId}" class="QnASlideUpDiv" style="display: none;">
									        <div id="QnAHeaderDiv" class="QnAHeaderDiv">
									       		<span style="font-size: 16px; font-weight: bold; color: rgb(27, 29, 31); width: 100%; text-align: center;">리뷰 내용을 적어주세요</span>
									        	<button id="btnQnAClose" class="btnQnAClose" data-reservationId="${reviewable.reservationId}" onclick="fn_closeReview(${reviewable.reservationId})" style="width: fit-content; position: absolute; top: 23px; right: 26px; background: transparent; border: none; outline:none; cursor: pointer;">
									        		<img src="/resources/images/space/icon/close.svg" style="display: block; width: 18px;">
									        	</button>
									        </div>
									        
									        <div class="QnAHeaderDiv" id="QnAHeaderDiv">
									       		<span style="font-size: 12px; font-weight: bold; color: #828181b3; width: 100%; text-align: center;">
								       				<br>
					                                <span class="reviewScore" id="reviewScore_${reviewable.reservationId}">
					                                    <img src="/resources/images/space/icon/starGray.svg" class="star1" data-value="1" data-reservationId="${reviewable.reservationId}">
					                                    <img src="/resources/images/space/icon/starGray.svg" class="star1" data-value="2" data-reservationId="${reviewable.reservationId}">
					                                    <img src="/resources/images/space/icon/starGray.svg" class="star1" data-value="3" data-reservationId="${reviewable.reservationId}">
					                                    <img src="/resources/images/space/icon/starGray.svg" class="star1" data-value="4" data-reservationId="${reviewable.reservationId}">
					                                    <img src="/resources/images/space/icon/starGray.svg" class="star1" data-value="5" data-reservationId="${reviewable.reservationId}">
					                                </span>
									       		</span>
									        </div>
									        
									        <div id="QnAContentHeaderDiv" class="QnAContentHeaderDiv">
									        	<div>
									        		<span>내용</span>
									        	</div>
									        	<div>
									        		<span class="inputQuestionCount" id="inputQuestionCount">0</span><span>/200자</span>
									        	</div>
									        </div>
									        
									        <div id="QnAContentDiv_${reviewable.reservationId}" class="QnAContentDiv">
									        	<textarea id="reviewContent_${reviewable.reservationId}" name="reviewContent" class="reviewContent" maxlength="200" placeholder="리뷰를 작성하기 전에 확인해주세요!&#10;&#10;・ 리뷰는 공개 상태로만 등록할 수 있어요.&#10;・ 개인정보를 공유 또는 요구하거나 아워플레이스를 통하지 않은 직거래 유도, 비방/욕설/명예훼손성 글을 등록하면 사전에 고지 없이 삭제 조치 될 수 있으며 서비스 이용에 제약이 있을 수 있습니다." style=" font-size: 14px; border: none; outline: none; width: 100%; resize: none; line-height: 1.5;" spellcheck="false"></textarea>
									        </div>
									        
									        <div id="QnaFooterDiv" class="QnaFooterDiv">
									        	<button class="submitWrite" id="submitWrite" style="color: white; font-weight: bold;" onclick="fn_submitWrite(${reviewable.reservationId})">작성하기</button>
									        </div>
									    </div>
									</div>								
			                    </c:forEach>
			                </tbody>
			            </table>
			        </c:if>
     
     				<script>
				        $(document).ready(function () {
				        	// 글자 수
				            const maxLength = 200; // 최대 글자 수
			
				            $(".QnAContentDiv textarea").on("input", function () {
				                const textLength = $(this).val().length; // 입력된 글자 수
				                const $counter = $("#inputQuestionCount");
			
				                $counter.text(textLength); // 글자 수 업데이트
			
				                // 글자 수 제한 초과 여부 확인
				                if (textLength >= maxLength) {
				                    $counter.addClass("over-limit"); // 빨간색 클래스 추가
				                } else {
				                    $counter.removeClass("over-limit"); // 클래스 제거
				                }
				            });
				            
				            
			                // 별 클릭 이벤트
			                $(".star1").on("click", function () {
			                    const clickedValue = $(this).data("value"); // 클릭된 별의 값
			                    const reservationId = $(this).data("reservationid"); // 클릭된 별의 reservationId

			                    // 해당 reviewScore 영역 선택
			                    const $reviewScore = $("#reviewScore_" + reservationId);
			                    
			                    // 별점 값 저장
			                    $reviewScore.attr("data-score", clickedValue);

			                    // 모든 별을 회색으로 초기화
			                    $reviewScore.find(".star1").removeClass("active");

			                    // 클릭된 별까지 노란색으로 표시
			                    $reviewScore.find(".star1").each(function () {
			                        if ($(this).data("value") <= clickedValue) {
			                            $(this).addClass("active");
			                        }
			                    });

			                    console.log("Reservation ID: " + reservationId + ", 선택된 별점: " + clickedValue);
			                });
			            });

					</script>
			        
			        <script type="text/javascript">												        
				     	// 리뷰창 열기 함수
						function fn_submitReview(reservationId) {
						    console.log("Opening Review for reservationId:", reservationId);
						    
						    // Overlay와 해당 리뷰 창 선택
						    const overlay = document.getElementById("QnAOverlay_" + reservationId);
						    const slideUpDiv = document.getElementById("QnASlideUpDiv_" + reservationId);
						
						    // 리뷰 창 열기
						    if (overlay && slideUpDiv) {
						        overlay.style.display = "block"; // 배경 표시
						        slideUpDiv.style.display = "block"; // 리뷰창 표시
						        slideUpDiv.style.bottom = "200px"; // 슬라이드 업
						    } else {
						        console.error(`Elements for reservationId ${reservationId} not found.`);
						    }
						}
						
						function fn_closeReview(reservationId) {
						    console.log("Closing Review for reservationId:", reservationId);
						
						    // Overlay와 해당 리뷰 창 선택
						    const overlay = document.getElementById("QnAOverlay_" + reservationId);
						    const slideUpDiv = document.getElementById("QnASlideUpDiv_" + reservationId);
						
						    // 별점 영역 및 내용 초기화
						    const reviewScore = document.getElementById("reviewScore_" + reservationId);
						    const reviewContent = document.getElementById("reviewContent_" + reservationId);
						    
						    // 리뷰 창 닫기
						    if (overlay && slideUpDiv) {
						        slideUpDiv.style.bottom = "-100%"; // 슬라이드 다운 효과
						        setTimeout(() => {
						            slideUpDiv.style.display = "none";
						            overlay.style.display = "none"; // 배경 숨기기
						            
						            // 별점 초기화
						            if (reviewScore) {
						                reviewScore.setAttribute("data-score", "0"); // data-score 값 초기화
						                const stars = reviewScore.querySelectorAll(".star1"); // 별 이미지 선택
						                stars.forEach((star) => star.classList.remove("active")); // 노란색 별 제거
						            }

						            // 내용 초기화
						            if (reviewContent) {
						                reviewContent.value = ""; // 리뷰 내용 비우기
						            }
						        }, 300); // 애니메이션을 위한 딜레이
						    } else {
						        console.error(`Elements for reservationId ${reservationId} not found.`);
						    }
						}
				        
				        // "작성하기" 눌렀을 때(리뷰 작성)
				        function fn_submitWrite(reservationId)
				        {
				        	console.log("reservationId:", reservationId); // 예약 ID 확인
				        	
				            var reviewContent = document.querySelector("#reviewContent_" + reservationId + ".reviewContent").value;    
				            				            
				            if ($.trim(reviewContent).length <= 0) {
			    			    Swal.fire({
			    			        icon: 'warning',
			    			        title: '내용을 입력하세요.',
			    			        text: '',			        
			    			        confirmButtonColor: '#71D3BB',
			    			        customClass: { container: 'my-alert-container' }
			    			    });
			    			    
			    			 	// alert창이 생성된 후 10밀리초 대기 후 z-index를 조정
			    			    setTimeout(function() {
			    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
			    			    }, 10);
			    			    
				                $(".reviewContent").focus();
				                return;
				            }
				            
				            // 별점 값 가져오기
				            var reviewScore = $("#reviewScore_" + reservationId).attr("data-score"); // data-score 속성에서 값 가져오기

				            // 별점 유효성 검사
				            if (!reviewScore || reviewScore == "0") {
			    			    Swal.fire({
			    			        icon: 'warning',
			    			        title: '별점을 선택하세요.',
			    			        text: '',			        
			    			        confirmButtonColor: '#71D3BB',
			    			        customClass: { container: 'my-alert-container' }
			    			    });
				    			    
			    			 	// alert창이 생성된 후 10밀리초 대기 후 z-index를 조정
			    			    setTimeout(function() {
			    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
			    			    }, 10);
			    			    
			    			    return;
				            }

				            console.log("리뷰 내용: ", reviewContent);
				            console.log("별점: ", reviewScore);
	
				        	// 리뷰 작성 aJax
				        	$.ajax({
				    			type:"POST",
				    			url:"/guest/insertReview",
				    			data:{
				    				reservationId: reservationId,
				    				reviewContent: reviewContent,
				    				reviewScore: reviewScore
				    			},
				    			datatype:"JSON",
				    			beforeSend:function(xhr){
				    	            xhr.setRequestHeader("AJAX", "true");
				    			},
				    			success:function(response){
				    				if(response.code == 0)
				    				{
					    			    Swal.fire({
					    			        icon: 'success',
					    			        title: '작성이 완료되었습니다.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    }).then((result) => {
					    			        location.href = "/guest/reviewList"
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
					    			}
				    				else if(response.code == 404)
				    				{
					    			    Swal.fire({
					    			        icon: 'error',
					    			        title: '로그인 되지 않았습니다.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    }).then((result) => {
					    			        location.href = "/guest/reviewList"
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
				    				}
				    				else if(response.code == 410)
				    				{
					    			    Swal.fire({
					    			        icon: 'error',
					    			        title: '예약 내역이 존재하지 않습니다.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    }).then((result) => {
					    			        location.href = "/guest/reviewList"
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
				    				}
				    				else if(response.code == 500)
				    				{
					    			    Swal.fire({
					    			        icon: 'error',
					    			        title: '리뷰 등록 중 오류가 발생하였습니다.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    }).then((result) => {
					    			        location.href = "/guest/reviewList"
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
				    				}
				    				else
				    				{
					    			    Swal.fire({
					    			        icon: 'error',
					    			        title: '리뷰 등록 중 오류가 발생하였습니다.',
					    			        text: '',			        
					    			        confirmButtonColor: '#71D3BB',
					    			        customClass: { container: 'my-alert-container' }
					    			    }).then((result) => {
					    			        location.href = "/guest/reviewList"
					    			    });
					    			    
					    			    setTimeout(function() {
					    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
					    			    }, 10);
				    				}
				    			},
				    			error:function(xhr){
				    	            icia.common.error(error);
				    			    Swal.fire({
				    			        icon: 'error',
				    			        title: '서버 통신 중 오류가 발생하였습니다.',
				    			        text: '',			        
				    			        confirmButtonColor: '#71D3BB',
				    			        customClass: { container: 'my-alert-container' }
				    			    }).then((result) => {
				    			        location.href = "/guest/reviewList"
				    			    });
				    			    
				    			    setTimeout(function() {
				    			        document.querySelector('.my-alert-container').style.zIndex = '2100';
				    			    }, 10);
				    			}
				    		});
				        }
			    	</script>
        
             		<!-- 작성 가능한 리뷰 페이징 -->
					<div class="pagination reviewable-pagination">
					    <c:if test="${!empty paging}">
					        <c:if test="${paging.prevBlockPage > 0}">
					            <a class="prev" href="javascript:void(0)" onclick="fn_reviewableList(${paging.prevBlockPage})">
					                <img src="/resources/images/guest/icon/left_arrow.png" />
					            </a>
					        </c:if>
					
					        <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
					            <c:choose>
					                <c:when test="${i != paging.curPage}">
					                    <a class="btn" href="javascript:void(0)" onclick="fn_reviewableList(${i})">${i}</a>
					                </c:when>
					                <c:otherwise>
					                    <a class="btn active" href="javascript:void(0)" style="cursor:default;">${i}</a>
					                </c:otherwise>
					            </c:choose>
					        </c:forEach>
					
					        <c:if test="${paging.nextBlockPage > 0}">
					            <a class="next" href="javascript:void(0)" onclick="fn_reviewableList(${paging.nextBlockPage})">
					                <img src="/resources/images/guest/icon/right_arrow.png" />
					            </a>
					        </c:if>
					    </c:if>
					</div>
    			</div>

			    <!-- 작성한 리뷰 테이블 -->
			    <div class="my-review-list-table" style="<c:if test='${tab == null || tab == "reviewable"}'>display:none;</c:if>">
			        <c:if test='${empty myReviewList}'>
					    <div class="nono">
					    	<img src="/resources/images/guest/icon/empty_v2.png" />
					    	<p>작성한 리뷰 내역이 없습니다.</p>
					    </div>	
			        </c:if>
			        
			        <c:if test='${!empty myReviewList}'>
			            <table class="review-table">
			                <thead>
			                    <tr>
			                        <th>작성일</th>
			                        <th>예약정보</th>
			                        <th>리뷰내용</th>
			                        <th>리뷰관리</th>
			                    </tr>
			                </thead>
			                <tbody>
			                    <c:forEach var="myReviewList" items="${myReviewList}" varStatus="status">
			                        <tr>
			                            <td>${myReviewList.regDate}</td>
			                            <td>
			                                <div class="review-details">
			                                <a href="/space/spaceView?spaceId=${myReviewList.spaceId}">
			                                    <img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${myReviewList.spaceType}/${myReviewList.spaceId}/${myReviewList.spaceId}_1.jpg" onerror="this.src='https://via.placeholder.com/100'" alt="상품 이미지" style="width:120px; height:80px;">
			                                    <div>
			                                        <b>${myReviewList.spaceName}</b><br>
			                                        <span style="font-size: 12px; color: gray;">${myReviewList.spaceAddr}</span>
			                                    </div>
			                                </a>
			                                </div>
			                            </td>
			                            <td>
			                                <p class="reviewContentP clamped ${status.index}">${myReviewList.reviewContent}</p><br>
			                                <button class="toggle-button" data-target="${status.index}">더보기</button>
			                                <span class="rating" data-score="${myReviewList.reviewScore}">
			                                    <img src="/resources/images/space/icon/starGray.svg" class="star" data-value="1">
			                                    <img src="/resources/images/space/icon/starGray.svg" class="star" data-value="2">
			                                    <img src="/resources/images/space/icon/starGray.svg" class="star" data-value="3">
			                                    <img src="/resources/images/space/icon/starGray.svg" class="star" data-value="4">
			                                    <img src="/resources/images/space/icon/starGray.svg" class="star" data-value="5">
			                                </span>
			                            </td>
			                            <td>
			                                <button class="manage-btn" onclick="fn_spaceView(${myReviewList.spaceId})">조회</button>
			                                 <script>
											 function fn_spaceView(spaceId) {
											   window.open("/space/spaceView?spaceId="+spaceId, '_blank');
											 }
											 </script>
														                                
			                            </td>
			                        </tr>
			                    </c:forEach>
			                </tbody>
			            </table>
			        </c:if>
        
             		<!-- 작성한 리뷰 페이징 -->
					<div class="pagination my-review-pagination">
					    <c:if test="${!empty myReviewPaging}">
					        <c:if test="${myReviewPaging.prevBlockPage > 0}">
					            <a class="prev" href="javascript:void(0)" onclick="fn_myReviewList(${myReviewPaging.prevBlockPage})">
					                <img src="/resources/images/guest/icon/left_arrow.png" />
					            </a>
					        </c:if>
					
					        <c:forEach var="i" begin="${myReviewPaging.startPage}" end="${myReviewPaging.endPage}">
					            <c:choose>
					                <c:when test="${i != myReviewPaging.curPage}">
					                    <a class="btn" href="javascript:void(0)" onclick="fn_myReviewList(${i})">${i}</a>
					                </c:when>
					                <c:otherwise>
					                    <a class="btn active" href="javascript:void(0)" style="cursor:default;">${i}</a>
					                </c:otherwise>
					            </c:choose>
					        </c:forEach>
					
					        <c:if test="${myReviewPaging.nextBlockPage > 0}">
					            <a class="next" href="javascript:void(0)" onclick="fn_myReviewList(${myReviewPaging.nextBlockPage})">
					                <img src="/resources/images/guest/icon/right_arrow.png" />
					            </a>
					        </c:if>
					    </c:if>
					</div>   
			    </div>
			</div>
        </div>   
    </div>
    
    
    
<script>
document.addEventListener('DOMContentLoaded', function(){
	// 리뷰 별점
    const reviews = document.querySelectorAll('.rating');

    reviews.forEach(review => {
        const score = review.getAttribute('data-score');
        const stars = review.querySelectorAll('.star');

        stars.forEach((star, index) => {
            if (index < score) {
                star.src = '/resources/images/space/icon/starYellow.svg'; // 노란 별
            } else {
                star.src = '/resources/images/space/icon/starGray.svg'; // 회색 별
            }
        });
    });
    
    // 탭 전환
    const tabs = document.querySelectorAll('.tabs .tab');
    const reviewableTable = document.querySelector('.reviewable-table');
    const myReviewListTable = document.querySelector('.my-review-list-table');

    // URL에서 현재 탭 상태 읽기
    const queryParams = new URLSearchParams(window.location.search);
    const activeTab = queryParams.get('tab') || 'reviewable'; // 기본값: 작성 가능한 리뷰

    // 초기 상태 설정
    function setActiveTab(tab) {
        tabs.forEach(t => t.classList.remove('active')); // 모든 탭에서 active 제거
        if (tab === 'reviewable') {
            tabs[0].classList.add('active');
            reviewableTable.style.display = 'block';
            myReviewListTable.style.display = 'none';
        } else if (tab === 'myReview') {
            tabs[1].classList.add('active');
            reviewableTable.style.display = 'none';
            myReviewListTable.style.display = 'block';
        }
    }

    setActiveTab(activeTab); // 페이지 로드 시 탭 상태 설정    
});

function fn_reviewableList(page)
{
    const queryParams = new URLSearchParams(window.location.search);
    queryParams.set('reviewablePage', page); // 작성 가능한 리뷰 페이지 설정
    queryParams.set('tab', 'reviewable'); // 현재 탭 상태 설정
    window.location.search = queryParams.toString(); // URL 새로고침
}

function fn_myReviewList(page)
{
    const queryParams = new URLSearchParams(window.location.search);
    queryParams.set('myReviewPage', page); // 작성한 리뷰 페이지 설정
    queryParams.set('tab', 'myReview'); // 현재 탭 상태 설정
    window.location.search = queryParams.toString(); // URL 새로고침
}

function fn_setTab(tab)
{
    const queryParams = new URLSearchParams(window.location.search);
    queryParams.set('tab', tab); // 현재 탭 설정
    queryParams.delete('reviewablePage'); // 다른 탭의 페이징 초기화
    queryParams.delete('myReviewPage');
    window.location.search = queryParams.toString(); // URL 새로고침
}

document.querySelectorAll(".toggle-button").forEach(button => {
    button.addEventListener("click", function () {
        const targetClass = this.getAttribute("data-target"); // 연결된 <p> 태그의 클래스 이름 가져오기
        const textContent = $("." + targetClass).get(0); // jQuery 객체에서 DOM 요소 가져오기

        // 클래스 토글
        textContent.classList.toggle("clamped");
        textContent.classList.toggle("expanded");

        // 버튼 텍스트 변경
        if (textContent.classList.contains("expanded")) {
            this.textContent = "접기"; // 확장된 상태
        } else {
            this.textContent = "더보기"; // 제한된 상태
        }
    });
});
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
    
</body>
</html>
