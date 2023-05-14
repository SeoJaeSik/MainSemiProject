<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../jaesik/header.jsp" />
<jsp:include page="navbar_order_pay.jsp" />

<style>
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
</style>

<style type="text/css">
 	div#div_container{
		font-family: 'Noto Sans KR', serif;	
		font-weight: 300;
	}
	table > thead > tr > th {
		font-family: 'Noto Sans KR', serif;
		font-weight: 500;
	}
	button#btnCoupon, button#btnPointAll, button#btnPay, span#order_count {
		font-family: 'Noto Sans KR', serif;	
		background-color: #fdd007;
		border: none;
		box-shadow: 1px 1px 1px 1px #e6e6e6;
	}
	option, select, input{
		font-size: 10pt;
	}

</style>

<script type="text/javascript">
	
	$(document).ready(function(){

		$("div#div_container").hide();
		$("div#div_container").fadeIn(2000);
		$("div#navbar_page_delivery").find("span").css('background-color', '#fdd007');
		$("div#navbar_page_payment").find("span").css('background-color', '#fdd007');
		$("a#btnCart").find("i").css('color', '#fdd007');
		$("a#btnOrder").find("i").css('color', '#fdd007');
		$("a#btnPay").find("i").css('color', '#fdd007');
		$("div#lodaer").hide();
		
		calc_totalPrice(); // 결제금액 계산하는 함수 호출
		
		const sum_order_price = Number("${requestScope.total_price}"); // 총 주문금액
		const delivery_fee = Number("${requestScope.delivery_fee}"); // 배송비
		const user_point = Number("${sessionScope.loginuser.point}"); // 로그인한 회원의 보유포인트
		let coupon_dis_price = 0;
		
		// 상단바의 "배송정보" 를 클릭하면 발생하는 이벤트
		$("a#btnOrder").click(function(){
			location.href = "<%= request.getContextPath()%>/shop/delivery.moc";
		}); // end of $("button#btnOrder").click(function(){})


	// *** 쿠폰 "적용" 버튼을 클릭하면 발생하는 이벤트
		$("button#btnCoupon").click(function(){
			if($("select#coupon").val() != 0){
				const coupon_dis_price = sum_order_price*(Number($("select#coupon").val())/100); // 쿠폰할인금액
				$("span#coupon_dis_price").text(coupon_dis_price.toLocaleString('en')+"원");
			}
			else{
				$("span#coupon_dis_price").text('적용된 쿠폰없음');
			}
			calc_totalPrice();
		}); // end of $("button#btnCoupon").click(function(){})
	

	// *** 포인트 input 태그에 값을 입력하면 발생하는 이벤트
		$("input#point_redeem").change(function(){
			const point_redeem = $(this).val();
			if(isNaN(point_redeem) || point_redeem <= 0){ 
				// 포인트에 숫자가 아닌 값 또는 음수를 입력한 경우
				$(this).val("0");
			}
			else if(Number(point_redeem) > user_point){ // 보유포인트보다 큰 값을 입력한 경우
				$(this).val(user_point);
				calc_totalPrice();
				alert("${sessionScope.loginuser.name}"+"님이 사용가능한 포인트는 최대 "+user_point+"원 입니다.");
			}
			calc_totalPrice();
		}); // end of $("input#point_redeem").change(function(){})

		
	// *** 포인트 "전액사용" 버튼을 클릭하면 발생하는 이벤트
		$("button#btnPointAll").click(function(){
			$("input#point_redeem").val(user_point);
			calc_totalPrice();
		}); // end of $("button#btnPointAll").click(function(){})
	
		
	// *** "결제하기" 클릭하면 발생하는 이벤트
		$("button#btnPay").click(function(){

			$("div#lodaer").show();
			
			const payment_name = $("input#product_no").eq(0).val();
			const total_price = $("input#total_price").val();
			const url = "<%= ctxPath%>/shop/paymentTry.moc?payment_name="+payment_name+"&total_price="+total_price;
			window.open(url, payment_name, "left=300px, top=100px, width=830px, height=600px");

		}); // end of $("button#btnPay").click(function(){})
		
	}); // end of $(document).ready(function(){})

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	// 결제금액 계산하는 함수
	function calc_totalPrice(){
		const sum_order_price = Number("${requestScope.total_price}"); // 총 주문금액
		const delivery_fee = Number("${requestScope.delivery_fee}"); // 배송비
		const user_point = Number("${sessionScope.loginuser.point}"); // 로그인한 회원의 보유포인트
		const coupon_dis_price = sum_order_price*(Number($("select#coupon").val())/100); // 쿠폰할인금액
		const point_redeem = Number($("input#point_redeem").val()); // 포인트사용금액
		
		// 결제금액 = 총 주문금액 + 배송비 - 쿠폰할인금액 - 포인트사용금액
		const total_price = sum_order_price + delivery_fee - coupon_dis_price - Number($("input#point_redeem").val());
		$("span#total_price").text(total_price.toLocaleString('en')+"원");
		$("input#total_price").val(total_price);

		// 할인받은금액 = 쿠폰할인금액 + 포인트사용금액
		const discount_price = Number(coupon_dis_price) + Number(point_redeem);
		$("span#discount_price").text(discount_price.toLocaleString('en')+"원");
		$("input#discount_price").val(discount_price);
		
		// 포인트 적립금액 = 결제금액 * 0.1
		const point_saveup = parseInt(total_price * 0.1);
		$("span#point_saveup").text(point_saveup.toLocaleString('en')+"원");
		$("input#point_saveup").val(point_saveup);
	} // end of function calc_totalPrice()

	
	// 결제성공했을때 호출되는 함수 ==> DB에 업데이트(트랜잭션)
	function goPaymentEnd(){
		$.ajax({
			url:"<%= ctxPath%>/shop/paymentEnd.moc",
     		data:{"delivery_fee":"${requestScope.delivery_fee}", 	// 배송비
     			  "coupon_no":$("select#coupon").find("option:selected").attr("id"), // 쿠폰번호
     			  "point_redeem":$("input#point_redeem").val(),  	// 포인트 사용금액
     			  "point_saveup":$("input#point_saveup").val(),  	// 포인트 적립금액
     			  "discount_price":$("input#discount_price").val(), // 할인받은금액
     			  "total_price":$("input#total_price").val()},   	// 결제금액
     		type:"post",
     		dataType:"json",
     		success:function(json) {
				if(json.order_no != null){ // 결제성공
					location.href = "<%= request.getContextPath()%>/shop/orderList.moc?userid="+'${sessionScope.loginuser.userid}'+"&order_no="+json.order_no;
					// alert("주문성공");
				}
				else{
					alert("주문 중 오류가 발생하였습니다.");
				}
     		},
     		error: function(request, status, error) {
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
     	});
	} // end of function goPaymentEnd() 
	
	
</script>

<div id="div_container" class="container py-4 mx-auto my-3" style="background-color: #fefce7; border-radius: 1%;">
		
		<h2 class="text-center py-4">PAYMENT INFO</h2>

		<div class="table-responsive mx-auto col-md-10 border-bottom">
			<table class="table text-center" id="tbl_orderList">
			  <thead>
			    <tr>
			    	<th colspan="2" class="col-md-8">선택한 상품/옵션</th>
			      	<th class="col-md-4">주문금액</th>
			    </tr>
			  </thead>
			  <tbody>
			  <%-- 장바구니에서 결제 --%>
			  <c:if test="${not empty requestScope.orderList}">
			    <c:forEach var="cvo" items="${requestScope.orderList}">
			      <tr class="pt-2">
			      	<td>
				  	  <div class="position-relative">
						<input type="hidden" name="cart_no" value="${cvo.cart_no}" />
						<input type="hidden" id="product_no" name="product_no" value="${cvo.pvo.product_no}" />
						<img id="product_image" name="product_image" src="${cvo.pvo.product_image}" width="150" class="img-thumbnail" />					  
						  
						<%-- 잔고수량 >= 주문수량 --%>
						<c:if test="${cvo.cart_product_count > 0}"> 
						  <span id="order_count" class="position-absolute translate-middle p-2 ml-n3 mt-n2 badge border border-light rounded-circle" style="width:30px; height:30px;">
						    <span class="visually-hidden">${cvo.cart_product_count}</span>
						  </span>
						</c:if>

					  </div>
				    </td>
			        <td class="text-left">
			      	  <div id="product_name" name="product_name" style="font-weight: bold;">${cvo.pvo.product_name}</div>
			      	  <div id="product_color" name="product_color">${cvo.pvo.product_color}<span>&nbsp;</span><span id="product_size" name="product_size">${cvo.pvo.product_size}</span></div>
			      	  <div id="product_price" name="product_price"><fmt:formatNumber value="${cvo.pvo.product_price}" pattern="###,###" />원</div>

					  <%-- 잔고수량 < 주문수량 --%>
					  <c:if test="${cvo.cart_product_count == 0}"> 
			      	  	<div id="order_count" name="order_count" style="color:red;">품절(현재 주문불가)</div>
					  </c:if>
			        </td>
			        <td id="order_price" name="order_price" style="font-size: 14pt; font-weight: bold;"><fmt:formatNumber value="${cvo.pvo.order_price}" pattern="###,###" />원</td>
			      </tr>
			    </c:forEach>
			  </c:if>
			  
			  <%-- 제품상세에서 바로결제 --%>
			  <c:if test="${empty requestScope.orderList}">
			      <tr class="pt-2">
			      	<td>
				  	  <div class="position-relative">
						<input type="hidden" id="product_no" name="product_no" value="${cvo.pvo.product_no}" />
						<img id="product_image" name="product_image" src="${cvo.product_image}" width="150" class="img-thumbnail" />					  

						<%-- 잔고수량 >= 주문수량 --%>
						<c:if test="${cvo.cart_product_count > 0}"> 
						  <span id="order_count" class="position-absolute translate-middle p-2 ml-n3 mt-n2 badge border border-light rounded-circle" style="width:30px; height:30px;">
						    <span class="visually-hidden">${cvo.cart_product_count}</span>
						  </span>
						</c:if>
						
					  </div>
				    </td>
			        <td class="text-left">
			      	  <div id="product_name" name="product_name">${cvo.pvo.product_name}</div>
			      	  <div id="product_color" name="product_color">${cvo.pvo.product_color}<span>&nbsp;</span><span id="product_size" name="product_size">${cvo.pvo.product_size}</span></div>
			      	  <div id="product_price" name="product_price"><fmt:formatNumber value="${cvo.pvo.product_price}" pattern="###,###" />원</div>

					  <%-- 잔고수량 < 주문수량 --%>
					  <c:if test="${cvo.cart_product_count = 0}"> 
			      	  	<div id="order_count" name="order_count" style="color:red;">품절(현재 주문불가)</div>
					  </c:if>
					  
			        </td>
			        <td id="order_price" name="order_price" style="font-size: 14pt; font-weight: bold;"><fmt:formatNumber value="${cvo.pvo.order_price}" pattern="###,###" />원</td>
			      </tr>
			  </c:if>			    
			  </tbody>
			</table>
		</div>

		<div id="div_price" class="table-responsive mx-auto col-md-10 my-4">
			<table class="table table-borderless text-right mx-auto my-auto">
			  <tbody>
			    <tr>
			    	<td rowspan="7" class="col-md-7 text-center">
			    		<div id="lodaer" class="h4 mx-auto" style="padding-top: 150px;">
			    		  <i class="fa-solid fa-sack-dollar fa-fade fa-2xl" style="color: #333333; text-shadow: 1px 1px 1px #e6e6e6;"> 결제진행중</i>	
						</div>
			    	</td>
			      	<td class="col-md-3 p-1">총 주문금액</td>
			      	<td class="col-md-2 p-1">
      				  <span id="sum_order_price" name="sum_order_price" class="h6"><fmt:formatNumber value="${requestScope.total_price}" pattern="###,###" />원</span>
			      	</td>
			    </tr>
			    <tr>
			      	<td class="col-md-3 p-1 pb-4">배송비</td>
			      	<td class="col-md-2 p-1 pb-4">
      				  <span id="delivery_fee" name="delivery_fee" class="h6"><fmt:formatNumber value="${requestScope.delivery_fee}" pattern="###,###" />원</span>
    		      	</td>
			    </tr>
			    <tr>
			      	<td colspan="2" class="col-md-5 pt-4 h6 border-top">${sessionScope.loginuser.name}(${sessionScope.loginuser.userid}) 님의 쿠폰 및 포인트</td>
			    </tr>
			    <tr>
			      	<td colspan="2" class="col-md-5 p-1">
			      		<select id="coupon" style="padding-bottom: 5px; width: 210px; height: 30px;">
			      			  <option value="0">보유쿠폰 조회하기</option>
			      		  
			      		  <c:forEach var="couponMap" items="${requestScope.couponList}">
			      		    <c:if test="${not empty couponMap}">
			      			  <option id="${couponMap.coupon_no}" value="${couponMap.coupon_dis_percent}">${couponMap.coupon_name}</option>
			      		    </c:if>
			      		    <c:if test="${empty couponMap}">
			      			  <option value="0">보유한 쿠폰이 없습니다.</option>
			      		    </c:if>
			      		  </c:forEach>

			      			  <option value="0" style="color: blue;">쿠폰 사용하지 않기</option>
			      		</select>
						<button type="button" id="btnCoupon" class="btn btn-sm px-2">적용</button>
			      	</td>
			    </tr>
			    <tr>
			      	<td class="col-md-3 p-1 pb-2">쿠폰 할인금액</td>
			      	<td class="col-md-2 p-1 pb-2">
      				  <span id="coupon_dis_price" name="coupon_dis_price" style="font-size: 11pt; font-weight:bold;">적용된 쿠폰없음</span>
			      	</td>
			    </tr>
			    <tr>
			      	<td class="col-md-3 p-1 pt-2">보유한 포인트</td>
			      	<td class="col-md-2 p-1 pt-2">
      				    <span id="user_point" name="user_point" class="h6"><fmt:formatNumber value="${sessionScope.loginuser.point}" pattern="###,###" />원</span>
			      	</td>
			    </tr>
			    <tr>
			      	<td class="col-md-3 p-1 pb-4">포인트 사용금액</td>
			      	<td class="col-md-2 p-1 pb-4">
		      		  <input type="text" id="point_redeem" name="point_redeem" value="0" style="width: 60px; height: 28px; text-align:right;" placeholder="0"/>원
					  <button type="button" id="btnPointAll" class="btn btn-sm px-2">전액</button>
			      	</td>
			    </tr>
			    <tr>
			    	<td class="col-md-7 pt-4"></td>
			      	<td class="col-md-3 p-1 pt-4 border-top">할인받은 금액</td>
			      	<td class="col-md-2 p-1 pt-4 border-top">
      				  <span id="discount_price" name="discount_price" class="h6">원</span>
      				  <input type="hidden" id="discount_price" value="" />
			      	</td>
			    </tr>
			    <tr>
			    	<td class="col-md-7"></td>
			      	<td class="col-md-3 p-1">결제금액</td>
			      	<td class="col-md-2 p-1">
      				  <span id="total_price" name="total_price" class="h6">원</span>
      				  <input type="hidden" id="total_price" value="" />
			      	</td>
			    </tr>
			    <tr>
			    	<td class="col-md-7"></td>
			      	<td class="col-md-3 p-1">포인트 적립금액</td>
			      	<td class="col-md-2 p-1">
      				  <span id="point_saveup" name="point_saveup" class="h6">원</span>
      				  <input type="hidden" id="point_saveup" value="" />
			      	</td>
			    </tr>
			    <tr>
			    	<td class="col-md-7 py-4"></td>
			      	<td colspan="2" class="col-md-5 py-4">
					  <button type="button" id="btnPay" class="btn btn-lg px-4">결제하기</button>
			      	</td>
			    </tr>
			  </tbody>
			</table>
		</div>
		
	</div>
<div style="height: 100px;"></div>

<jsp:include page="../jaesik/footer.jsp" />
	