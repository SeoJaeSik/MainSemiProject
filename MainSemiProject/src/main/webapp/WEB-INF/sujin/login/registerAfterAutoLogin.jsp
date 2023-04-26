<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입성공</title>

	<script type="text/javascript">
	
		window.onload = function() { /* 아래 body 에 있는 문서로딩이 끝나면 여기를 바로 실행한다 */
			
			alert("회원가입을 축하합니다.");
			
			const frm = document.loginFrm;
			frm.action = "<%= request.getContextPath()%>/login/login.moc";
			frm.method = "post";
			frm.submit();
		}
	
	</script>

</head>
<body>

	<form name="loginFrm">
		<input type="hidden" name="userid" value="${requestScope.userid}" /> <%-- LoginAction 과 맞춰줌 --%>
		<input type="hidden" name="pwd" value="${requestScope.pwd}"/>
	</form>

</body>
</html>