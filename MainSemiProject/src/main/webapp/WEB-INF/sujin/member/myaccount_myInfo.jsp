<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- point 불러와서 사용 --%>

<style type="text/css">
	
	.mypage-wrapper {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	}
	
	.p_column {
	  width: 30%;
	  text-align: center;
	}
	
	.btn_userEdit {
	  padding: 10px 20px;
	  background-color: #ffeb99;
	  color: black;
	  border: none;
	  border-radius: 5px;
	}
	
	.coupon-status, .point-status {
	  font-weight: bold;
	  color: #0B6623;
	  text-align: left;
	}
	
	.profile_img {
		width:250px;
		border-radius:50%;
	}
	
	div#viewmy1 {
		background-color:#fefce7; 
		padding-top:40px;
		padding-bottom:40px;
	}
	
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
		$("div#memberEdit").hide();		
		
		// 쿠폰명 보이기
		$('[data-toggle="tooltip"]').tooltip();
		
	});

	// == 나의정보수정하기 == 
	function goEditPersonal(userid) {
		
		$("div#memberEdit").show();
		
		<%-- const url = "<%= request.getContextPath()%>/member/memberEdit.moc?userid=" + userid;
	    location.href = url; --%>
		
	}//end of goEditPersonal()--------------------------------- 

</script>

<div class="tab-pane container active" id="viewmy1"> <%-- fade 클래스를 넣으면 active 가 안먹는다 뺴야함! --%>
	
	<div class="mypage-wrapper">
  		<div class="p_column col-3" id="profile_img">
    		<img class="profile_img" src="<%= request.getContextPath()%>/images/프로필사진.png" alt="프로필 이미지" >
  		</div>
  		
  		<div class="p_column col-5" id="profile_user">
    		<h3 class="username" style="margin-bottom:20px;"><span style="font-weight:bold;">${(sessionScope.loginuser).name}</span>님 반갑습니다</h3>
    		<div class="pwdchangedate my-2">
				비밀번호를 변경한지&nbsp; ${(sessionScope.loginuser).pwdchange_daygap} &nbsp;일 경과되었습니다.
			</div>
			<button class="btn_userEdit btn_sm" type="button" onclick="goEditPersonal('${(sessionScope.loginuser).userid}');">나의정보 변경하기</button>
 	 	</div>
 	 	
  		<div class="p_column col-3" id="profile_info">
    		<div class="coupon-wrapper">
      			<p class="coupon-status" data-toggle="tooltip" data-placement="top" title="${(sessionScope.loginuser).couponName}">보유한 쿠폰 :&nbsp; ${(sessionScope.loginuser).couponCnt} &nbsp;개</p>
    		</div>
	    	<div class="point-wrapper">
	      		<p class="point-status">보유한 포인트 :&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" />&nbsp;p</p> 
	      		<%-- .point 은 필드가 아니라 memberVO 의 getpoint --%>
	    	</div>
	  	</div>
	</div>
</div>  


<div id="memberEdit">
	<jsp:include page="memberEdit.jsp"/> 
</div>  
