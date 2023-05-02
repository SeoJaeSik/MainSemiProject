<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

	alert("${requestScope.message}");    // 메세지 출력해주기
	location.href="${requestScope.loc}"; // 페이지 이동하기 

	opener.location.reload(true); // 1 부모창을 새로고침해주고,
	self.close();                 // 2 (자식)팝업창이 있으면 닫아준다
	
</script>