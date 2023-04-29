<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../jaesik/header.jsp" />
<jsp:include page="navbar_order_pay.jsp" />

<style type="text/css">

	button#btnPay, button#btnPostcode {
		background-color: #fdd007;
		border: none;
		box-shadow: 1px 1px 1px 1px #e6e6e6;
	}
	input#address, input#detailAddress, input#extraAddress {
		background-color: #ffffff;
	}

</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("div#div_container").hide();
		$("div#div_container").fadeIn(2000);
		$("span.error").hide();

		let b_flag_goPay = false; // goPay() 함수에서 b_flag_goPay 가 true 이면 "결제정보"로 이동가능

	// *** 1. "고객정보동일" 체크박스를 클릭하면 발생하는 이벤트
		$("input:checkbox[id='checkbox_same']").click((e)=>{
			if($(e.target).prop("checked")){ // "고객정보동일" 체크박스가 체크되어있으면
				$("input#name").val($("div[name='name']").text()); 		 			 // 수령자성명
				$("input#hp1").val($("div[name='mobile']").text().substring(0,3)); 	 // 수령자연락처
				$("input#hp2").val($("div[name='mobile']").text().substring(3,7));
				$("input#hp3").val($("div[name='mobile']").text().substring(7));
				$("input#mobile").val($("div[name='mobile']").text());
				$("input#postcode").val($("div[name='postcode']").text()); 			 // 우편번호
				$("input#address").val($("div[name='address']").text()); 			 // 주소
				$("input#detailAddress").val($("div[name='detailAddress']").text()); // 상세주소
				$("input#extraAddress").val($("div[name='extraAddress']").text());   // 참고주소

				$("span.error").hide();
				b_flag_goPay = true;
			}
		}); // end of $("input:checkbox[id='checkbox_same']").click((e)=>{})

		
	// *** 2. "수령자" 유효성검사
		$("input#name").blur((e)=>{
			if($(e.target).val() == ""){
				$(e.target).val("");
				$(e.target).parent().find("span.error").show(); // 에러메시지 보여주기
			}
		}); // end of $("input#name").blur((e)=>{})
	
		
	// *** 3. "연락처" 유효성검사
		$("input#hp2").blur((e)=>{
			const regExp = /^\d{4}$/g;
			if(!regExp.test($(e.target).val())){
				$(e.target).val("");
				$(e.target).parent().find("span.error").show(); // 에러메시지 보여주기
			}
		}); // end of $("input#hp2").blur((e)=>{})

		$("input#hp3").blur((e)=>{
			const regExp = /^\d{4}$/g;
			if(!regExp.test($(e.target).val())){
				$(e.target).val("");
				$(e.target).parent().find("span.error").show(); // 에러메시지 보여주기
			}
		}); // end of $("input#hp3").blur((e)=>{})
		
		
	// *** 4. "우편번호찾기"
		$("button#btnPostcode").click(function(){
			searchPostcode(); // 다음 openAPI 실행
		}); // end of $("button#btnPostcode").click(function(){})
		
		// "우편번호찾기"를 클릭하지 않고 주소를 입력하려고 할 경우
		$("input#postcode").focus(function(){
			searchPostcode(); // 다음 openAPI 실행
			$("input#delivery_comment").focus();
		}); // end of $("input#postcode").change(function(){})


	// *** 5. 필수입력사항 input 태그가 change 되었을때 발생하는 이벤트
		$("input.required").change(function(){
			$("input#checkbox_same").prop("checked", false);
		}); // end of $("input.required").change(function(){})

		
	// *** 6. "결제하기" 버튼 클릭하면 발생하는 이벤트
		$("button#btnPay").click(function(){ // "결제하기" 노란 버튼 클릭
			// 필수입력사항 전부 입력했는지 체크하기
			$("input.required").each(function(index, elmt){
				if($(elmt).val() == ""){ // 필수입력사항을 입력하지 않은 경우
					b_flag_goPay = false;
					return false;
				}
			}); // end of $("input.required").each(function(index, elmt){})
			
			if(b_flag_goPay){ // 필수입력사항을 모두 입력한 경우
				goPay();
			}
		}); // end of $("button#btnPay").click(function(){})
		
		$("a#btnPay").click(function(){ // 상단바의 "결제정보" 노란 동그라미 링크 클릭
			// 필수입력사항 전부 입력했는지 체크하기
			$("input.required").each(function(index, elmt){
				if($(elmt).val() == ""){ // 필수입력사항을 입력하지 않은 경우
					b_flag_goPay = false;
					return false;
				}
			}); // end of $("input.required").each(function(index, elmt){})
			
			if(b_flag_goPay){ // 필수입력사항을 모두 입력한 경우
				goPay();
			}
		}); // end of $("a#btnPay").click(function(){})

	}); // end of $(document).ready(function(){})

	////////////////////////////////////////////////////////////////////////////////////////////

	// 우편번호 찾기 함수
	function searchPostcode(){
		$("input#postcode").val("");      // 우편번호
		$("input#address").val(""); 	  // 주소
		$("input#detailAddress").val(""); // 상세주소
		$("input#extraAddress").val("");  // 참고주소
		
		
		new daum.Postcode({
			oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
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

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
	    	}
		}).open();
		
		if($("input#postcode").val() != ""){
			$("input#postcode").parent().find("span.error").hide(); 
		}
		
	} // end of function searchPostcode()
	
	
	// "결제하기" 클릭하면 호출되는 함수
	function goPay(){
		const frm = document.deliveryFrm;
		frm.action = "<%= request.getContextPath()%>/shop/payment.moc";
		frm.method = "post";
		frm.submit();
	} // end of function goPay()
	
