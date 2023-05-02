<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	div#viewmy3 {
		background-color:#fefce7; 
		padding-top:40px;
		padding-bottom:40px;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
	function goshopping() { // 쇼핑하기 누르면 전체 제품페이지로 이동
	
		location.href = "<%= ctxPath%>/shop/allproduct.moc"; 
		// 왜 이동이 안되지???
	}
	
</script>


<div class="tab-pane container fade" id="viewmy3" style="background-color:#fefce7;">
	
	<h4 class="my-3" style="font-weight: bold; text-align: center;">주문내역 및 배송현황</h4>
	
	<form name="orderListFrm" class="col-md-12 py-3 mx-auto">
	<div class="row justify-content-around my-4 ">
	    <div class="col-2 text-center">주문번호</div>
	    <div class="col-2 text-center">주문날짜</div>
	    <div class="col-3 text-center" colspan="3">배송정보</div>
	    <div class="col-2 text-center">배송상태</div>
	    <div class="col-2 text-center">주문금액</div>
	</div>
	
	<hr>
	<c:if test="${not empty requestScope.orderMap}">
		<c:forEach var="odno" items="${requestScope.orderMap}">
		
			<div class="mt-4">${requestScope.orderMap.order_no}</div>
			<div class="mt-4">${requestScope.orderMap.orderdate}</div>
			<div colspan="3" class="col-md-6 text-left" style="font-size: 10pt;">
	 			<div><label>수령자성명 : </label>${requestScope.orderMap.delivery_name}</div>
	 			<div><label>수령자연락처 : </label>${requestScope.orderMap.delivery_mobile}</div>
	 			<div><label>수령자주소 : </label>${requestScope.orderMap.delivery_address}</div>
	 			<c:if test="${not empty requestScope.orderMap.delivery_comment}">
	 			  <div><label>수령자요청사항 : </label>${requestScope.orderMap.delivery_comment}</div>
	 			</c:if>
	 		</div>
			<div id="total_price" style="font-size: 12pt; font-weight: bold;"><div class="mt-4"><fmt:formatNumber value="${requestScope.orderMap.total_price}" pattern="###,###" />원</div></div>
		
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.orderMap}">
		<br><br><br>
		<div class="text-center">주문 내역이 없습니다.</div>
		<br><br>
		<div class="text-center">
			<button class="btn btn-lg col-4 mx-auto" style="border-radius: 5px; font-weight:bold; background-color:#ffeb99; " id="btnUpdate" onclick="goshopping()">지금 쇼핑하기</button>
		</div>
		<br><br><br>
	</c:if>
	
	</form>
	
</div>