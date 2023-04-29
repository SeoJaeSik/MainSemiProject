<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../jaesik/header.jsp"/>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 1. 찾기 버튼 클릭
		$("button#btnFind").click(function(){
		
			// 아이디에 대한 유효성검사
			const useridVal = $("input#userid").val().trim();
			if(useridVal == "") {
				alert("아이디를 입력하세요");
				return;
			}
			
			// 이메일에 대한 유효성검사(정규표현식 사용)
			const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			const bool = regExp.test($("input#email").val());
			
			if(!bool) {
				alert("올바른 이메일을 입력하세요");
				return;
			}
			
			const frm = document.pwdFindFrm;
			
			frm.action = "<%= ctxPath%>/login/pwdFind.moc"; 
			frm.method = "post";
			frm.submit();
			
		});//end of 1. 찾기 버튼 클릭------------------------------
		
		
		// 2. cancel 태그 클릭 -> 그냥 로그인 화면으로 돌아가기
		$("small.passwdFindClose").click(function(){
			history.go(-1);
		});
		
		const method = "${requestScope.method}"; /* "" 를 꼭써줘야 string 타입으로 잘 들어올 수 있다 */
		//	console.log("method => " + method); // 잘 나오나 확인해봐~
			
		if(method == "GET") {
			/* 그냥 비번찾기 폼만 보임 */
		}	
		else if(method == "POST") {
			
			$("input#userid").val("${requestScope.userid}"); /* POST 일때면 넘어온 userid 값을 그대로 넘겨준다 */
			$("input#email").val("${requestScope.email}");   /* POST 일때면 넘어온 email 값을 그대로 넘겨준다 */
		
			if(${requestScope.isUserExist == false}) {
				alert("입력하신 아이디 또는 이메일 사용자의 정보가 없습니다.");
				// 다시 비번찾기 창에 원래 입력했던 값까지 유지함
			}
			else if (${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}) {
				alert("메일 발송에 실패하였습니다. 아이디와 이메일을 확인해주세요.");
				// 다시 비번찾기 창에 원래 입력했던 값까지 유지함
			}
			else if (${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}) {
				
				alert("비밀번호를 변경할 수 있는 링크를 ${requestScope.email} 로 전송되었습니다.");
				location.href="javascript:history.go(-2);";
				// 입력했던 정보를 지우고 로그인 창으로 돌아감
			}
			
			
			
	   		
		}//end of else if(method == "POST")-----------------------------------------
		
		
	});//end of ready()-------------------------
	
	
</script>


<%-- ** 비밀번호 찾기 form ** --%>

<div class="container my-5 mx-auto bg-white">

	<form name="pwdFindFrm" class="col-md-10 py-3 mx-auto">
		<h2 class="text-center pb-3" style="font-weight:bold;">FORGET YOUR <br> PASSWORD?</h2>
		<div style="margin-bottom: 40px; text-align: center;">
			<small>Please enter your id and email address ro recieve password link.</small>
		</div>
		<div class="form-group row col-6 mx-auto my-3">
		    <input class="form-control mx-auto" type="text" id="userid" name="userid" placeholder = "Id" autocomplete="off" required />
		</div>
		<div class="form-group row col-6 mx-auto my-3">
		    <input class="form-control mx-auto" type="text" id="email" name="email" placeholder = "Email" autocomplete="off" required />
		</div>
	   	<div class="form-group row col-6 mx-auto my-3" id="div_btnFind">
	       	<button type="button" class="btn btn-warning form-control mx-auto" id="btnFind">C O N T I N U E</button>
	   	</div>
	   	<div class="form-group row col-6 mx-auto my-3">
	   		<small class="passwdFindClose" style="cursor:pointer; text-decoration:underline; text-align:left; font-size:13pt;">cancel</small>
	   	</div>
	</form>
	
</div>

<jsp:include page="../../jaesik/footer.jsp"/>