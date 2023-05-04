<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../jaesik/header.jsp" />

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
	#tbl_orderList > tbody > tr > td:nth-child(4) > div > label {
		width: 40%;
		text-align:right;
		margin-right: 5px;
		font-weight: 400;
	}
	#tbl_orderList > tbody > tr > td:nth-child(3) > div > label {
		width: 12%;
		text-align:right;
		margin-right: 5px;
		font-weight: 400;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){

		$("div#div_container").hide();
		$("div#div_container").fadeIn(1500);
		$("table#ViewOrderDetail").hide();
		
		// "주문상세내역" 클릭하면 보이기
		$("button#btnViewOrderDetail").click(function(){
			$("table#ViewOrderDetail").slideDown(1500);
			$("div#btnViewOrderDetail").slideUp(1000);
		}); // end of $("button#btnViewOrderDetail").click(function(){})
		
		// "주문상세내역 접기" 클릭하면 숨겨짐
		$("button#btnViewReset").click(function(){
			$("div#btnViewOrderDetail").slideDown(1500);
			$("table#ViewOrderDetail").fadeOut(1000);
		}); // end of $("button#btnViewReset").click(function(){})
		
		// "주문내역 받아보기" 하면 메일 발송
		$("button#sendEmail").click(function(){
			
			if($(this).find("span").text() == "${sessionScope.loginuser.email} 로 주문내역 받아보기"){
				
				$(this).prop("disabled", true);
				$(this).html("<div class='spinner-border'></div>&nbsp;&nbsp;<span>${sessionScope.loginuser.email} 로 주문내역 받아보기</span>");
				
				$.ajax({
					url:"<%= ctxPath%>/shop/orderList.moc",
		     		data:{"order_no":$("input#order_no").val(), 		// 주문번호
		     			  "userid":"${sessionScope.loginuser.userid}"}, // 회원아이디
		     		type:"post",
		     		dataType:"json",
		     		success:function(json) {
						if(json.result){ // 메일보내기 성공
							$("button#sendEmail").prop("disabled", false);
							$("button#sendEmail").html("<span>${sessionScope.loginuser.email} 로 주문내역이 발송되었습니다.</span>");
						}
		     		},
		     		error: function(request, status, error) {
		                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
		     	});
			} // end of if

		}); // end of $("button#sendEmail").click(function(){})
		
	}); // end of $(document).ready(function(){})

//////////////////////////////////////////////////////////////////////////////////////////
	
	
</script>

