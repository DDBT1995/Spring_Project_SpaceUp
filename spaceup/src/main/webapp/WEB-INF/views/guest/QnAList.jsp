<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/guest/QnAList.css">
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
			<h1>공간 Q&A</h1>

			<c:choose>
				<c:when test="${empty list}">
				    <div class="nono">
				    	<img src="/resources/images/guest/icon/empty_v2.png" />
				    	<p>문의사항 내역이 없습니다.</p>
				    </div>	
				</c:when>

				<c:otherwise>
					<c:forEach var="question" items="${list}" varStatus="status">
						<!-- 공간 당 문의 -->
						<c:choose>
						<c:when test="${question.status eq 'Y'}">
							<div class="detailPage">
								<div class="QnaIdDiv">
									<span style="font-size: 14px;">문의번호 ${question.spaceQuestionId}</span>
								</div>
								<div class="info-box">
									<img src="http://spaceuphostcenter.sist.co.kr:8088/resources/images/space/upload/${question.spaceType}/${question.spaceId }/${question.spaceId }_1.jpg"  onerror="this.onerror=null; this.src='/resources/images/space/icon/imagebear.jpg';" alt="Image">
									<div class="details" style="text-align: right;">
										<p style="font-size: 18px;">${question.spaceName}</p>
										<p style="font-size: 14px;">${question.spaceTip}</p>
									</div>
								</div>
	
								<!-- QnA 목록-->
								<hr>
								<div class="details">
									<span> <c:choose>
											<c:when test="${empty question.spaceAnswer}">
												<span style="font-weight: bold; color: rgb(255 72 72/ 93%);" class="qna-regDate">답변대기중</span> &nbsp;| &nbsp; 		
				                    		</c:when>
											<c:otherwise>
												<span style="font-weight: bold; color: #36BC9B;" class="qna-regDate">답변완료</span> &nbsp;| &nbsp; 
				                    		</c:otherwise>
										</c:choose> <span class="qna-answerCnt">${fn:substring(question.regDate, 0, 10)}</span>
									</span>
									<div class="qna-body">${question.questionContent }</div>
								</div>
								<!-- 답글있으면 -->
								<c:choose>
									<c:when test="${!empty question.spaceAnswer}">
										<hr>
										<div style="display: flex; align-items: center;">
											<div style="width: 5%;">
												<span><img style="width: 20px; transform: rotate(180deg); filter: invert(55%) sepia(93%) saturate(286%) hue-rotate(115deg) brightness(94%) contrast(95%); margin-left: 15px;" src="/resources/images/guest/icon/reply.svg"></span>
											</div>
											<div class="details">
												<span> <span class="qna-regDate" style="color: black;">${question.spaceAnswer.hostNickname} &nbsp;| &nbsp; </span> <span class="qna-answerCnt">${fn:substring(question.spaceAnswer.regDate, 0, 10)}</span>
												</span>
												<div class="qna-body">${question.spaceAnswer.answerContent}</div>
											</div>
										</div>
									</c:when>
								</c:choose>
								<!-- 답글있으면 -->
								<hr style="border-color: rgb(0 0 0 / 52%);">
							</div>
						</c:when>
						<c:otherwise>
							<p>삭제된 질문입니다.</p>
						</c:otherwise>
						</c:choose>
						
					</c:forEach>
				</c:otherwise>
			</c:choose>

			<!-- 페이징 버튼 추가 -->
			<div class="pagination">
				<c:if test="${!empty paging}">
					<!-- 이전 블럭 버튼 -->
					<c:if test="${paging.prevBlockPage gt 0}">
						<a class="prev" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})"> <img src="/resources/images/guest/icon/left_arrow.png" />
						</a>
					</c:if>

					<!-- 숫자 버튼 -->
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
						<c:choose>
							<c:when test="${i ne curPage}">
								<a class="btn" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a>
							</c:when>
							<c:otherwise>
								<a class="btn active" href="javascript:void(0)" onclick="fn_list(${i})" style="cursor: default;">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음 블럭 버튼 -->
					<c:if test="${paging.nextBlockPage gt 0}">
						<a class="next" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})"> <img src="/resources/images/guest/icon/right_arrow.png" />
						</a>
					</c:if>
				</c:if>
			</div>
			<script type="text/javascript">
				function fn_list(curPage){
					document.questionForm.curPage.value = curPage;
					document.questionForm.action = "/guest/QnAList"
					document.questionForm.submit();
				}
			</script>
		</div>
		
		<form id="questionForm" name="questionForm">
			<input type="hidden" id="curPage" name="curPage" value="">
		</form>
	</div>
	
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>