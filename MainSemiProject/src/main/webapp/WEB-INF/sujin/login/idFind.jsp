<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>  

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 


<%-- *** === Modal Body === *** --%>--

<script type="text/javascript">

	$(document).ready(function(){
		
		const method = "${requestScope.method}"; 
		
		if(method == "GET") {		// 첫화면에서는 결과부분 안보임 
			$("div#div_findResult").hide(); 
		}	
		else if(method == "POST") {	// POST 일때만 넘어온 값을 그대로 넘겨준다
			$("input#name").val("${requestScope.name}");  
			$("input#email").val("${requestScope.email}"); 
		}
	
		$("button#btnFind").click( function(){ // "찾기" 버튼 클릭하면,
			
			// 이메일에 대한 유효성검사(정규표현식 사용)
			const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			const bool = regExp.test($("input#email").val());
			
			if(!bool) {
				alert("올바른 이메일을 입력하세요");
				return;
			} 
			
			const frm = document.idFindFrm;
			console.log(frm);
			frm.action = "<%= ctxPath%>/login/idFind.moc";
			frm.method = "post";
			frm.submit();
		});
		
	});//end of ready()-------------------------
	
	
	// 아이디 찾기 모달창에 입력한 input 태그 value 값 초기화 시키기
	function func_form_empty() {
		
		document.querySelector("form[name='idFindFrm']").reset(); // 폼태그 삭제 
		$("div#div_findResult > p.text-center").empty(); 
		
	};//end of func_form_empty() ----------------
	
</script>


<form name="idFindFrm" class="mx-auto">

	<div class="my-6">
		<div class="form-group row mx-auto">
		    <label class="col-3 col-form-label" for="name">NAME</label>
		    <input class="col-7 form-control" type="text" name="name" id="name" placeholder = "용수진" autocomplete="off" required />
	  	</div>
	  	
	  	<div class="form-group row mx-auto" >
		    <label class="col-3 col-form-label" for="email">Email</label>
		    <input class="col-7 form-control" type="text" name="email" id="email" placeholder="yongsj@naver.com" autocomplete="off" required />
	  	</div>
   	</div>
   	<div class="my-3">
    	<p class="text-center">
       		<button type="button" class="btn btn-warning btn-md" id="btnFind" >ID FIND</button>
    	</p>
   	</div>
   	
</form>

<div class="my-3" id="div_findResult">
    <p class="text-center" style="font-size: 16pt; font-weight: bold;">
       ID : <span>${requestScope.userid}</span> 
  	</p>
</div>