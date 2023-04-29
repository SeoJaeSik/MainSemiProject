<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>  

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 


<%-- *** === Modal Body === *** --%>

<script type="text/javascript">

	$(document).ready(function(){
		
		const method = "${requestScope.method}"; 
		
		if(method == "GET") {		// 첫화면에서는 메일발송성공여부 안보임 
			$("div#div_pwdfindResult").hide(); 
		}	
		else if(method == "POST") {	// POST 일때만 넘어온 값을 그대로 넘겨준다
			$("input#userid").val("${requestScope.userid}");  
			$("input#email").val("${requestScope.email}");
			$("div#div_pwdfindResult").show(); 
		}
		
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
		
		
		// 2. 비밀번호 찾기 모달창에 입력한 input 태그 value 값 초기화 시키기
		function func_pwdform_reset_empty() {
		
			document.querySelector("form[name='pwdFindFrm']").reset(); // 폼태그 삭제 
			$("div#div_pwdfindResult > p.text-center").empty(); 
		
		};//end of func_pwdform_reset_empty() ----------------
		
		
	});//end of ready()-------------------------
	
	
</script>


<form name="pwdFindFrm" class="mx-auto">

	<div class="my-6">
		<div class="form-group row mx-auto">
		    <label class="col-3 col-form-label" for="userid">ID</label>
		    <input class="col-7 form-control" type="text" name="userid" id="userid" placeholder = "sudin" autocomplete="off" required />
	  	</div>
	  	
	  	<div class="form-group row mx-auto" >
		    <label class="col-3 col-form-label" for="email">Email</label>
		    <input class="col-7 form-control" type="text" name="email" id="email" placeholder="yongsj@naver.com" autocomplete="off" required />
	  	</div>
   	</div>
   	<div class="my-3 text-center" style="margin-bottom:40px;">
		<small>비밀번호를 변경할 수 있는 링크를 받기 위해 올바른 ID 와 Email 을 입력하세요.</small>
	</div>
   	<div class="my-3">
    	<p class="text-center">
       		<button type="button" class="btn btn-warning btn-md" id="btnFind" >PASSWORD FIND</button>
    	</p>
   	</div>
   	
</form>

<div class="my-3" id="div_pwdfindResult">
    <p class="text-center" style="font-size: 16pt; font-weight: bold;">
       <c:if test="${requestScope.isUserExist == false}">
    		<span style="font-size: 13pt; font-weight: bold;">사용자 정보가 없습니다.</span>
    	</c:if>
    	
    	<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">
    		<span style="font-size: 13pt; font-weight: bold;">메일발송에 실패했습니다.</span><br>
    	</c:if> 
    	
    	<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">
    		<span style="font-size: 13pt; font-weight: bold;">인증코드가 ${requestScope.email} 로 전송되었습니다.</span><br>
    		<span style="font-size: 13pt; font-weight: bold;">이메일을 확인해주세요</span><br>
    		<%-- 메일전송되고는 몇초있다가 바로 꺼지게 하고 싶은데 되려나? --%>
    	</c:if>	
  	</p>
</div>