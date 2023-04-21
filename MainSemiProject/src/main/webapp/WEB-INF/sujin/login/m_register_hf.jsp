<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<jsp:include page="../../jaesik/header.jsp"/>

<body>

	<div class="bg-white container mt-5 mx-auto">
		<h2 class="text-center pb-3" style="font-weight:bold;">REGISTER</h2>
	
		<form class="col-md-10 py-3 mx-auto">
		  
		  	<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label">성명&nbsp;<span class="star">*</span></label>
			    <input class="col-6 form-control" type="text" id="name" class="requiredInfo" placeholder = "Name"></input>
			    <span><small class="error" style="color:red">Name is required</small></span>
		  	</div>
		  
		  	<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label">아이디&nbsp;<span class="star">*</span></label>
			    <input class="col-6 form-control" type="text" id="userid" class="requiredInfo" placeholder = "ID" />&nbsp;
			    <button class="btn btn-secondary btn-sm col-3" id="duplicatechk" style="border-radius: 20px; width:50px;" onclick="isExistEmailCheck();">중복확인</button>
	            <span id="idcheckResult_개인정보수정할때사용"></span>
			    <span><small class="error" style="color:red">ID is required</small></span>
		  	</div>
		  
		  	<div class="form-group row col-md-10 mx-auto" >
			    <label class="col-3 col-form-label">이메일&nbsp;<span class="star">*</span></label>
			    <input class="col-6 form-control" type="text" id="email"  class="requiredInfo" placeholder = "Email" />&nbsp;
			    <button class="btn btn-secondary btn-sm col-3" id="duplicatechk" style="border-radius: 20px;" onclick="isExistEmailCheck();">중복확인</button>
			    <span id="emailCheckResult_개인정보수정할때사용"></span>
			    <span><small class="error" style="color:red">The email format is not correct.</small></span>
		  	</div>
		  
		  	<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label">비밀번호&nbsp;<span class="star">*</span></label>
			    <input class="col-6 form-control" type="password" id="pwd" class="requiredInfo" placeholder = "Password"></input>
			    <span><small class="error" style="color:red">Password is required</small></span>
		  	</div>
		  
		  	<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label">비밀번호확인&nbsp;<span class="star">*</span></label>
			    <input class="col-6 form-control" type="password" id="pwdcheck" class="requiredInfo" placeholder = "Confirm Password"></input>
			    <span><small class="error" style="color:red">Please enter valid, matching passwords.</small></span>
		  	</div>
		  
		  	<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label">연락처</label>	 
			    <input class="col-2 form-control" type="text" id="hp1" name="hp1" value="010" readonly />&nbsp; <!-- readonly : 읽기전용으로 010 만 보여주고 변경할 수 없도록 해준다 -->
	           	<input class="col-2 form-control" type="text" id="hp2" name="hp2" />&nbsp;
	           	<input class="col-2 form-control" type="text" id="hp3" name="hp3" />
	           	<span><small class="error" style="color:red">It's not phone number type.</small></span>
		  	</div>
		  	
		  	<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label">우편번호</label>
			    <input type="text" class="col-3 form-control" id="postcode" placeholder="postcode" />&nbsp;
			    <button class="btn btn-secondary btn-sm col-3" id="zipcodeSearch" style="border-radius: 20px;">우편번호찾기</button>
				<span><small class="error" style="color:red">It's not postcode type.</small></span>
		  	</div>
		  
		  	<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label">주소</label>
			    <input class="col-8 form-control" type="text" id="address" placeholder="Address" />
		  	</div>
		  	<div class="form-group row col-md-10 mx-auto">	 
			    <label class="col-3 col-form-label"> </label>
	           	<input class="col-8 form-control" type="text" id="detailaddress" placeholder="Detail Address" />
          	</div>
          	<div class="form-group row col-md-10 mx-auto"> 	
	           	<label class="col-3 col-form-label"> </label>
	           	<input class="col-8 form-control" type="text" id="extraaddress" placeholder="Extra Address" />
           		<span><small class="error" style="color:red">Address is required.</small></span>
		  	</div>
		  
		  	<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label ">성별</label>
			    <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%; padding-top:9px;">남자</label>
		        <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%; padding-top:9px;">여자</label>
          	</div>

			<div class="form-group row col-md-10 mx-auto">
			    <label class="col-3 col-form-label">생년월일</label>	 
			    <input class="col-3 form-control" type="number" id="birthyyyy" min="1950" max="2050" step="1" value="1995" required />&nbsp;
	           	<select class="col-2 form-control" type="number" id="birthmm" ></select>&nbsp;
	           	<select class="col-2 form-control" type="number" id="birthdd" ></select>
	           	<span><small class="error" style="color:red">It's not phone number type.</small></span>
		  	</div>
		  	
		  	<div class="form-group row col-md-10 mx-auto">
            	<input class="col-1 form-control" style="height:15px; margin-top:12px; margin-left:30px;" type="checkbox" name="agree" id="agree" />&nbsp;&nbsp;
            	<label class="col-form-label" for="agree" ><small>Get updates on MOSACOYA news and promotions.</small></label>
         	</div>

		  	<div class="form-group row col-md-10 mx-auto">
				<button class="btn btn-warning btn-lg col-8 mx-auto" style="border-radius: 5px; font-weight:bold;" id="btnRegister" onclick="goRegister()">CREATE ACCOUNT</button>
		  	</div>
		  	<div  class="col-10 mx-auto " >
		  		<a class="mx-auto" style="font-size:10pt;" href="#">V 회원가입하면 바로 마이페이지로감</a>
			</div>
		</form>
		
		<div class="p2 col-10 mx-auto text-center" style="width:500px">
			"Already have an account?"
			<a class="underline p2" style="cursor: pointer;" href="#">Sign in here.</a>
		</div>
		
		<br><br><br><br><br><br>

	</div>

</body>
</html>

<jsp:include page="../../jaesik/footer.jsp"/>