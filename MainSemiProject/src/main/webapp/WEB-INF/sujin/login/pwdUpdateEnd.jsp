<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../jaesik/header.jsp"/>  

<style type="text/css">

	table#pwdResetTbl {
         width: 100%;
         margin-top: 50px;
         margin-bottom: 50px;
         text-align: center;
         border-collapse: separate;
         border-spacing: 10px; 
    }
   
    table#pwdResetTbl #th {
         font-weight: bold;
         font-size: 20pt;
         text-align: center;
         height: 20px;
         letter-spacing: 5px;
         padding-bottom: 20px;
    }
   
    table#pwdResetTbl td {
         line-height: 40px;
         width: 250px; 
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
			 
		});//end of $("button#btnUpdate").click(function(){})----------------------------
		
	});//end of ready()-------------------------
	
</script>


<%-- ** 비밀번호 수정하기 form ** --%>

<div class="container my-5 py-2 mx-auto bg-white">
	<form name="pwdUpdateEndFrm">
		<table id="pwdResetTbl">
         	<thead>
            	<tr>
               		<th id="th" style="margin-bottom: 70px;">RESET PASSWORD</th>
            	</tr>
         	</thead>
         	<tbody>
         		<tr id="div_pwd">
               		<td>
               			<input type="password" id="pwd" name="pwd" size="40" class="box" autocomplete="off" placeholder="NEW PASSWORD"/>
               		</td>
               	</tr>
               	
         		<tr id="div_pwd2">
         			<td>
	               	   	<input type="password" id="pwd2" name="pwd" size="40" class="box" autocomplete="off" placeholder = "CONFIRM NEW PASSWORD"/>
	               	</td>
         		</tr>
         		
         		<tr>
	               	<td id="div_btnUpdate" align="center" style="padding: 10px;">
	                   	<button type="button" id="btnUpdate" class="btn btn-warning btn-md" style="font-weight:bold;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C O N T I N U E&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
	           	   	</td>
	           	</tr>
         	</tbody>
        </table> 	
		
		<input type="text" name="userid" value="${requestScope.userid}"/>
		<input type="text" name="email" value="${requestScope.email}"/> <!-- 여기 암호화된 이메일 !!! --> 
		
	</form>

</div>

<jsp:include page="../../jaesik/footer.jsp"/>
