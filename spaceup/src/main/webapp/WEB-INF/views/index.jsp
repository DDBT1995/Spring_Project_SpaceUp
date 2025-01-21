<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<title><spring:eval expression="@env['site.title']" /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link href="/resources/css/index.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- section1: 첫 번째 섹션 -->
	<div class="section" id="section1">
		<p>당신이 원하는 모든 공간</p>
		<div id="section1_logo"></div>
		<div class="scroll-down">
	        Scroll Down
	        <span>⬇</span>
	    </div>
	</div>
	

	<!-- section2: 두 번째 섹션 -->
	<div class="section" id="section2">
		<div class="main-container">
			<div class="category popup" data-category="0">
				<i class="fas fa-briefcase"></i>
				<h1>Main</h1>
				<p class="time">10:20 AM</p>
			</div>

			<div class="category studio" data-category="5">
				<i class="fas fa-home"></i>
				<h1>studio</h1>
				<p class="chat-bubble">놀러 왔어요!</p>
				<p class="time">6:17 AM</p>
			</div>

			<div class="category party" data-category="1">
				<i class="fas fa-glass-cheers"></i>
				<h1>Party</h1>
				<p class="chat-bubble">재미있게 놀아보자!</p>
				<p class="time">9:00 PM</p>
			</div>

			<div class="category exercise" data-category="9">
				<i class="fas fa-running"></i>
				<h1>Exercise</h1>
				<p class="chat-bubble">운동하러 왔어요!</p>
				<p class="time">5:30 AM</p>
			</div>
		</div>
	</div>

	<script>
        // Intersection Observer 설정
        const observerOptions = {
            root: null,
            threshold: 0.1 // 20%가 보일 때 실행
        };

        const observer = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible'); // 섹션 나타나기
                    observer.unobserve(entry.target); // 다시 감지하지 않음
                }
            });
        }, observerOptions);

        // 모든 섹션을 관찰
        document.querySelectorAll('.section').forEach(section => {
            observer.observe(section);
        });
        
        $(".category").on("click", function(e) {
        	if(e.currentTarget.dataset.category == 0) {
        		location.href = "/space/spaceMain";
        	} else {
        		location.href = "/space/spaceList?spaceTypeBar=" + e.currentTarget.dataset.category;
        	}
        });
    </script>
</body>
</html>
