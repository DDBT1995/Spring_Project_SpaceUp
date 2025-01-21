<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(function(){
	if(icia.common.type(window.opener) == "object")
	{
		if(icia.common.type(window.opener.fn_kakaoPayResult) == "function")
		{
			window.opener.fn_kakaoPayResult(${code}, "${msg}");
		}
		else
		{
			alert("${msg}");
			window.opener.location.href = "/guest/reservationView?reservationId="+${reservationId}; // 부모 창을 다른 페이지로 이동
			window.close();
		}
	}
	else
	{
		alert("${msg}");
		window.close();
	}
});
</script>
</head>
<body>

</body>
</html>