</script>

<div id="div_container" class="container py-4 mx-auto my-3" style="background-color: #fefce7; border-radius: 1%;">
		
		<h2 class="text-center py-2">배송정보</h2>
		
		<div class="col-md-10 py-5 mx-auto">
		  <h5 class="pb-3 row col-md-10 mx-auto">고객정보</h5>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="name" class="col-md-3 col-form-label">성명</label>
		    <div class="col-md-8 form-control" name="name">${sessionScope.loginuser.name}</div>
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="userid" class="col-md-3 col-form-label">아이디</label>
		    <div class="col-md-8 form-control" name="userid">${sessionScope.loginuser.userid}</div>
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="email" class="col-md-3 col-form-label">이메일</label>
		    <div class="col-md-8 form-control" name="email">${sessionScope.loginuser.email}</div>
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="mobile" class="col-md-3 col-form-label">연락처</label>
		    <div class="col-md-8 form-control" name="mobile">${sessionScope.loginuser.mobile}</div>
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="address" class="col-md-3 col-form-label">주소</label>
		    <div class="col-md-4 form-control ml-0" name="postcode">${sessionScope.loginuser.postcode}</div>
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <div class="col-md-8 form-control" name="address">${sessionScope.loginuser.address}</div>
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <div class="col-md-8 form-control" name="extraAddress">${sessionScope.loginuser.extraaddress}</div>
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <div class="col-md-8 form-control" name="detailAddress">${sessionScope.loginuser.detailaddress}</div>
		  </div>
		</div>

	
		<form name="deliveryFrm" class="col-md-10 py-5 mx-auto border-top">
		  <div class="pb-3 row col-md-10 mx-auto">
			  <h5 class="col-md-3">배송정보</h5>
			  <label for="checkbox_same" class="mr-5"><input type="checkbox" id="checkbox_same" /> 고객정보와 동일합니다.</label>
			  <span style="color:red;">*</span><span>&nbsp;은 필수입력사항입니다.</span>
		  </div>
		  			  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="name" class="col-md-3 col-form-label">수령자<span style="color:red;">&nbsp;*</span><span class="error" style="color:red;">&nbsp;필수입력</span></label>
		    <input type="text" class="required col-md-8 form-control" id="name" name="name" placeholder="수령자 성명" />
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="mobile" class="col-md-3 col-form-label">연락처<span style="color:red;">&nbsp;*</span><span class="error" style="color:red;">&nbsp;필수입력</span></label>
		      <input type="text" class="col-md-2 form-control" id="hp1" placeholder="010" readonly />
		    <span class="pt-1 col-md-1 text-center">&nbsp;-&nbsp;</span>
		      <input type="text" class="required col-md-2 form-control" id="hp2" minlength="4" maxlength="4" />
		    <span class="pt-1 col-md-1 text-center">&nbsp;-&nbsp;</span>
		      <input type="text" class="required col-md-2 form-control" id="hp3" minlength="4" maxlength="4" />
		      <input type="hidden" id="mobile" name="mobile" />
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="address" class="col-md-3 col-form-label">주소<span style="color:red;">&nbsp;*</span><span class="error" style="color:red;">&nbsp;필수입력</span></label>
		    <input type="text" class="required col-md-5 form-control" id="postcode" name="postcode" placeholder="우편번호" />
			<div class="col-md-1"></div>
			<button type="button" id="btnPostcode" class="col-md-2 btn-sm">우편번호 찾기</button>
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"><span class="error" style="color:red;">&nbsp;필수입력</span></div>
		    <input type="text" class="required col-md-8 form-control" id="address" name="address" placeholder="수령자 주소" readonly />
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"><span class="error" style="color:red;">&nbsp;필수입력</span></div>
		    <input type="text" class="required col-md-8 form-control" id="extraAddress" name="extraAddress" placeholder="참고주소" readonly />
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"><span class="error" style="color:red;">&nbsp;필수입력</span></div>
		    <input type="text" class="required col-md-8 form-control" id="detailAddress" name="detailAddress"placeholder="상세주소" />
		  </div>

		  <div class="form-group row col-md-10 mx-auto mb-3">
		    <label for="delivery_comment" class="col-md-3 col-form-label">요청사항</label>
		    <input type="text" class="col-md-8 form-control" id="delivery_comment" name="delivery_comment" placeholder="택배 기사님께 전달하는 내용입니다. (0/50자)" />
		  </div>

		  <div class="row col-md-10 mx-auto my-5">
			<div class="col-md-8"></div>
			<div class="col text-center"><button type="button" id="btnPay" class="btn btn-lg">계속하기</button></div>
		  </div>
		</form>
	</div>
<div style="height: 100px;"></div>

<jsp:include page="../jaesik/footer.jsp" />
	