<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../jaesik/header.jsp"/>


<!-- 다음소스 가져오기 !-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

    let b_flag_idDuplicate_click 	= false;	// ▷ "아이디 중복확인" 클릭여부
	let b_flag_emailDuplicate_click = false; 	// ▷ "이메일 중복확인" 클릭여부
	let b_flag_zipcodeSearch_click 	= false; 	// ▷ "우편번호 찾기" 클릭여부 

	
	$(document).ready(function(){
		
		
		$("small.error").hide();  // 처음에 경고문구 다 안 뜨게 숨겨놓고,
		$("input#name").focus(); // 성명 입력창에 포커스를 놓는다
		
		
		// == 1. name 에서 포커스 잃음
		$("input#name").blur( (e) => { 
			if( $(e.target).val().trim() == "" ) {	// 1-1 입력하지 않았거나 공백만 입력했을 경우 
				
				// 폼태그의 input 태그를 모두 비활성화하고 name 만 해제 후 에러문구 보여줌
				$("form[name='frmMemberRegister']:input").prop("disabled", true); 	
				$(e.target).prop("disabled", false);                        			
				$(e.target).parent().find("small.error").show();
				$(e.target).focus();
			}
			else {									// 1-2 공백만이 아닌 글자를 입력한 경우 
				$("form[name='frmMemberRegister']:input").prop("disabled", false); 
				$(e.target).parent().find("small.error").hide();
			}
		});//end of 1. name 에서 포커스 잃음 ----------------------------
		
		
		// == 2. userid 에서 포커스 잃음
		$("input#userid").blur( (e) => { 
			if( $(e.target).val().trim() == "" ) {	// 2-1 입력하지 않았거나 공백만 입력했을 경우 
				
				$("form[name='frmMemberRegister']:input").prop("disabled", true);
				$(e.target).prop("disabled", false);                        
				$(e.target).parent().find("small.error").show();
				$(e.target).focus();
			}
			else {									// 2-2 공백만이 아닌 글자를 입력한 경우 
				$("form[name='frmMemberRegister']:input").prop("disabled", false);
				$(e.target).parent().find("small.error").hide();
			}	
		});//end of 2. userid 에서 포커스 잃음 ----------------------------
		
		
		// == 2-1 아이디 중복확인 클릭 
        $("button#idcheck").click(function(){ 
        	
        	b_flag_idDuplicate_click = true;
            
			$.ajax({
	        	url:"<%= ctxPath%>/member/idDuplicateCheck.moc",
	        	data:{"userid":$("input#userid").val()},// data 	: url 로 전송해야할 데이터
	        	type:"post", 							// type 	: 생략하면 기본값은 get (method 아니고 type 임)
	        //	dataType:"json", 						// dataType : url 로 부터 실행되어진 결과물을 받아오는 데이터타입
	        	async:true,  							// async	: true 는 비동기 방식 으로 생략하면 기본값이 true
	                         							// async	: false 는 동기 방식(url 에 결과물을 받아올 때까지 그대로 대기하고 있는 것) 지도를 할 때는 반드시 동기방식인 async:false 를 사용해야만 지도가 올바르게 나온다.
	        	success:function(text){ 	        		 
	        		// dataType:"json" 을 생략하면 
	        		// 파라미터 json 에 "{"isExists":true}" 또는 "{"isExists":false}" 인 string 타입의 결과물이 들어오게 된다.
	        		
	        		const json = JSON.parse(text);
	        		// JSON.parse(text); 은 JSON.parse("{"isExists":true}"); 또는 JSON.parse("{"isExists":false}"); 와 같은 것인데
	                // 그 결과물은 {"isExists":true} 또는 {"isExists":false} 와 같은 문자열을 자바스크립트 객체로 변환해주는 것이다. 
	                // 조심할 것은 text 는 반드시 JSON 형식으로 되어진 문자열이어야 한다. 
	                  
	        		if(json.isExists) {
	        			// 입력한 userid 가 이미 사용중이라면
	        			$("span#idcheckResult").html($("input#userid").val() + " 은 이미 사용중인 ID 입니다.").css("color","red");
	        			$("input#userid").val(""); /* 중복됐다고 경고하면서 싹 비움 */
	        		}
	        		else if(!json.isExists && $("input#userid").val().trim() != ""){
	        			// 입력한 userid 가 존재하지 않는 경우라면
	        			$("span#idcheckResult").html($("input#userid").val() + " 은 사용가능한 ID 입니다.").css("color","blue");
	        		}
	        	},
	        	error:function(request, status, error){ // 어딘가 잘못된 부분이 발생하면 alert 를 띄운다
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	                         
	        });//end of  $.ajax({})---------------------------------------------
        
        });//end of 2-1 아이디 중복확인 클릭 --------------------------------
		
		
     	// 2-2 위에서 그치면 처음 중복확인만 누르면 그다음에도 중복된 아이디를 입력했음에도 확인을 안눌러도 가입하기로 넘어가므로
        // 가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭했는지 알아보기 위한 용도로 무조건 아이디 값이 변경되면 초기화 시킨다!
        $("input#userid").bind("change",function(){
           	b_flag_idDuplicate_click = false;
        });
	
        
		// == 3. email 에서 포커스 잃음
		$("input#email").blur( (e) => { 
			const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			const bool = regExp.test($(e.target).val()); 
			
			if(!bool) { // 3-1 이메일이 정규표현식이 아닌 경우
				
				$("form[name='frmMemberRegister']:input").prop("disabled", true);
				$(e.target).prop("disabled", false);      
				$(e.target).parent().find("small.error").show();
				$(e.target).focus();
			}
			else {		// 3-2 이메일이 정규표현식이 맞는 경우 
				$("form[name='frmMemberRegister']:input").prop("disabled", false);
				$(e.target).parent().find("small.error").hide();
			}
		});//end of 3. email 에서 포커스 잃음 ----------------------------
		
		
		// == 3-1 이메일 중복확인 클릭 
        $("button#emailcheck").click(function(){ 
        	
        	b_flag_emailDuplicate_click = true;
        
			$.ajax({
	        	
	        	url:"<%= ctxPath%>/member/emailDuplicateCheck.moc",
	        	data:{"email":$("input#email").val()},	// data 	: url 로 전송해야할 데이터
	        	type:"post", 							// type 	: 생략하면 기본값은 get (method 아니고 type 임)
	        	dataType:"json", 						// dataType : url 로 부터 실행되어진 결과물을 받아오는 데이터타입
	        	async:true,  							// async	: true 는 비동기 방식 으로 생략하면 기본값이 true
	                         							// async	: false 는 동기 방식(url 에 결과물을 받아올 때까지 그대로 대기하고 있는 것) 지도를 할 때는 반드시 동기방식인 async:false 를 사용해야만 지도가 올바르게 나온다.
	        	success:function(json){ 	        		 
	        		// dataType:"json" 을 생략하지않고 넣어주면 
	        		// 파라미터 json 에 {"isExists":true} 또는 {"isExists":false} 인 Object 타입의 결과물이 들어오게 된다.
	        		console.log(JSON.stringify(json));
	        		
	        		if(json.isExists) {
	        			// 입력한 email 가 이미 사용중이라면
	        			$("span#emailCheckResult").html($("input#email").val() + " 은 이미 사용중인 email 입니다.").css("color","red");
	        			$("input#email").val(""); /* 중복됐다고 경고하면서 싹 비움 */
	        		}
	        		else if(!json.isExists && $("input#email").val().trim() != ""){
	        			// 입력한 email 가 존재하지 않는 경우라면
	        			$("span#emailCheckResult").html($("input#email").val() + " 은 사용가능한 email 입니다.").css("color","blue");
	        		}
	        	},
	        	error:function(request, status, error){ // 어딘가 잘못된 부분이 발생하면 alert 를 띄운다
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	                         
	        });//end of  $.ajax({})---------------------------------------------
        
        });//end of 3-1 이메일 중복확인 클릭 --------------------------------
		
        
     	// 3-2) 위에서 그치면 처음 중복확인만 누르면 그다음에도 중복된 email을 입력했음에도 확인을 안눌러도 가입하기로 넘어가므로
        // 가입하기 버튼을 클릭시 "email중복확인" 을 클릭했는지 알아보기 위한 용도로 무조건 email 값이 변경되면 초기화 시킨다!
        $("input#email").bind("change",function(){
			b_flag_emailDuplicate_click = false;
        });
        
		
		// == 4. pwd 에서 포커스 잃음
		$("input#pwd").blur( (e) => { 
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 2 
			const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			const bool = regExp.test($(e.target).val()); 
			
			if(bool == false) {	// 4-1 암호가 정규표현식이 맞는 경우 
				
				$("form[name='frmMemberRegister']:input").prop("disabled", true);
				$(e.target).prop("disabled", false); 
				$(e.target).parent().find("small.error").show();
				$(e.target).focus();
			}
			else {				// 4-2 암호가 정규표현식이 아닌 경우
				$("form[name='frmMemberRegister']:input").prop("disabled", false);
				$(e.target).parent().find("small.error").hide();
			}
		});//end of 4. pwd 에서 포커스 잃음 ----------------------------
		
		
		// == 5. pwdcheck 에서 포커스 잃음
		$("input#pwdcheck").blur( (e) => { 
			if( $("input#pwd").val() != $("input#pwdcheck").val() ) {	// 5-1 다른경우
				
				$("form[name='frmMemberRegister']:input").prop("disabled", true); 
				$(e.target).prop("disabled", false);   
				$("input#pwd").prop("disabled", false); // 둘 다 살리고 포커스를 비밀번호에 주겠다
				$(e.target).parent().find("small.error").show();
				$("input#pwd").focus();
			}
			else {														// 5-2 같은경우 
				$("form[name='frmMemberRegister']:input").prop("disabled", false); 
				$(e.target).parent().find("small.error").hide();
			}
		});//end of 5. pwdcheck 에서 포커스 잃음 ----------------------------
		
		
		// == 6. hp2 에서 포커스 잃음
		$("input#hp2").blur( (e) => { 
			
			// 첫자리만 1-9 가, 그 뒤 최소2~최대3 는 0-9 가 들어올 수 있다
			const regExp = /^[1-9][0-9]{2,3}$/i;  
			const bool = regExp.test($(e.target).val()); 
			
			if(bool == false) {	// 6-1 가운데 전화번호 3-4자리가 정규표현식이 아닌 경우 
				$("form[name='frmMemberRegister']:input").prop("disabled", true);
				$(e.target).prop("disabled", false); 
				$(e.target).parent().find("small.error").show();
				$(e.target).focus();
			}
			else {				// 6-2 가운데 전화번호 3-4자리가 정규표현식이 맞는 경우 
				$("form[name='frmMemberRegister']:input").prop("disabled", false); 
				$(e.target).parent().find("small.error").hide();
			}
		});//end of 6. hp2 에서 포커스 잃음 ----------------------------
		
		
		// == 7. hp3 에서 포커스 잃음
		$("input#hp3").blur( (e) => { 
			
			// 숫자 4자리만 들어옴
			const regExp = /^\d{4}$/i; 
			const bool = regExp.test($(e.target).val()); 
			
			if(bool == false) {	// 7-1 마지막 전화번호 4자리가 정규표현식이 아닌 경우 
				$("form[name='frmMemberRegister']:input").prop("disabled", true);
				$(e.target).prop("disabled", false); 
				$(e.target).parent().find("small.error").show();
				$(e.target).focus();
			}
			else {				// 7-2 마지막 전화번호 4자리가 정규표현식이 맞는 경우 
				$("form[name='frmMemberRegister']:input").prop("disabled", false); 
				$(e.target).parent().find("small.error").hide();
			}
		});//end of 7. hp3 에서 포커스 잃음 ----------------------------
		
		 
		// == 8. 우편번호찾기 버튼 클릭 (DAUM 에서 코드 참고함) 
		$("button#zipcodeSearch").click(function(){ 
			
			b_flag_zipcodeSearch_click = true; // 버튼 클릭함을 표시 (false -> true 로 변경)

			new daum.Postcode({
		        oncomplete: function(data) {
		        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
		            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		            let addr = ''; // 주소 변수
		            let extraAddr = ''; // 참고항목 변수

		            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		            if (data.userSelectedType === 'R') {// 사용자가 도로명 주소를 선택했을 경우 (R)
		                addr = data.roadAddress;
		            } else { 							// 사용자가 지번 주소를 선택했을 경우(J)
		                addr = data.jibunAddress;
		            }

		            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		            if(data.userSelectedType === 'R'){
		                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraAddr += data.bname;
		                }
		                // 건물명이 있고, 공동주택일 경우 추가한다.
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                if(extraAddr !== ''){
		                    extraAddr = ' (' + extraAddr + ')';
		                }
		                // 조합된 참고항목을 해당 필드에 넣는다.
		                document.getElementById("extraAddress").value = extraAddr;
		            
		            } else {
		                document.getElementById("extraAddress").value = '';
		            }

		            console.log("~~~~ 확인 extraAddr : " + extraAddr);
		            
		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            document.getElementById('postcode').value = data.zonecode;
		            document.getElementById("address").value = addr;
		            // 커서를 상세주소 필드로 이동한다.
		            document.getElementById("detailAddress").focus();
	        	}
	    	}).open();
			
		});//end of 8. 우편번호찾기 실행 ----------------
		
        
        // 8-1 우편번호 입력란에 키보드로 입력할 경우 막아주는 이벤트 처리하기
        $("input:text[id='postcode']").keyup(function(){
        	alert(`우편번호 입력은 "우편번호찾기" 클릭으로만 됩니다.`);
        	$(this).val("");
        });
		
		
		// 9. 성별
		
		
		// 10. 생년월일
		// 년도 
		$("input#birthyyyy").keyup(function(e){
			alert("생년월일은 키보드로 입력하지 마시고 마우스로 선택하세요~");
			$(e.target).val("1950"); /* 1950 으로 디폴트값 잡혀짐 */
		});
		
		// 월 
		let mm_html ="";
		for(let i=1; i<13; i++) {	
			if(i < 10) {
				mm_html += "<option value = '0" + i + "'>0" + i + "</option>";
			}
			else {
				mm_html += "<option value = '" + i + "'>" + i + "</option>";
			}
		}	
		$("select#birthmm").html(mm_html);
		
		// 일
		let dd_html =``;
		for(let i=1; i<32; i++) {
			if(i < 10) {
				dd_html += `<option value = '0\${i}'>0\${i}</option>`;
			}
			else {
				dd_html += `<option value = '\${i}'>\${i}</option>`;
			}
		}
		$("select#birthdd").html(dd_html);
		
		//end of 10. 생년월일 ----------------
		
		
	});//end of ready---------------------------------
	
	
	// "가입하기" 버튼 클릭시 호출되는 함수
	function goRegister() {
		
		// 필수입력사항에 모두 입력이 되었는지 검사
		let b_flag_requiredInfo = false;
		
		$("input.requiredInfo").each(function(index, elt){
			
			if( $(elt).val().trim() == "" ) {
				alert(" * 표시된 필수입력사항은 모두 입력하셔야 합니다.");
				b_flag_requiredInfo = true; 
				return false; // for 에서 쓰는 break 와 동일
			}
		});
		
		if(b_flag_requiredInfo) {
			return; // 함수종료
		}
		// ---------------------------------------------
		
		
		// 1> 성별 radio 선택 x
		const radio_checked_length = $("input:radio[name='gender']:checked").length;
		
		if(radio_checked_length == 0 ) {
			alert("성별을 선택하셔야 합니다.");
			return; // 함수종료
		}
		
		// 2> "아이디 중복확인" 클릭 x
		if( b_flag_idDuplicate_click == false ) {
			alert("아이디 중복확인 을 클릭해야 합니다.");
			return; // 함수종료
		}
		
		// 3> "이메일 중복확인" 클릭 x
		if( b_flag_emailDuplicate_click == false ) {
			alert("이메일 중복확인 을 클릭해야 합니다.");
			return; // 함수종료
		}
		
		// 4> "우편번호 찾기" 클릭 x
		if( b_flag_zipcodeSearch_click == false ) {
			alert("우편번호 찾기 를 클릭해 우편번호를 입력하셔야 합니다.");
			return; // 함수종료
		}
		else {		// 클릭했다면,
			const regExp = /^\d{5}$/g; // 숫자 5자리만 들어오도록 검사해주는 정규표현식 객체 생성 (g는 뭐더라)
			const bool = regExp.test($("input:text[id='postcode']").val());
			
			if(bool == false) {
				alert("우편번호 형식에 맞지 않습니다.");
				$("input:text[id='postcode']").val(""); /* 틀린거 지우고, */
				b_flag_zipcodeSearch_click == false;    /* 클릭안한거랑 똑같이 false 로 변경 */
				return; // 함수종료
			}
			
		}
		
		// ==========================================================
		// ==> 위 경우처럼 뭔가 선택되지 않은 경우에는 아래로 넘어가지 않고 return 된다
		
		const frm = document.frmMemberRegister;
		frm.action = "<%= request.getContextPath()%>/login/memberRegister.moc";
		frm.method = "post";
		frm.submit();
		
	}//end of goRegister()---------------------------

</script>


<div class="bg-white container mt-5 mx-auto">
	<h2 class="text-center pb-3" style="font-weight:bold;">REGISTER</h2>

	<form name="frmMemberRegister" class="col-md-10 py-3 mx-auto">
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label">성명&nbsp;<span class="star">*</span></label>
		    <input class="col-6 form-control" type="text" id="name" name="name" class="requiredInfo" placeholder = "Name" ></input> <%-- autocomplete="off" : 자동완성막아줌 --%>
		    <span><small class="error" style="color:red">Name is required</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label">아이디&nbsp;<span class="star">*</span></label>
		    <input class="col-5 form-control" type="text" id="userid" name="userid" class="requiredInfo" placeholder = "ID" />&nbsp;&nbsp;
		    <button type="button" class="btn btn-secondary btn-sm col-3" id="idcheck" style="border-radius: 20px; width:50px;">ID중복확인</button>
            <span id="idcheckResult"></span>
		    <span><small class="error" style="color:red">ID is required</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto" >
		    <label class="col-3 col-form-label">이메일&nbsp;<span class="star">*</span></label>
		    <input class="col-5 form-control" type="text" id="email" name="email" class="requiredInfo" placeholder = "Email" />&nbsp;&nbsp;
		    <button type="button" class="btn btn-secondary btn-sm col-3" id="emailcheck" style="border-radius: 20px;">email 중복확인</button>
		    <span id="emailCheckResult"></span>
		    <span><small class="error" style="color:red">The email format is not correct.</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label">비밀번호&nbsp;<span class="star">*</span></label>
		    <input class="col-6 form-control" type="password" id="pwd" name="pwd" class="requiredInfo" placeholder = "Password"></input>
		    <span><small class="error" style="color:red">Password is required</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label">비밀번호확인&nbsp;<span class="star">*</span></label>
		    <input class="col-6 form-control" type="password" id="pwdcheck" name="pwdcheck" class="requiredInfo" placeholder = "Confirm Password"></input>
		    <span><small class="error" style="color:red">Please enter valid, matching passwords.</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label">연락처</label>	 
		    <input class="col-2 form-control" type="text" id="hp1" name="hp1" maxlength="3" value="010" readonly />&nbsp; <!-- readonly : 읽기전용으로 010 만 보여주고 변경할 수 없도록 해준다 -->
           	<input class="col-2 form-control" type="text" id="hp2" name="hp2" maxlength="4" />&nbsp;
           	<input class="col-2 form-control" type="text" id="hp3" name="hp3" maxlength="4" />
           	<span><small class="error" style="color:red">It's not phone number type.</small></span>
	  	</div>
	  	
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label">우편번호</label>
		    <input type="text" class="col-3 form-control" id="postcode" name="postcode" placeholder="postcode" />&nbsp;
		    <button type="button" class="btn btn-secondary btn-sm col-3" id="zipcodeSearch" style="border-radius: 20px;">우편번호찾기</button>
			<span><small class="error" style="color:red">It's not postcode type.</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label">주소</label>
		    <input class="col-8 form-control" type="text" id="address" name="address" placeholder="Address" />
	  	</div>
	  	<div class="form-group row col-md-10 mx-auto">	 
		    <label class="col-3 col-form-label"> </label>
           	<input class="col-8 form-control" type="text" id="detailAddress" name="detailAddress" placeholder="Detail Address" />
         	</div>
         	<div class="form-group row col-md-10 mx-auto"> 	
           	<label class="col-3 col-form-label"> </label>
           	<input class="col-8 form-control" type="text" id="extraAddress"  name="extraAddress" placeholder="Extra Address" />
          	<span><small class="error" style="color:red">Address is required.</small></span>
	  	</div>
	  
	  	<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label ">성별</label>
		    <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%; padding-top:9px;">남자</label>
	        <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%; padding-top:9px;">여자</label>
         	</div>

		<div class="form-group row col-md-10 mx-auto">
		    <label class="col-3 col-form-label">생년월일</label>	 
		    <input class="col-3 form-control" type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="1995" required />&nbsp;
           	<select class="col-2 form-control" type="number" id="birthmm" name="birthmm" ></select>&nbsp;
           	<select class="col-2 form-control" type="number" id="birthdd" name="birthdd" ></select>
           	<span><small class="error" style="color:red">It's not phone number type.</small></span>
	  	</div>
	  	
	  	<div class="form-group row col-md-10 mx-auto">
           	<input class="col-1 form-control" style="height:15px; margin-top:12px; margin-left:30px;" type="checkbox" name="agree" id="agree" />&nbsp;&nbsp;
           	<label class="col-form-label" for="agree" ><small>Get updates on MOSACOYA news and promotions.</small></label>
        	</div>

	  	<div class="form-group row col-md-10 mx-auto">
			<button type="button" class="btn btn-warning btn-lg col-8 mx-auto" style="border-radius: 5px; font-weight:bold;" id="btnRegister" onclick="goRegister()">CREATE ACCOUNT</button>
	  	</div>

	</form>
	
	<div id="p2" class="col-10 mx-auto text-center" style="width:500px">
		"Already have an account?"
		<a id="p2" style="cursor: pointer; text-decoration: underline;" href="<%= ctxPath%>/login/login.moc">Sign in here.</a>
	</div>
	
	<br><br><br><br><br><br>

</div>

<jsp:include page="../../jaesik/footer.jsp"/>