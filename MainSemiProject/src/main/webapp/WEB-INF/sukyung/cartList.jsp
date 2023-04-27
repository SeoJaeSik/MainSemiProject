<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../jaesik/header.jsp" />
<jsp:include page="navbar_order_pay.jsp" />

<style type="text/css">

	span#add_product_color {
		display: inline-block;
		width: 20px;
		height: 20px;
		margin-left: 10px;
		position: relative;
		top: 5px;
		border: solid 1px gray;  
	}
	div#div_extra {
		background-color: #fff9e5;
		border-top: solid 1px #cccccc;
		border-bottom: solid 1px #cccccc;
		border-radius: 1%;
	}
	button#btnOrder, button#btnAdd, button#btnOptionEdit {
		background-color: #fdd007;
		box-shadow: 1px 1px 1px 1px #e6e6e6;
	}
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
    	-webkit-appearance: none;
    	margin: 0;
	}
	div#div_cart_empty {
		display: inline-block;
		margin: 30px 0 0 0;
		height: 100px;
	}
	input#cart_product_count {
		background-color: #fff9e5;
	}
	
</style>

<script type="text/javascript">

	let cart_product_count;
	let b_flag = false;
	let b_flag_click_btnUpdate = false;
	
	$(document).ready(function(){

		$("div#body").hide();
		$("div#error").hide();
		
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
			
			$(this).parent().parent().find("div#error").show(); // 에러메시지 보여주기
			
			b_flag_click_btnUpdate = true; // "변경" 버튼 클릭해야 한다.

		}); // end of $("button.changeCount").click(function(){})

		
		// 수량이 변하면 발생하는 이벤트
		$("input#cart_product_count").bind("change", function(){
		
			cart_product_count = $(this).val();
			checkChangeCount();
			$(this).val(cart_product_count);
		
			$(this).parent().parent().find("div#error").show(); // 에러메시지 보여주기
			
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
		
		
	// *** 3. 장바구니 변경사항을 DB에 반영하기 - AJAX
		// 1) 수량변경 후 "변경" 버튼 클릭 - tbl_cart 테이블의 cart_product_count 를 update
		$("button#btnCartUpdate").click(function(e){
			$.ajax({
				url:"<%= ctxPath%>/shop/cartListUpdate.moc",
	     		data:{"cart_no":$(this).parent().parent().parent().find("td:eq(0)").find("input:eq(1)").val(), // 장바구니번호
	     			  "cart_product_count":$(this).parent().prev().children("input").val()}, // 수량
	     		type:"post",
	     		dataType:"json",
	     		async:false,
	     		success:function(json) {
					if(json.result == 1){ // update sql 성공
						$(e.target).parent().hide(); // "변경" 버튼을 클릭하라는 에러메시지 숨기기
						location.href="javascript:history.go(0);"; // 새로고침
					}
	     		},
	     		error: function(request, status, error) {
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	     	});
		}); // end of $("button#btnCartUpdate").click(function(){})
		

		// 2) "삭제" 버튼 클릭 - tbl_cart 테이블에서 delete
		$("button#btnDelete").click(function(){
			
			const product_name = $(this).parent().find("div#product_name").text();
			
			if(confirm(product_name+" 을 장바구니에서 삭제하시겠습니까?")){
				$.ajax({
					url:"<%= ctxPath%>/shop/cartListDelete.moc",
		     		data:{"cart_no":$(this).parent().parent().find("td:eq(0)").find("input#cart_no").val()}, // 장바구니번호
		     		type:"post",
		     		dataType:"json",
		     		async:false,
		     		success:function(json) {
						if(json.result == 1){ // delete sql 성공
							location.href="javascript:history.go(0);"; // 새로고침
						}
		     		},
		     		error: function(request, status, error) {
		                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
		     	});
			}
		}); // end of $("button#btnDelete").click(function(){})

		
		// 3) "추가하기" 버튼 클릭 - tbl_cart 테이블에 insert
		$("button#btnAdd").click(function(){
			
			// 사이즈 선택했는지 확인하기
			if($("select#add_product_no").val() == "사이즈"){ // 사이즈 미선택
				alert("사이즈를 선택해주세요");
			}
			else {
				if(confirm("${requestScope.rndpvo.product_name}"+" 을 장바구니에 추가하시겠습니까?")){
					$.ajax({
						url:"<%= ctxPath%>/shop/cartListAdd.moc",
			     		data:{"product_no":$("select#add_product_no").val()}, // 제품번호
			     		type:"post",
			     		dataType:"json",
			     		async:false,
			     		success:function(json) {
							if(json.result == 1){ // insert sql 성공
								location.href="javascript:history.go(0);"; // 새로고침
							}
			     		},
			     		error: function(request, status, error) {
			                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			            }
			     	});
				} // 장바구니에 추가
			}
		}); // end of $("button#btnAdd").click(function(){})
		
				
		// 4) 옵션변경의 팝업창에서 "변경" 버튼 클릭 - tbl_cart 테이블의 fk_product_no 를 update
		$("button#btnOptionEdit").click(function(){
			
			const cart_no = $(this).parent().parent().find("td:eq(0)").find("input#cart_no").val();
			
			// 옵션변경하는 팝업창 띄우기
			const url = "<%= request.getContextPath()%>/shop/cartListOptionEdit.moc?cart_no="+cart_no;
			window.open(url, "옵션변경", "left=350px, top=100px, width=600px, height=500px");
			
		}); // end of $("button#btnOptionChange").click(function(){})

		
	// *** 4. 주문총액 계산하기
		let total_price = 0;
		$("td#cart_product_price").each(function(index, elmt){
			var cart_product_price = Number($(elmt).find("span").text().split(",").join(""));
			total_price += cart_product_price;
		}); // end of $("td#cart_product_price").each(function(index, elmt){})
		$("div#total_price").text(total_price.toLocaleString('en')+"원");
		
	// *** 5. 주문총액에 따른 배송비 계산하기
		if(total_price >= 50000){ // 주문총액 5만원 이상이면 배송비 무료
			$("div#delivery_fee").text("무료배송");
		}
		else {
			$("div#delivery_fee").text("3,000원");
		}
		
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

<div class="container py-4 mx-auto my-3" style="background-color: #fff9e5; border-radius: 1%;">
		
		<h2 class="text-center pb-3">장바구니</h2>
		
		<c:if test="${not empty requestScope.cartList}">
		<div class="row pb-3 mx-1">
			<div class="col-md-10 align-self-end">
				<label for="CheckAll_product"><input type="checkbox" name="CheckAll_product" id="CheckAll_product" /> 전체 상품 선택/해제</label>
			</div>
			<div class="col-md-2">
				<button type="button" id="btnOrder" class="btn btn-lg px-4">주문하기</button>
			</div>
		</div>
		
		<form name="CartListFrm">
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
			  <c:forEach var="cvo" items="${requestScope.cartList}">
			    <tr class="pt-2">
			    	<td>
			    		<input type="checkbox" name="CheckOne_product" id="CheckOne_product" />
			    		<input id="cart_no" name="cart_no" style="display: none;" value="${cvo.cart_no}" />
			    	</td>
			      	<td><img src="${cvo.pvo.product_image}" id="product_image" name="product_image" width="150"/></td>
			      	<td class="text-left">
			      		<div id="product_name" name="product_name">${cvo.pvo.product_name}</div>
			      		<div id="product_color" name="product_color">${cvo.pvo.product_color}<span>&nbsp;</span><span id="product_size" name="product_size">${cvo.pvo.product_size}</span></div>
			      		<button type="button" id="btnOptionEdit" class="btn btn-sm my-2">옵션변경</button>
			      		<button type="button" id="btnDelete" class="btn btn-sm my-2" style="color: gray;">삭제</button>
			      	</td>
			      	<td id="product_price" name="product_price"><fmt:formatNumber value="${cvo.pvo.product_price}" pattern="###,###" />원</td>
			      	<td>
				      	<span class="border py-1" style="border: solid 1px gray;">
				      	  	<button type="button" class="btn btn-sm changeCount">-</button>
					      	<input type="number" value="${cvo.cart_product_count}" id="cart_product_count" name="cart_product_count" class="col-md-4 text-center px-0" style="border: none;"/>
					      	<button type="button" class="btn btn-sm changeCount">+</button>
					    </span>
					    <div id="error" style="font-size: 10pt; margin: 5px auto;">
					    	<button type="button" id="btnCartUpdate" class="btn btn-sm px-0" style="font-weight: bold; text-decoration: underline; margin-bottom: 3px;">변경</button> 을 눌러주세요
					    </div>
				    </td>
			      	<td id="cart_product_price" name="cart_product_price" style="font-size: 14pt; font-weight: bold;">
			      		<span><fmt:formatNumber value="${cvo.pvo.totalPrice}" pattern="###,###" /></span>원
			      	</td>
			    </tr>
			  </c:forEach>
			  </tbody>
			</table>
		</div>
		
		<div id="div_extra" class="row my-5 py-3 mx-1">
			<div class="col-md-3 text-right align-self-center">함께 구매하면 좋은 상품</div>
			<div class="col-md-2 text-center"><img src="${requestScope.rndpvo.product_image}" id="add_product_image" name="add_product_image" width="120" class="img-thumbnail"/></div>
			<div class="col-md-4 align-self-center">
				<div class="my-1">
					<span id="add_product_name" name="add_product_name" style="font-weight: bold;">${requestScope.rndpvo.product_name}</span>&nbsp;&nbsp;
					<span id="add_product_price" name="add_product_price"><fmt:formatNumber value="${requestScope.rndpvo.product_price}" pattern="###,###" />원</span>
	      		</div>
	      		<div class="my-1">
	      			<span class="text-center">${requestScope.rndpvo.product_color}</span><span id="add_product_color" name="add_product_color" class="rounded-circle" style="background-color: ${requestScope.rndpvo.product_color};"></span>&nbsp;&nbsp;
		      		<select id="add_product_no" name="add_product_no" class="my-1">
		      			<option>사이즈</option>
		      			<c:forEach var="pvo" items="${requestScope.sizeList}" >
		      				<option value="${pvo.product_no}">${pvo.product_size}</option>
		      			</c:forEach>
		      		</select>
				</div>
	      	</div>
			<div class="col-md-3 align-self-center text-center">
				<button type="button" id="btnAdd" class="btn btn-lg px-5 py-3">추가하기</button>
			</div>
		</div>

		<div id="div_price" class="my-5 mx-1">
			<div class="row m-3">
				<div class="col-md-9"></div>
				<div class="col" style="font-size: 14pt; font-weight: bold;">주문금액</div>
				<div class="col text-right" id="total_price" name="total_price" style="font-size: 14pt; font-weight: bold;"></div>
			</div>
			<div class="row m-3">
				<div class="col-md-9"></div>
				<div class="col" style="font-size: 14pt; font-weight: bold;">배송비</div>
				<div class="col text-right" id="delivery_fee" name="delivery_fee" style="font-size: 14pt; font-weight: bold;"></div>
			</div>
		</div>
		</form>
		
		<div class="row my-5 px-1">
			<div class="col-md-8"></div>
			<div class="col align-self-center text-right"><button type="button" id="btnContinue" class="btn btn-sm">쇼핑 계속하기</button></div>
			<div class="col align-self-center text-left"><button type="button" id="btnOrder" class="btn btn-lg px-4">주문하기</button></div>
		</div>
</c:if>
		
<c:if test="${empty requestScope.cartList}">
	<div class="row pb-3 mx-1">
		<div class="col-md-10 align-self-end"></div>
		<div class="col-md-2">
			<a class="btn btn-lg px-4" style="background-color: #fdd007;" href="#">쇼핑하기</a>
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
		 	<tr>
		 		<td colspan="6">
		 			<div id="div_cart_empty">
		 				<p>장바구니에 담은 상품이 없습니다.</p>
		 			</div>
		 		</td>
		 	</tr>
		  </tbody>
		</table>
	</div>
		<div id="div_extra" class="row mb-5 py-3 mx-1">
			<div class="col-md-3 text-right align-self-center">고객님께 추천하는 상품</div>
			<div class="col-md-2 text-center"><img src="${requestScope.rndpvo.product_image}" id="add_product_image" name="add_product_image" width="120" class="img-thumbnail"/></div>
			<div class="col-md-4 align-self-center">
				<div class="my-1">
					<span id="add_product_name" name="add_product_name" style="font-weight: bold;">${requestScope.rndpvo.product_name}</span>&nbsp;&nbsp;
					<span id="add_product_price" name="add_product_price"><fmt:formatNumber value="${requestScope.rndpvo.product_price}" pattern="###,###" />원</span>
	      		</div>
	      		<div class="my-1">
	      			<span class="text-center">${requestScope.rndpvo.product_color}</span><span id="add_product_color" name="add_product_color" class="rounded-circle" style="background-color: ${requestScope.rndpvo.product_color};"></span>&nbsp;&nbsp;
		      		<select id="add_product_no" name="add_product_no" class="my-1">
		      			<option>사이즈</option>
		      			<c:forEach var="pvo" items="${requestScope.sizeList}" >
		      				<option value="${pvo.product_no}">${pvo.product_size}</option>
		      			</c:forEach>
		      		</select>
				</div>
	      	</div>
			<div class="col-md-3 align-self-center text-center">
				<button type="button" id="btnAdd" class="btn btn-lg px-5 py-3">추가하기</button>
			</div>
		  </div>
		  <div style="height: 100px;"></div>
	
</c:if>
</div>
<div style="height: 100px;"></div>
		
<jsp:include page="../jaesik/footer.jsp" />
	