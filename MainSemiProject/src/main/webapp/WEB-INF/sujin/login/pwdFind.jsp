<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../jaesik/header.jsp"/>


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
		
	});//end of ready()-------------------------
	
</script>


<%-- ** 비밀번호 찾기 ** --%>

<div class="container my-5 mx-auto bg-white">

	<form name="pwdFindFrm" class="col-md-10 py-3 mx-auto">
		<h2 class="text-center pb-3" style="font-weight:bold;">FORGET YOUR PASSWORD?</h2>
		<div style="margin-bottom: 40px; text-align: center;">
			<small>Please enter your id and email address ro recieve password link.</small>
		</div>
		<div class="form-group row col-8 mx-auto my-3">
		    <input class="form-control mx-auto" type="text" id="userid" placeholder = "Id" />
		</div>
		<div class="form-group row col-8 mx-auto my-3">
		    <input class="form-control mx-auto" type="text" id="email" placeholder = "Email" />
		</div>
	   	<div class="form-group row col-8 mx-auto my-3" id="div_btnFind">
	       	<button type="button" class="btn btn-warning form-control mx-auto" id="btnFind">C O N T I N U E</button>
	   	</div>
	   	<div class="form-group row col-8 mx-auto my-3">
	   		<small class="passwdFindClose" style="cursor:pointer; text-decoration:underline; text-align:left;">cancel</small>
	   	</div>
	</form>
	
	<div class="my-3" id="div_findResult">
	    <p class="text-center">
	    	<c:if test="${requestScope.isUserExist == false}">
	    		<span style="color: red;">사용자 정보가 없습니다.</span>
	    	</c:if>
	    	
	    	<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">
	    		<span style="font-size:10pt;">비밀번호를 변경할 수 있는 링크를 ${requestScope.email} 로 전송되었습니다.</span><br>
	    	</c:if>
	    	
	    	<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">
	    		<span style="color: red;">메일발송에 실패했습니다.</span><br>
	    	</c:if>
	  	</p>
	</div>
	
</div>

<jsp:include page="../../jaesik/footer.jsp"/>