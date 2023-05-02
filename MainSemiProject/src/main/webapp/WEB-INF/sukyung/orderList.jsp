<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../jaesik/header.jsp" />

<style type="text/css">

tr, th, td, div {
	/* border: solid 1px blue; */
}
label{
	width: 17%;
	text-align:right;
	margin-right: 5px;
}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){

		$("div#div_container").hide();
		$("div#div_container").fadeIn(1500);
		$("table#ViewOrderDetail").hide();
		
		// "주문상세내역" 클릭하면 보이기
		$("button#btnViewOrderDetail").click(function(){
			$("table#ViewOrderDetail").slideDown(1000);
			$("div#btnViewOrderDetail").slideUp(500);
		}); // end of $("button#btnViewOrderDetail").click(function(){})
		
		
		
	}); // end of $(document).ready(function(){})

//////////////////////////////////////////////////////////////////////////////////////////
	
	
</script>

<div style="height: 50px;"></div>
<div id="div_container" class="container py-4 mx-auto my-3" style="background-color: #fefce7; border-radius: 1%;">
		
		<h2 class="text-center py-3">주문내역</h2>
		
		<div class="table-responsive mx-auto">
			<table class="table text-center" id="tbl_orderList">
			  <thead>
			    <tr>
			    	<th class="col-md-2">주문번호</th>
			    	<th class="col-md-2">주문날짜</th>
			      	<th colspan="3" class="col-md-6">배송정보</th>
			      	<th class="col-md-2">결제금액</th>
			    </tr>
			  </thead>
		      <tbody>
		 	  	<tr>
			 		<td><div class="mt-4">${requestScope.orderMap.order_no}</div></td>
			 		<td><div class="mt-4">${requestScope.orderMap.orderdate}</div></td>
			 		<td colspan="3" class="col-md-6 text-left" style="font-size: 10pt;">
			 			<div><label>수령자성명 : </label>${requestScope.orderMap.delivery_name}</div>
			 			<div><label>수령자연락처 : </label>${requestScope.orderMap.delivery_mobile}</div>
			 			<div><label>수령자주소 : </label>${requestScope.orderMap.delivery_address}</div>
			 			<c:if test="${not empty requestScope.orderMap.delivery_comment}">
			 			  <div><label>수령자요청사항 : </label>${requestScope.orderMap.delivery_comment}</div>
			 			</c:if>
			 		</td>
			 		<td id="total_price" style="font-size: 12pt; font-weight: bold;"><div class="mt-4"><fmt:formatNumber value="${requestScope.orderMap.total_price}" pattern="###,###" />원</div></td>
		 	  	</tr>
		 	  	<tr>
			 		<td colspan="6">
			 			<div id="btnViewOrderDetail">
						  <button type="button" id="btnViewOrderDetail" class="btn px-4 my-3" style="background-color: #fdd007;">주문상세내역 확인하기</button>
			 			</div>
			 		</td>
		 		</tr>
		     </tbody>
		</table>
 	  	<table id="ViewOrderDetail"  class="table text-center col-md-10 mx-auto">
	        <%-- [주문상세내역] 보기 버튼 클릭 --%>
	      <thead>
	 	  	<tr>
		 		<th colspan="2" class="col-md-6">주문상품/옵션</th>
		 		<th>주문수량</th>
		 		<th>주문금액</th>
	 	  	</tr>
	      </thead>
	      <tbody>
	      	<tr><td><p>주문상세내역 확인하기</p></td></tr>  
	 	  	<c:forEach var="odvo" items="${requestScope.orderDetailList}">
	 	  	  <tr>
		 		<td class="col-md-3 text-right">
		 		  <input type="hidden" id="order_detail_no" val="${odvo.order_detail_no}"/>
		 		  <img src="${odvo.pvo.product_image}" id="product_image" name="product_image" width="150" class="img-thumbnail"/>
		 		</td>
		 		<td class="col-md-3 text-left">
		 		  <div class="mt-4">
		    		<input type="hidden" id="product_no" name="product_no" value="${odvo.pvo.product_no}" />
		      		<div id="product_name">${odvo.pvo.product_name}</div>
		      		<div id="product_color">${odvo.pvo.product_color}<span>&nbsp;</span><span id="product_size" name="product_size">${odvo.pvo.product_size}</span></div>
		 		  </div>
		 		</td>
		 		<td class="col-md-2" id="order_count"><div class="mt-4">${odvo.order_count} 개</div></td>
		 		<td class="col-md-2" id="order_price" style="font-size: 12pt; font-weight: bold;"><div class="mt-4"><fmt:formatNumber value="${odvo.order_price}" pattern="###,###" />원</div></td>
	 	  	  </tr>
	 	  	</c:forEach>
	      </tbody>
 	  	</table>
	</div>
	<div style="height: 100px;"></div>
		
</div>
<div style="height: 100px;"></div>
		
<jsp:include page="../jaesik/footer.jsp" />
	