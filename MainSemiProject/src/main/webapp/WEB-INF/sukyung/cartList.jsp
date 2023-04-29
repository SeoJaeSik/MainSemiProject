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
	label#add_product_color {
		width: 100px;
		text-align: left;
	}
	input.btn{opacity: 0;}
	label#add_product_color:hover{
		cursor: pointer;
	}
	.selected {
		font-weight: bold;
		font-size: 11pt;
		text-decoration: underline;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){

		$("div#div_container").hide();
		$("div#div_container").fadeIn(1500);
		
		let cart_product_count;
		let b_flag_goDelivery = true; // goOrder() 함수에서 b_flag_goDelivery 가 true 이면 "배송정보"로 이동가능
		let b_flag_click_btnUpdate = false;

		$("div#error").hide();
		$("img#add_product_image").hide();
		
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
				b_flag_goDelivery = true;
			}
			else { // 체크해제
				$("input#CheckOne_product").prop("checked", false);
				b_flag_goDelivery = false;
			}
		}); // end of $("input#CheckAll_product").click((e)=>{})

		// 제품한개 체크박스를 클릭하면
		$("input#CheckOne_product").click((e)=>{
			
			if(!$(e.target).prop("checked")){ // 제품한개 체크해제
				$("input#CheckAll_product").prop("checked", false);
				if($("input:checkbox[name='cart_no']:checked").length == 0){
					// 장바구니에 있는 제품이 한개인데, 그것을 체크해제한 경우
					b_flag_goDelivery = false; // 주문 안되도록 막아줌
				}
			}
			else { // 제품한개 체크
				b_flag_goDelivery = true;
				if($("input:checkbox[name='cart_no']:checked").length == $("input#CheckOne_product").length){
					// 장바구니에 있는 제품 전부 체크된 경우
					$("input#CheckAll_product").prop("checked", true); // "전체상품선택" 체크
				}
			}
		}); // end of $("input#CheckOne_product").click((e)=>{})

	
	// *** 3. 장바구니 변경사항을 DB에 반영하기 - AJAX
		// 1) 수량변경 후 "변경" 버튼 클릭 - tbl_cart 테이블의 cart_product_count 를 update
		$("button#btnCartUpdate").click(function(e){
			$.ajax({
				url:"<%= ctxPath%>/shop/cartListUpdate.moc",
	     		data:{"cart_no":$(this).parent().parent().parent().find("td:eq(0)").find("input:checkbox[name='cart_no']").val(), // 장바구니번호
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
			
			console.log($(this).parent().parent().find("td:eq(0)").find("input#cart_no").val());
			
			if(confirm(product_name+" 을 장바구니에서 삭제하시겠습니까?")){
				$.ajax({
					url:"<%= ctxPath%>/shop/cartListDelete.moc",					
		     		data:{"cart_no":$(this).parent().parent().find("td:eq(0)").find("input:checkbox[name='cart_no']").val()}, // 장바구니번호
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

		
	// *** 4. 제품추천 - 로그인한 회원의 성별과 일치하는 고객유형코드의 상품을 추천함
		let selectedColor = "${rndpvo.product_color}";
		
		// 1) 회원의 원래옵션(색상) checked 로 표시하기
		$("input:radio[name='add_product_color']").each(function(index, elmt){
			if($(elmt).val() == "${rndpvo.product_color}"){
				$(elmt).prop("checked", true);
				$("label#add_product_color").removeClass('selected');
				$(elmt).parent().addClass('selected');
			}
		}); // end of $("input:radio[name='add_product_color']").each(function(index, elmt){})

		
		// 2) 회원의 원래옵션(이미지) 보여주기
		$("img#add_product_image").each(function(index, elmt){
			if($(elmt).attr('src') == "${rndpvo.product_image}"){
				$(elmt).show();
			}
		}); // end of $("img#add_product_image").each(function(index, elmt){})
		
		
		// 3) 선택한 색상의 css 변경
		$("input:radio[name='add_product_color']").click(function(){
			if($(this).prop("checked")){
				$("label#add_product_color").removeClass('selected', {duration:1000});
				$(this).parent().addClass('selected', {duration:1000});
				selectedColor = $(this).val();

				// 선택한 색상에 따른 이미지 보여주기
				$("img#add_product_image").each(function(index, elmt){
					if($(elmt).parent().attr('id') == selectedColor){
						$("img#add_product_image").hide();
						$(elmt).show();
					}
				}); // end of $("img#add_product_image").each(function(index, elmt){})
			}
		}); // end of $("input:radio[name='add_product_color']").click(function(){})

		// 4) "추가하기" 버튼 클릭 - tbl_cart 테이블에 insert
		$("button#btnAdd").click(function(){
			
			// 사이즈 선택했는지 확인하기
			if($("select#add_product_size").val() == "사이즈"){ // 사이즈 미선택
				alert("사이즈를 선택해주세요");
			}
			else {
				if(confirm("${requestScope.rndpvo.product_name}"+" 을 장바구니에 추가하시겠습니까?")){
					$.ajax({
						url:"<%= ctxPath%>/shop/cartListAdd.moc",
			     		data:{"product_name":$("span#add_product_name").text(),   // 제품명
			     			  "product_color":$("input[name='add_product_color']:checked").val(), // 제품색상
			     			  "product_size":$("select#add_product_size").val()}, // 제품사이즈
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
			
			const cart_no = $(this).parent().parent().find("td:eq(0)").find("input:checkbox[name='cart_no']").val();
			
			// 옵션변경하는 팝업창 띄우기
			const url = "<%= request.getContextPath()%>/shop/cartListOptionEdit.moc?cart_no="+cart_no;
			window.open(url, "옵션변경", "left=350px, top=100px, width=600px, height=500px");
			
		}); // end of $("button#btnOptionChange").click(function(){})

		
	// *** 4. 주문총액 계산하기
		let total_price = 0;
		$("td#order_price").each(function(index, elmt){
			var order_price = Number($(elmt).find("span").text().split(",").join(""));
			total_price += order_price;
		}); // end of $("td#order_price").each(function(index, elmt){})
		$("input#total_price").val(total_price);
		$("span#total_price").text(total_price.toLocaleString('en')+"원");
		
	// *** 5. 주문총액에 따른 배송비 계산하기
		if(total_price >= 50000){ // 주문총액 5만원 이상이면 배송비 무료
			$("input#delivery_fee").val(0);
			$("span#delivery_fee").text("무료배송");
		}
		else {
			$("input#delivery_fee").val(3000);
			$("span#delivery_fee").text("3,000원");
		}
		
	// *** 6. "주문하기" 버튼 클릭하면 발생하는 이벤트
		$("button#btnOrder").click(function(){ // "주문하기" 노란 버튼 클릭
			if(!b_flag_goDelivery){ // 체크된 제품이 하나도 없을경우
				alert("선택한 상품이 없습니다.");
			}
			else { // 한개이상의 제품이 체크된 경우
				goOrder();
			}
		}); // end of $("button#btnOrder").click(function(){})
	
		$("a#btnOrder").click(function(){ // 상단바의 "배송정보" 노란 동그라미 링크 클릭
			if(!b_flag_goDelivery){ // 체크된 제품이 하나도 없을경우
				alert("선택한 상품이 없습니다.");
			}
			else { // 한개이상의 제품이 체크된 경우
				goOrder();
			}
		}); // end of $("a#btnOrder").click(function(){})
		
	
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
	
<%--
	if(!b_flag_goDelivery){ // 체크된 제품이 하나도 없을경우
		alert("선택한 상품이 없습니다.");
	}
	else { // 한개이상의 제품이 체크된 경우
		const frm = document.CartListFrm;
		frm.action = "<%= request.getContextPath()%>/shop/delivery.moc";
		frm.method = "post";
		frm.submit();
	}
	
	함수에서는 유효성검사 후 실행이 불가능하다!!!
	따라서 스크립트 내에 이벤트처리를 하여 유효성검사한 다음 바로 form 태그를 제출하는 방법
	또는 form 태그를 제출하는 함수를 따로 생성하여 유효성검사 후 함수를 호출하도록 해야한다!!!
--%>
	// "주문하기" 를 클릭하면 호출되는 함수
	function goOrder(){

		// 주문하고자 하는 제품정보 및 장바구니번호를 배열에 담아서 "배송정보" 로 전달하기
		const arr_product_no = [];
		const arr_cart_product_count = [];
		const arr_order_price = [];
		const arr_cart_no = [];
	
		$("input:checkbox[name='cart_no']:checked").each(function(index, elmt){ // 체크된 제품번호
			arr_product_no.push( $(elmt).parent().parent().find("td:eq(2)").find("input#product_no").val() );
			arr_cart_product_count.push( $(elmt).parent().parent().find("td:eq(4)").children().find("input#cart_product_count").val() );
			arr_order_price.push( $(elmt).parent().parent().find("td:eq(5)").find("input#order_price").val() );
			arr_cart_no.push( $(elmt).val() );
		});

     	const frm = document.CartListFrm;
		frm.action = "<%= request.getContextPath()%>/shop/delivery.moc";

		frm.product_no.value = arr_product_no; 				  // 제품번호(배열)
		frm.cart_product_count.value = arr_cart_product_count; // 주문수량(배열)
		frm.order_price.value = arr_order_price; 			  // 제품별 주문금액(배열)
		frm.cart_no.value = arr_cart_no; 					  // 장바구니번호(배열)
		
		frm.method = "post";
		frm.submit();

		} // end of function goOrder()
	
</script>

<div id="div_container" class="container py-4 mx-auto my-3" style="background-color: #fefce7; border-radius: 1%;">
		
		<h2 class="text-center py-3">장바구니</h2>
		
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
			      	<th class="col-md-2">주문금액</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach var="cvo" items="${requestScope.cartList}">
			    <tr class="pt-2">
			    	<td>
			    		<input type="checkbox" name="cart_no" id="CheckOne_product" value="${cvo.cart_no}"/>
			    	</td>
			      	<td><img src="${cvo.pvo.product_image}" id="product_image" name="product_image" width="150" class="img-thumbnail"/></td>
			      	<td class="text-left">
			    		<input type="hidden" id="product_no" name="product_no" value="${cvo.pvo.product_no}" />
			      		<div id="product_name" name="product_name">${cvo.pvo.product_name}</div>
			      		<div id="product_color" name="product_color">${cvo.pvo.product_color}<span>&nbsp;</span><span id="product_size" name="product_size">${cvo.pvo.product_size}</span></div>
			      		<button type="button" id="btnOptionEdit" class="btn btn-sm my-2">옵션변경</button>
			      		<button type="button" id="btnDelete" class="btn btn-sm my-2" style="color: gray;">삭제</button>
			      	</td>
			      	<td id="product_price" name="product_price"><fmt:formatNumber value="${cvo.pvo.product_price}" pattern="###,###" />원</td>
			      	<td>
				      	<span class="border py-1" style="border: solid 1px gray;">
				      	  	<button type="button" class="btn btn-sm changeCount">-</button>
					      	<input type="number" id="cart_product_count" name="cart_product_count" value="${cvo.cart_product_count}" class="col-md-4 text-center px-0" style="border: none; background-color: #fefce7;"/>
					      	<button type="button" class="btn btn-sm changeCount">+</button>
					    </span>
					    <div id="error" style="font-size: 10pt; margin: 5px auto;">
					    	<button type="button" id="btnCartUpdate" class="btn btn-sm px-0" style="font-weight: bold; text-decoration: underline; margin-bottom: 3px;">변경</button> 을 눌러주세요
					    </div>
				    </td>
			      	<td id="order_price" name="order_price" style="font-size: 14pt; font-weight: bold;">
			      		<span><fmt:formatNumber value="${cvo.pvo.order_price}" pattern="###,###" /></span>원
			    		<input type="hidden" id="order_price" name="order_price" value="${cvo.pvo.order_price}" />
			      	</td>
			    </tr>
			  </c:forEach>
			  </tbody>
			</table>
		</div>
		
		<div id="div_extra" class="row my-5 py-3 mx-1">
			<div class="col-md-3 text-right align-self-center">함께 구매하면 좋은 상품</div>
			<div class="col-md-2 text-center">
				<c:forEach var="colorpvo" items="${requestScope.colorList}">
   				  <span id="${colorpvo.product_color}">
   					<img src="${colorpvo.product_image}" id="add_product_image" name="add_product_image" width="120" class="img-thumbnail"/>
   				  </span>
	      		</c:forEach>
			
			</div>
			<div class="col-md-3 align-self-center">
				<div class="my-1 ml-2">
					<span id="add_product_name" name="add_product_name" style="font-weight: bold;">${requestScope.rndpvo.product_name}</span>&nbsp;&nbsp;
					<span id="add_product_price" name="add_product_price"><fmt:formatNumber value="${requestScope.rndpvo.product_price}" pattern="###,###" />원</span>
	      		</div>
	      		<div class="my-1">
	      			<c:forEach var="colorpvo" items="${requestScope.colorList}" varStatus="status">
		      			<label for="add_product_color${status.index}" id="add_product_color">
		      				<span id="add_product_color" name="add_product_color" class="rounded-circle" style="background-color: ${colorpvo.product_color};"></span>
		      				${colorpvo.product_color}
		      				<input type="radio" class="btn" id="add_product_color${status.index}" name="add_product_color" value="${colorpvo.product_color}" />
		      			</label>
	      			</c:forEach>
	      		</div>
	      		<div class="my-1 ml-2">
		      		<select id="add_product_size" name="add_product_size" class="my-1 px-2">
		      			<option>사이즈</option>
		      			<c:forEach var="pvo" items="${requestScope.sizeList}" >
		      				<option>${pvo.product_size}</option>
		      			</c:forEach>
		      		</select>
				</div>
	      	</div>
			<div class="col-md-4 align-self-center text-center">
				<button type="button" id="btnAdd" class="btn btn-lg px-5 py-3">추가하기</button>
			</div>
		</div>

		<div id="div_price" class="table-responsive px-5 my-4">
			<table class="table table-borderless text-center mx-auto">
			  <tbody>
			    <tr>
			    	<td class="col-md-8"></td>
			      	<td class="col-md-2 p-1 text-right">총 주문금액</td>
			      	<td class="col-md-2 p-1">
      				  <span id="total_price" name="total_price" class="text-right h6"></span>
      				  <input type="hidden" id="total_price" name="total_price" value=""/>
			      	</td>
			    </tr>
			    <tr>
			    	<td class="col-md-8"></td>
			      	<td class="col-md-2 p-1 text-right">배송비</td>
			      	<td class="col-md-2 p-1">
      				  <span id="delivery_fee" name="delivery_fee" class="text-right h6"></span>
	  				  <input type="hidden" id="delivery_fee" name="delivery_fee" value=""/>
    		      	</td>
			    </tr>
			    <tr>
			    	<td class="col-md-8 pt-4"></td>
			      	<td colspan="2" class="col-md-4 pt-4">
					  <button type="button" id="btnContinue" class="btn btn-sm ml-3 text-right">쇼핑 계속하기</button>
					  <button type="button" id="btnOrder" class="btn btn-lg ml-3 px-4 text-right">주문하기</button>
			      	</td>
			    </tr>
			  </tbody>
			</table>
		</div>
		</form>
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
		      	<th class="col-md-2">주문금액</th>
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
			<div class="col-md-2 text-center">
				<c:forEach var="colorpvo" items="${requestScope.colorList}">
   				  <span id="${colorpvo.product_color}">
   					<img src="${colorpvo.product_image}" id="add_product_image" name="add_product_image" width="120" class="img-thumbnail"/>
   				  </span>
	      		</c:forEach>
			
			</div>
			<div class="col-md-3 align-self-center">
				<div class="my-1 ml-2">
					<span id="add_product_name" name="add_product_name" style="font-weight: bold;">${requestScope.rndpvo.product_name}</span>&nbsp;&nbsp;
					<span id="add_product_price" name="add_product_price"><fmt:formatNumber value="${requestScope.rndpvo.product_price}" pattern="###,###" />원</span>
	      		</div>
	      		<div class="my-1">
	      			<c:forEach var="colorpvo" items="${requestScope.colorList}" varStatus="status">
		      			<label for="add_product_color${status.index}" id="add_product_color">
		      				<span id="add_product_color" name="add_product_color" class="rounded-circle" style="background-color: ${colorpvo.product_color};"></span>
		      				${colorpvo.product_color}
		      				<input type="radio" class="btn" id="add_product_color${status.index}" name="add_product_color" value="${colorpvo.product_color}" />
		      			</label>
	      			</c:forEach>
	      		</div>
	      		<div class="my-1 ml-2">
		      		<select id="add_product_size" name="add_product_size" class="my-1 px-2">
		      			<option>사이즈</option>
		      			<c:forEach var="pvo" items="${requestScope.sizeList}" >
		      				<option>${pvo.product_size}</option>
		      			</c:forEach>
		      		</select>
				</div>
	      	</div>
			<div class="col-md-4 align-self-center text-center">
				<button type="button" id="btnAdd" class="btn btn-lg px-5 py-3">추가하기</button>
			</div>
		</div>
	<div style="height: 100px;"></div>
	
</c:if>
</div>
<div style="height: 100px;"></div>
		
<jsp:include page="../jaesik/footer.jsp" />
	