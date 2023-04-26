<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- point 불러와서 사용 --%>

<style type="text/css">
	
	.mypage-wrapper {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	}
	
	.column {
	  width: 30%;
	  text-align: center;
	}
	
	.btn_userEdit {
	  padding: 10px 20px;
	  background-color: #f0e68f;
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

</style>

<div class="tab-pane container fade"  id="viewmyInfo">
	
	<div class="mypage-wrapper">
  		<div class="column col-3" id="profile_img">
    		<img class="profile_img" src="<%= request.getContextPath()%>/images/프로필사진.png" alt="프로필 이미지" >
  		</div>
  		
  		<div class="column col-5" id="profile_user">
    		<h3 class="username" style="margin-bottom:20px;"><span style="font-weight:bold;">${(sessionScope.loginuser).name}</span>님 반갑습니다</h3>
    		<div class="pwdchangedate my-2">
				비밀번호를 변경한지 ?일이 경과하였습니다.
				<!-- ( ${(sessionScope.loginuser).lastpwdchangedate} - ${(sessionScope.loginuser).registerday} ) 이거 아니야??? -->
			</div>
			<button class="btn_userEdit btn_sm">나의정보 변경하기</button>
 	 	</div>
 	 	
  		<div class="column col-3" id="profile_info">
    		<div class="coupon-wrapper">
      			<p class="coupon-status">보유한 쿠폰 : ?개</p>
    		</div>
	    	<div class="point-wrapper">
	      		<p class="point-status">보유한 포인트 : <fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" />p</p> 
	      		<%-- .point 은 필드가 아니라 memberVO 의 getpoint --%>
	    	</div>
	  	</div>
	</div>
	
	  	
	<!-- <form class="col-md-10 py-3 mx-auto">
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label text-left">성명&nbsp;<span class="star">*</span></label>
		    <input class="col-6 form-control" type="text" id="name" class="requiredInfo" placeholder = "Name"></input>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto" >
		    <label class="col-3 col-form-label text-left">이메일&nbsp;<span class="star">*</span></label>
		    <input class="col-6 form-control" type="text" id="email"  class="requiredInfo" placeholder = "Email" />&nbsp;
		    <button class="btn btn-secondary btn-sm col-3" id="duplicatechk" style="border-radius: 20px;" onclick="isExistEmailCheck();">Email 중복확인</button>
		    <span id="emailCheckResult"></span>
		    <span><small class="error" style="color:red">The email format is not correct.</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label text-left">비밀번호&nbsp;<span class="star">*</span></label>
		    <input class="col-6 form-control" type="password" id="pwd" class="requiredInfo" placeholder = "Password"></input>
		    <span><small class="error" style="color:red">Password is required</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label text-left">비밀번호확인&nbsp;<span class="star">*</span></label>
		    <input class="col-6 form-control" type="password" id="pwdcheck" class="requiredInfo" placeholder = "Confirm Password"></input>
		    <span><small class="error" style="color:red">Please enter valid, matching passwords.</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label text-left">연락처</label>	 
		    <input class="col-2 form-control" type="text" id="hp1" name="hp1" value="010" readonly />&nbsp; readonly : 읽기전용으로 010 만 보여주고 변경할 수 없도록 해준다
	          	<input class="col-2 form-control" type="text" id="hp2" name="hp2" />&nbsp;
	          	<input class="col-2 form-control" type="text" id="hp3" name="hp3" />
	          	<span><small class="error" style="color:red">It's not phone number type.</small></span>
	  	</div>
	  	
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label text-left">우편번호</label>
		    <input type="text" class="col-3 form-control" id="postcode" placeholder="우편번호" />&nbsp;
		    <button class="btn btn-secondary btn-sm col-3" id="zipcodeSearch" style="border-radius: 20px;">우편번호찾기</button>
			<span><small class="error" style="color:red">It's not postcode type.</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label text-left">주소</label>
		    <input class="col-8 form-control" type="text" id="address" placeholder="Address" />
	  	</div>
	  	<div class="form-group row col-md-10 mx-auto">	 
		    <label class="col-3 col-form-label"> </label>
	          	<input class="col-8 form-control" type="text" id="detailaddress" placeholder="Detail Address" />
         	</div>
          	<div class="form-group row col-md-10 mx-auto"> 	
	          	<label class="col-3 col-form-label"> </label>
	         	<input class="col-8 form-control" type="text" id="extraaddress" placeholder="Extra Address" />
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label text-left">생년월일</label>	 
		    <input class="col-3 form-control" type="number" id="birthyyyy" min="1950" max="2050" step="1" value="1995" required />&nbsp;
	          	<select class="col-2 form-control" type="number" id="birthmm" ></select>&nbsp;
	          	<select class="col-2 form-control" type="number" id="birthdd" ></select>
	  	</div>
	  	
	  	<div class="form-group row col-md-10 mx-auto">
           	<input class="col-1 form-control" style="height:15px; margin-top:12px; margin-left:30px;" type="checkbox" name="agree" id="agree" />&nbsp;&nbsp;
           	<label class="col-form-label" for="agree" ><small>Get updates on MOSACOYA news and promotions.</small></label>
        	</div>
		  	<div class="form-group row col-md-10 mx-auto">
		  	<input type="button" class="btn btn-secondary btn-sm mt-3" id="btnUpdate" onClick="goEdit();" value="수정" style="font-size: 15pt;" />
         				<input type="button" class="btn btn-secondary btn-sm mt-3 ml-5" onClick="self.close()" value="취소" style="font-size: 15pt;" /> 
			<button class="btn btn-md col-4 mx-auto" style="border-radius: 5px; font-weight:bold; background-color:#f0e68f; " id="btnUpdate" onclick="goEdit()">수정하기</button>
			<button class="btn btn-md col-4 mx-auto" style="border-radius: 5px; font-weight:bold; background-color:#f0e68f; " onclick="self.close()">취소하기</button>
	  	</div>
  	
	</form> -->
</div>    