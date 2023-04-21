<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="header_order_pay.jsp" />

<style type="text/css">

	button#btnPay, button#btnPostcode {
		background-color: #fdd007;
		border: none;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// "고객정보동일" 체크박스를 클릭하면 발생하는 이벤트
		$("input:checkbox[id='checkbox_same']").click((e)=>{
			if($(e.target).prop("checked")){ // "고객정보동일" 체크박스가 체크되어있으면

			}
		});
		
	}); // end of $(document).ready(function(){})

</script>

	<div class="container mt-5 mx-auto">
		<h2 class="text-center pb-3">배송정보</h2>
		
		<div class="col-md-10 py-5 mx-auto">
		  <h5 class="pb-3 row col-md-10 mx-auto">고객정보</h5>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="name" class="col-md-3 col-form-label">성명</label>
		    <div class="col-md-8 form-control" id="name" name="name">홍길동</div>
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="userid" class="col-md-3 col-form-label">아이디</label>
		    <div class="col-md-8 form-control" id="userid" name="userid">hongkd</div>
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="email" class="col-md-3 col-form-label">이메일</label>
		    <div class="col-md-8 form-control" id="email" name="email">hongkd@gmail.com</div>
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="mobile" class="col-md-3 col-form-label">연락처</label>
		    <div class="col-md-8 form-control" id="mobile" name="mobile">010-1234-5678</div>
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="address" class="col-md-3 col-form-label">주소</label>
		    <div class="col-md-4 form-control ml-0" id="postcode" name="postcode">04001</div>
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <div class="col-md-8 form-control" id="address" name="address">서울특별시 마포구 월드컵북로 21</div>
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <div class="col-md-8 form-control" id="detailaddress" name="detailaddress">2층 풍성빌딩</div>
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <div class="col-md-8 form-control" id="extraaddress" name="extraaddress">쌍용강북교육센터</div>
		  </div>
		</div>

	
		<form name="deliveryFrm" class="col-md-10 py-5 mx-auto border-top">
		  <div class="pb-3 row col-md-10 mx-auto">
			  <h5 class="col-md-3">배송정보</h5>
			  <label for="checkbox_same"><input type="checkbox" id="checkbox_same" /> 고객정보와 동일합니다.</label>
		  </div>
		  			  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="name" class="col-md-3 col-form-label">수령자</label>
		    <input type="text" class="col-md-8 form-control" id="name" name="name" placeholder="수령자 성명" />
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="mobile" class="col-md-3 col-form-label">연락처</label>
		      <input type="text" class="col-md-2 form-control" id="hp1" placeholder="010" readonly />
		    <span class="pt-1 col-md-1 text-center">&nbsp;-&nbsp;</span>
		      <input type="text" class="col-md-2 form-control" id="hp2" />
		    <span class="pt-1 col-md-1 text-center">&nbsp;-&nbsp;</span>
		      <input type="text" class="col-md-2 form-control" id="hp3" />
		  </div>
		  
		  <div class="form-group row col-md-10 mx-auto">
		    <label for="address" class="col-md-3 col-form-label">주소</label>
		    <input type="text" class="col-md-5 form-control" id="postcode" placeholder="우편번호" />
			<div class="col-md-1"></div>
			<button type="button" id="btnPostcode" class="col-md-2 btn-sm">우편번호 찾기</button>
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <input type="text" class="col-md-8 form-control" id="address" placeholder="수령자 주소" />
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <input type="text" class="col-md-8 form-control" id="detailaddress" placeholder="상세주소" />
		  </div>
		  <div class="form-group row col-md-10 mx-auto">
		    <div class="col-md-3"></div>
		    <input type="text" class="col-md-8 form-control" id="extraaddress" placeholder="참고주소" />
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

<jsp:include page="../jaesik/footer.jsp" />
	