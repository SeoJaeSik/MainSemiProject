<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    
<jsp:include page="header.jsp"/>

<style type="text/css">

	div#mvoInfo {
      width: 60%; 
      text-align: left;
      border: solid 0px red;
      margin-top: 30px; 
      font-size: 13pt;
      line-height: 200%;
   }
   
   span.myli {
      display: inline-block;
      width: 90px;
      border: solid 0px blue;
   }
   
/* ============================================= */
   div#sms {
      margin: 0 auto; 
      /* border: solid 1px red; */ 
      overflow: hidden; 
      width: 50%;
      padding: 10px 0 10px 80px;
   }
   
   span#smsTitle {
      display: block;
      font-size: 13pt;
      font-weight: bold;
      margin-bottom: 10px;
   }
   
   textarea#smsContent {
      float: left;
      height: 100px;
   }
   
   button#btnSend {
      float: left;
      border: none;
      width: 50px;
      height: 100px;
      background-color: navy;
      color: white;
   }
   
   div#smsResult {
      clear: both;
      color: red;
      padding: 20px;
   }   

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("div#smsResult").hide();
	
		$("button#btnSend").click( () => {
			// alert($("input#reservedate").val() + " " + $("input#reservetime").val());
			// 2023-04-18 10:28 - 대쉬와 콜론을 모두 없애야 한다.
			
			let reservedate = $("input#reservedate").val();
			reservedate = reservedate.split("-").join("");
			
			let reservetime = $("input#reservetime").val();
			reservetime = reservetime.split(":").join("");
			
			const datetime = reservedate+reservetime;
	
			let dataObj;
			
			if (reservedate == "" || reservetime == "") {
				// 문자를 바로 전송인 경우
				dataObj = {"mobile":"${mvo.mobile}" ,
						   "smsContent":$("textarea#smsContent").val()};
			}
			else {
				// 특정한 시각에 보내는 경우 (예약문자)
				dataObj = {"mobile":"${mvo.mobile}" ,
						   "smsContent":$("textarea#smsContent").val() ,
						   "datetime":datetime};
			}
			<%-- 에이작스 띄어쓰기 --%>
			$.ajax({ 
				url:"<%= request.getContextPath()%>/member/smsSend.up" ,
				type:"POST" ,
				data:dataObj ,
				dataType:"json" ,
				success:function(json){
					// json은 자바스크립트의 객체이다.
					// console.log(JSON.stringfy(json));
					// {"group_id":"R2Gd8d6vNq3x1DcX","success_count":1,"error_count":0}
					
					if (json.success_count == 1){
						$("div#smsResult").html("문자전송이 성공되었습니다.");
					}
					else if ( json.error_count != 0){
						$("div#smsResult").html("문자전송이 실패되었습니다.");
					}
					
					$("div#smsResult").show();
					$("textarea#smsContent").val("");
					
					
				} , 
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }    
				
				
			});
			
			
		}); // end $("button#btnSend").click
		
	}) // end $(document).ready

</script>

<div class="container my-5 text-center">
<c:if test="${empty mvo}">
<h3>존재하지 않는 회원입니다.</h3>
</c:if>
	<c:if test="${not empty mvo}">
	   <c:set var="mobile" value="${mvo.mobile}" />
	   <c:set var="birthday" value="${mvo.birthday}" />
	   <h3>${mvo.name}님의 회원 상세정보</h3>
	
	   <div id="mvoInfo" style="margin-left: 300px;">
	    <ol>   
	       <li><span class="myli">아이디 : </span>${mvo.userid}</li>
	       <li><span class="myli">회원명 : </span>${mvo.name}</li>
	       <li><span class="myli">이메일 : </span>${mvo.email}</li>
	       <li><span class="myli">연락처 : </span>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</li>
	       <li><span class="myli">우편번호 : </span>${mvo.postcode}</li>
	       <li><span class="myli">주소 : </span>${mvo.address}&nbsp;${mvo.detailaddress}&nbsp;${mvo.extraaddress}</li>
	       <li><span class="myli">성별 : </span><c:choose><c:when test="${mvo.gender eq '1'}">남</c:when><c:otherwise>여</c:otherwise></c:choose></li> 
	       <li><span class="myli">생년월일 : </span>${mvo.birthday}</li> 
	       <li><span class="myli">나이 : </span>${mvo.age}세</li> 
	       <li><span class="myli">포인트 : </span><fmt:formatNumber value="${mvo.point}" pattern="###,###" /> POINT</li>
	       <li><span class="myli">가입일자 : </span>${mvo.registerday}</li>
	     </ol>
	   </div>
	   
	   <%-- ==== 휴대폰 SMS(문자) 보내기 ==== 
	   <div id="sms" align="left">
	        <span id="smsTitle">&gt;&gt;휴대폰 SMS(문자) 보내기 내용 입력란&lt;&lt;</span>
	        <div style="margin: 10px 0 20px 0">
	           발송예약일&nbsp;<input type="date" id="reservedate" />&nbsp;<input type="time" id="reservetime" />
	        </div>
	        <textarea rows="4" cols="40" id="smsContent"></textarea>
	        <button id="btnSend">전송</button>
	        <div id="smsResult"></div>
	   </div>
	   --%>
	   
	</c:if>
	
	
	<div>
	   <button style="margin-top: 50px;" type="button" class="btn bg-dark text-white" onclick="javascript:history.back();">뒤로가기</button>
	</div>
</div>

<jsp:include page="footer.jsp"/>