<div style="height: 50px;"></div>
<div id="div_container" class="container py-4 mx-auto my-3" style="background-color: #fefce7; border-radius: 1%;">
		
		<h2 class="text-center pt-4 pb-2">YOUR ORDER</h2>
		<div class="h5 text-center pt-4 pb-5">
			<button type="button" id="sendEmail" style="border:none; background-color: #fefce7;">
			  <i class="fa-regular fa-paper-plane fa-beat fa-xl" style="color: #fdd007; text-shadow: 1px 1px 1px #cccccc;">&nbsp;&nbsp;</i>
			  <span>${sessionScope.loginuser.email} 로 주문내역 받아보기</span>
			</button>
		</div>
		
		<div class="table-responsive mx-auto">
			<table class="table text-center" id="tbl_orderList">
			  <thead>
			    <tr>
			    	<th>주문번호</th>
			    	<th>주문날짜</th>
			      	<th>배송정보</th>
			      	<th>주문금액</th>
			    </tr>
			  </thead>
		      <tbody>
		 	  	<tr>
			 		<td class="px-0 mx-1" style="width: 110px;">
			 		  <div id="order_no" class="mt-4">${requestScope.orderMap.order_no}</div>
			 		  <input type="hidden" id="order_no" name="order_no" value="${requestScope.orderMap.order_no}"></input>
			 		</td>
			 		<td class="px-0 mx-1" style="width: 120px;"><div class="mt-4">${requestScope.orderMap.orderdate}</div></td>
			 		<td class="text-left px-0 mx-1" style="font-size: 10pt; width: 350px;">
			 			<div><label>성명 :</label>${requestScope.orderMap.delivery_name}</div>
			 			<div><label>연락처 :</label>${requestScope.orderMap.delivery_mobile}</div>
			 			<div><label>주소 :</label>${requestScope.orderMap.delivery_address}</div>
			 			<c:if test="${not empty requestScope.orderMap.delivery_comment}">
			 			  <div><label>요청사항 : </label>${requestScope.orderMap.delivery_comment}</div>
			 			</c:if>
			 		</td>
			 		<td class="text-left px-0 mx-1" style="width: 200px;">
			 			<div><label>제품정가 :&nbsp;</label><fmt:formatNumber value="${requestScope.orderMap.origin_product_price}" pattern="###,###" />원</div>
			 			<div><label>할인받은금액 :&nbsp;</label><fmt:formatNumber value="${requestScope.orderMap.discount_price}" pattern="###,###" />원</div>
			 			<div><label>실 결제금액 :&nbsp;</label><fmt:formatNumber value="${requestScope.orderMap.total_price}" pattern="###,###" />원</div>
			 		</td>
		 	  	</tr>
		 	  	<tr>
			 		<td colspan="6">
			 			<div id="btnViewOrderDetail">
						  <button type="button" id="btnViewOrderDetail" class="btn px-4 py-3 my-3 mx-2" style="background-color: #fdd007;">주문상세내역 확인하기</button>
						  <a href="<%= ctxPath%>/shop/allproduct.moc" class="btn btn-dark px-4 py-3 my-3 mx-2">계속 쇼핑하기</a>
			 			</div>
			 		</td>
		 		</tr>
		     </tbody>
		</table>
 	  	<table id="ViewOrderDetail"  class="table text-center col-md-10 mx-auto">
	        <%-- [주문상세내역] 보기 버튼 클릭하면 보여지는 것 --%>
	      <thead>
	 	  	<tr>
		 		<th colspan="2" class="col-md-6">주문상품/옵션</th>
		 		<th>주문수량</th>
		 		<th>제품정가</th>
	 	  	</tr>
	      </thead>
	      <tbody>
	 	  	<c:forEach var="odvo" items="${requestScope.orderDetailList}">
	 	  	  <tr>
		 		<td class="col-md-3 text-center">
		 		  <input type="hidden" id="order_detail_no" val="${odvo.order_detail_no}"/>
		 		  <img src="${odvo.pvo.product_image}" id="product_image" name="product_image" width="150" class="img-thumbnail"/>
		 		</td>
		 		<td class="col-md-3 text-left">
		 		  <div class="mt-4">
		    		<input type="hidden" id="product_no" name="product_no" value="${odvo.pvo.product_no}" />
		      		<div id="product_name" style="font-weight: bold;">${odvo.pvo.product_name}</div>
		      		<div id="product_color">${odvo.pvo.product_color}<span>&nbsp;</span><span id="product_size" name="product_size">${odvo.pvo.product_size}</span></div>
		 		  </div>
		 		</td>
		 		<td class="col-md-2" id="order_count"><div class="mt-4">${odvo.order_count} 개</div></td>
		 		<td class="col-md-2" id="order_price" style="font-size: 12pt; font-weight: bold;"><div class="mt-4"><fmt:formatNumber value="${odvo.order_price}" pattern="###,###" />원</div></td>
	 	  	  </tr>
	 	  	</c:forEach>
	 	  	  <tr>
		 		<td colspan="4">
		 			<div id="btnViewReset">
					  <button type="button" id="btnViewReset" class="btn btn-dark px-4 py-3 my-3 mx-2">주문상세내역 접기</button>
					  <a href="<%= ctxPath %>/member/myaccount.moc" class="btn px-4 py-3 my-3 mx-2" style="background-color: #fdd007;">이전 주문내역 확인하기</a>
		 			</div>
		 		</td>
	 		  </tr>
	      </tbody>
 	  	</table>
	</div>
		
</div>
<div style="height: 100px;"></div>
		
<jsp:include page="../jaesik/footer.jsp" />
	