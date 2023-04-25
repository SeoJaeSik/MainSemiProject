<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../jaesik/header.jsp" />

<style type="text/css">

	span#product_color {
		display: inline-block;
		width: 20px;
		height: 20px;
		margin-left: 10px;
		position: relative;
		top: 5px;
	}
	div#div_extra {
		background-color: #fff9e5;
	}
	button#btnOrder, button#btnAdd, button#btnOptionChange, div#card_warranty {
		background-color: #fdd007;
		border: none;
	}
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
    	-webkit-appearance: none;
    	margin: 0;
	}
</style>

<script type="text/javascript">

	let cart_product_count;
	let b_flag = false;
	let b_flag_click_btnUpdate = false;
	
	$(document).ready(function(){

		$("div#body").hide();
		$("span#error").hide();
		
	// *** 1. 수량 관련 이벤트
		// 수량에서 "+" 또는 "-" 를 클릭하면 발생하는 이벤트
		$("button.changeCount").click(function(){
			
			cart_product_count = $(this).parent().find("input").val();
			
			if($(this).text() == "+"){
				cart_product_count = Number(cart_product_count)+1;
			}
			else {
				cart_product_count = Number(cart_product_count)-1;
			}
			checkChangeCount();
			$(this).parent().find("input").val(cart_product_count);
			// 수량을 입력하는 input 태그의 value 값을 알아와서, 그 자리에 수량+1 또는 수량-1 한 값을 꽂아넣어준다.
			$(this).parent().parent().find("span").show(); // 에러메시지 보여주기
			b_flag_click_btnUpdate = true; // "변경" 버튼 클릭해야 한다.

		}); // end of $("button.changeCount").click(function(){})

		// 수량이 변하면 발생하는 이벤트
		$("input#cart_product_count").bind("change", function(){
		
			cart_product_count = $(this).val();
			checkChangeCount();
			$(this).val(cart_product_count);
			$(this).parent().parent().find("span").show(); // 에러메시지 보여주기
			b_flag_click_btnUpdate = true; // "변경" 버튼 클릭해야 한다.
		
		}); // end of $("input#cart_product_count").bind("change", function(){})
		
	//////////////////////////////////////////////////////////////////////////////////////////
		
		$("input#CheckAll_product").prop("checked", true);
		$("input#CheckOne_product").prop("checked", true);
		
	// *** 2. 제품 체크박스 관련 이벤트
		// "전체상품선택" 체크박스를 클릭하면
		$("input#CheckAll_product").click((e)=>{
			if($(e.target).prop("checked")){ // 체크
				$("input#CheckOne_product").prop("checked", true);
				b_flag = false;
			}
			else { // 체크해제
				$("input#CheckOne_product").prop("checked", false);
				b_flag = true;
			}
		}); // end of $("input#CheckAll_product").click((e)=>{})

		// 제품한개 체크박스를 클릭하면
		$("input#CheckOne_product").click((e)=>{
			
			const bool = $(e.target).prop("checked");
			if(!bool){ // 제품한개 체크해제
				$("input#CheckAll_product").prop("checked", false);
			}
			else { // 제품한개 체크
				b_flag = false;
				$("input#CheckOne_product").each(function(index, elmt){
					
					if( !$(elmt).prop("checked") ){ // 제품 한개라도 체크해제된 경우
						$("input#CheckAll_product").prop("checked", false); // "전체상품선택" 해제
						b_flag = true;
						return false; // 종료
					}
					
					if(!b_flag){ // 제품이 모두 선택된 경우
						$("input#CheckAll_product").prop("checked", true); // "전체상품선택" 체크
					}
				}); // end of $("input#CheckOne_product").each(function(index, elmt){})
			}
		}); // end of $("input#CheckOne_product").click((e)=>{})

	
		// "주문하기" 를 클릭하면 발생하는 이벤트
		$("button#btnOrder").click(function(){
			
			if(b_flag){ // 체크된 제품이 하나도 없을경우
				alert("선택한 상품이 없습니다.");
			}
			else { // 한개이상의 제품이 체크된 경우
				const frm = document.CartListFrm;
				frm.action = "<%= request.getContextPath()%>/shop/delivery.moc";
				frm.method = "post";
				frm.submit();
			}
		}); // end of $("button#btnOrder").click(function(){})
		
		
	// *** 3. 장바구니 변경사항을 DB에 반영하기 - AJAX 후 새로고침
		// 1) 수량변경 후 "변경" 버튼 클릭 - tbl_cart 테이블의 cart_product_count 를 update
		$("btn#btnCartUpdate").click(function(){
			console.log($(this).prev().find("input").val());
	     	<%--
			$.ajax({
				url:"<%= ctxPath%>/shop/cartListUpdate.moc",
	     		data:{"cart_product_count":$(this).prev().find("input").val()}, 
	     		type:"post",
	     		dataType:"json",
	     		async:true,
	     		success:function(json) {
	     			if(json.isExists) { // 입력한 email 이 이미 사용중이라면
	     				$("span#emailCheckResult").html($("input#email").val()+" 은 중복된 email 이므로 사용불가 합니다.").css("color","red");
	     				$("input#email").val("");
	     			}
	     			else { // 입력한 email 이 존재하지 않는 경우라면
	     				$("span#emailCheckResult").html($("input#email").val()+" 은 사용가능 합니다.").css("color","navy");         				
	     			}
	     		},
	     		error: function(request, status, error) {
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	     	});
	     	--%>
			
		}); // end of $("btn#btnCartUpdate").click(function(){})
		
		// 2) 옵션변경의 팝업창에서 "변경" 버튼 클릭 - tbl_cart 테이블의 fk_product_no 를 update
		$("btn#btnOptionChange").click(function(){
			
			// 팝업창 띄우기
			
		}); // end of $("btn#btnOptionChange").click(function(){})
		
		// 3) "추가하기" 버튼 클릭 - tbl_cart 테이블에 insert
		$("btn#btnAdd").click(function(){
			console.log($(this).prev().find("input").val());
			<%--
			$.ajax({
				url:"<%= ctxPath%>/shop/cartListUpdate.moc",
	     		data:{"email":$("input#email").val()}, 
	     		type:"post",
	     		dataType:"json",
	     		async:true,
	     		success:function(json) {
	     			if(json.isExists) { // 입력한 email 이 이미 사용중이라면
	     				$("span#emailCheckResult").html($("input#email").val()+" 은 중복된 email 이므로 사용불가 합니다.").css("color","red");
	     				$("input#email").val("");
	     			}
	     			else { // 입력한 email 이 존재하지 않는 경우라면
	     				$("span#emailCheckResult").html($("input#email").val()+" 은 사용가능 합니다.").css("color","navy");         				
	     			}
	     		},
	     		error: function(request, status, error) {
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	     	});
			--%>
			
		}); // end of $("btn#btnAdd").click(function(){})
		
		// 4) "삭제" 버튼 클릭 - tbl_cart 테이블에서 delete
		$("btn#btnDelete").click(function(){
			<%--
			$.ajax({
				url:"<%= ctxPath%>/shop/cartListUpdate.moc",
	     		data:{"email":$("input#email").val()}, 
	     		type:"post",
	     		dataType:"json",
	     		async:true,
	     		success:function(json) {
	     			if(json.isExists) { // 입력한 email 이 이미 사용중이라면
	     				$("span#emailCheckResult").html($("input#email").val()+" 은 중복된 email 이므로 사용불가 합니다.").css("color","red");
	     				$("input#email").val("");
	     			}
	     			else { // 입력한 email 이 존재하지 않는 경우라면
	     				$("span#emailCheckResult").html($("input#email").val()+" 은 사용가능 합니다.").css("color","navy");         				
	     			}
	     		},
	     		error: function(request, status, error) {
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	     	});
			--%>
		}); // end of $("btn#btnDelete").click(function(){})
		
	}); // end of $(document).ready(function(){})
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	// 수량이 변하면 호출되는 함수(1개~10개로 수량제한한다.)
	function checkChangeCount(){
		if(isNaN(cart_product_count) || cart_product_count <= 0){ 
			// 수량에 숫자가 아닌 값 또는 음수가 들어오면
			cart_product_count = "1";
		}
		else if(cart_product_count > 10){ // 수량이 10개보다 크면
			cart_product_count = "10";
			alert("최대 10개까지만 구매가능합니다.");
		}
	} // end of function checkChangeCount()
			
</script>
	<form name="CartListFrm">
	<div class="container mt-5 mx-auto">
		
		<h2 class="text-center pb-3">장바구니</h2>
		<div class="row pb-3 mx-1">
			<div class="col-md-10 align-self-end">
				<label for="CheckAll_product"><input type="checkbox" name="CheckAll_product" id="CheckAll_product" /> 전체 상품 선택/해제</label>
			</div>
			<div class="col-md-2">
				<button type="button" id="btnOrder" class="btn btn-lg px-4">주문하기</button>
			</div>
		</div>
		
		<div class="table-responsive mx-auto">
			<table class="table text-center" id="tbl_cart">
			  <thead>
			    <tr>
			    	<th colspan="3" class="col-md-6">상품/옵션</th>
			      	<th class="col-md-2">가격</th>
			      	<th class="col-md-2">수량</th>
			      	<th class="col-md-2">합계</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach var="pvo" items="${requestScope.cartList}">
			    <tr class="pt-2">
			    	<td><input type="checkbox" name="CheckOne_product" id="CheckOne_product" />
			    		<input style="display: none;" value="${pvo.cart_no}" />
			    	</td>
			      	<td><img src="${pvo.product_image}" id="product_image" name="product_image" width="150"/></td>
			      	<td class="text-left">
			      		<div id="product_name" name="product_name">${pvo.product_name}</div>
			      		<div id="product_color" name="product_color">${pvo.product_color}<span>&nbsp;</span><span id="product_size" name="product_size">${pvo.product_size}</span></div>
			      		<button type="button" id="btnOptionChange" class="btn btn-sm my-2">옵션변경</button>
			      		<button type="button" id="btnDelete" class="btn btn-sm my-2" style="color: gray;">삭제</button>
			      	</td>
			      	<td id="product_price" name="product_price"><fmt:formatNumber value="${pvo.product_price}" pattern="###,###" />원</td>
			      	<td>
				      	<span class="border py-1" style="border: solid 1px gray;">
				      	  	<button type="button" class="btn btn-sm changeCount">-</button>
					      	<input type="number" value="${pvo.cart_product_count}" id="cart_product_count" name="cart_product_count" class="col-md-2 text-center px-0" style="border: none;"/>
					      	<button type="button" class="btn btn-sm changeCount">+</button>
					    </span>
					    <button type="button" id="btnCartUpdate" class="btn btn-sm">변경</button><br>
					    <span id="error" class="text-danger" style="font-size: 10pt;">변경버튼을 눌러주세요</span>
				    </td>
			      	<td id="cart_product_price" name="cart_product_price" style="font-size: 14pt; font-weight: bold;">
			      		<fmt:formatNumber value="${pvo.cart_product_price}" pattern="###,###" />원
			      	</td>
			    </tr>
			  </c:forEach>
			  </tbody>
			</table>
		</div>
		
		<div id="div_extra" class="row my-5 py-3 mx-1">
			<div class="col-md-3 text-right align-self-center">함께 구매하면 좋은 상품</div>
			<div class="col-md-2 text-center"><img src="https://image.nbkorea.com/NBRB_Product/20230331/NB20230331151327051001.jpg" id="product_image" name="product_image" width="120" class="img-thumbnail"/></div>
			<div class="col-md-4">
				<div class="my-1">
					<span id="add_product_name" name="add_product_name">프레쉬폼x 860 V13 (남성, D)</span>&nbsp;&nbsp;<span id="product_price" name="product_price">￦169,000</span>
				</div>
	      		<select id="add_product_size" name="add_product_size" class="my-1">
			    <%-- 중복된 부분!! 나중에 제이쿼리로 할 예정 --%>
	      			<option>사이즈</option>
	      			<option>220</option>
	      			<option>240</option>
	      			<option>260</option>
	      		</select>
	      		<div class="my-1">색상
	      			<span id="add_product_color" name="add_product_color" class="rounded-circle" style="background-color: red;"></span>
	      			<span id="add_product_color" name="add_product_color" class="rounded-circle" style="background-color: blue;"></span>
	      		</div>
			</div>
			<div class="col-md-3 align-self-center text-center">
				<button type="button" id="btnAdd" class="btn btn-lg px-5 py-3">추가하기</button>
			</div>
		</div>
		
		<div class="row my-5">
			<div class="col-md-8"></div>
			<div class="card mx-n5">
				<div id="card_warranty" class="card-body text-center" style="font-size: 10pt; font-weight: bold;">MOSACOYA 품질보장 모든 상품에 대하여 구매 시 1년 보증</div>
			</div>
		</div>

		<div id="div_price" class="my-5 mx-1">
			<div class="row m-2">
				<div class="col-md-9"></div>
				<div class="col" style="font-size: 14pt; font-weight: bold;">주문금액</div>
				<div class="col text-right" id="total_price" name="total_price" style="font-size: 14pt; font-weight: bold;">￦636,000</div>
			</div>
			<div class="row m-2">
				<div class="col-md-9"></div>
				<div class="col" style="font-size: 14pt; font-weight: bold;">배송비</div>
				<div class="col text-right" id="delivery_fee" name="delivery_fee" style="font-size: 14pt; font-weight: bold;">￦0</div>
			</div>
		</div>

		<div class="row my-5 px-1">
			<div class="col-md-8"></div>
			<div class="col align-self-center text-right"><button type="button" id="btnContinue" class="btn btn-sm">쇼핑 계속하기</button></div>
			<div class="col align-self-center text-left"><button type="button" id="btnOrder" class="btn btn-lg px-4">주문하기</button></div>
		</div>
		
	</div>
	</form>

		
<jsp:include page="../jaesik/footer.jsp" />
	