<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../jaesik/header.jsp"/>  

<style type="text/css">

   #div_pwd {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }
   
   #div_pwd2 {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }
   
   #div_updateResult {
      width: 90%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;      
      position: relative;
   }
   
   #div_btnUpdate {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }

</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#btnUpdate").click(function(){
			
			const pwd = $("input#pwd").val();
			const pwd2 = $("input#pwd2").val();
			
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 2 => 좋음
			const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			
			const bool = regExp.test(pwd);
			
			if(!bool) {
				alert("암호는 8글자 이상 15글지 이하의 영문, 숫자,특수기호가 혼합되어야만 합니다.");
				$("input#pwd").val();
				$("input#pwd2").val();
				return;
			}
			else if(bool && pwd != pwd2) {
				alert("암호가 일치하지 않습니다.");
				$("input#pwd").val();
				$("input#pwd2").val();
				return;
			}
			else {
				const frm = document.pwdUpdateEndFrm;
				frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.moc";
				frm.method = "POST";
				frm.submit();
			}
			
			 
		});//end of ready----------------------------
		
	});//end of ready()-------------------------
	
</script>


<%-- ** 비밀번호 찾기 form ** --%>
<form name="pwdUpdateEndFrm">

	<div id="div_pwd" align="center">
      	<span style="color: blue; font-size: 12pt;">새암호</span><br/> 
      	<input type="password" name="pwd" id="pwd" size="25" placeholder="PASSWORD" required />
   	</div>
   
   	<div id="div_pwd2" align="center">
        <span style="color: blue; font-size: 12pt;">새암호확인</span><br/>
      	<input type="password" id="pwd2" size="25" placeholder="PASSWORD" required />
   	</div>
   	
   	<input type="hidden" name="userid" value="${requestScope.userid}" />
   	
   	<c:if test="${requestScope.method == 'GET'}">
	   	<div id="div_btnUpdate" align="center">
	    	<button type="button" class="btn btn-success" id="btnUpdate">암호변경하기</button>
	    </div> 
   	</c:if>
</form>

	<c:if test="${requestScope.method == 'POST' && requestScope.n == 1}">
	   	<div id="div_updateResult" align="center">
	    	사용자 ID ${requestScope.userid} 님의 암호가 새로이 변경되었습니다.
	    </div> 
   	</c:if>
   	
   	<jsp:include page="../../jaesik/footer.jsp"/>
