<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	div#viewmyorderList {
		background-color:#fefce7; 
		padding-top:40px;
		padding-bottom:40px;
	}

</style>

<script type="text/javascript">

	function goshopping() { // 쇼핑하기 누르면 전체 제품페이지로 이동
	
		location.href = "<%= ctxPath%>/shop/allproduct.moc";
	}

</script>


<div class="tab-pane container fade" id="viewmyorderList" style="background-color:#fefce7;">
	<h4 class="my-3" style="font-weight: bold; text-align: center;">주문내역 및 배송현황</h4>
	<div class="row justify-content-around my-4 pb-2 border-bottom ">
	    <div class="col-2 text-center">주문번호</div>
	    <div class="col-2 text-center">주문날짜</div>
	    <div class="col-2 text-center">주문금액</div>
	    <div class="col-2 text-center">배송상태</div>
	    <div class="col-2 text-center">합계</div>
	</div>
	<br><br><br><br><br>
	<div class="text-center">주문 내역이 없습니다.</div>
	<br><br>
	<div class="text-center">
		<button class="btn btn-lg col-4 mx-auto" style="border-radius: 5px; font-weight:bold; background-color:#ffeb99; " id="btnUpdate" onclick="goshopping()">지금 쇼핑하기</button>
	</div>
	<br><br><br><br><br>
</div>