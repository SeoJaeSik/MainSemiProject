<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../jaesik/header.jsp" />

<style type="text/css">

	button#btnCoupon, button#btnPay, span#badge_count {
		background-color: #fdd007;
		border: none;
		box-shadow: 1px 1px 1px 1px #e6e6e6;
	}

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("ul#nav_bar_circle > li:last-child > div > a").html("<span id='navbar_page' class='rounded-circle'></span>");
		
		
	}); // end of $(document).ready(function(){})

</script>

<div class="container py-4 mx-auto my-3" style="background-color: #fff9e5; border-radius: 1%;">
		<h2 class="text-center pb-3">결제하기</h2>
		<div class="row pb-3 mx-1">
			<div class="col-md-9"></div>
			<div class="col-md-2">
				<button type="button" id="btnPay" class="btn btn-lg">결제하기</button>
			</div>
		</div>
		
		<div class="table-responsive mx-auto col-md-10 border-bottom">
			<table class="table text-center" id="tbl_orderList">
			  <thead>
			    <tr>
			    	<th colspan="2" class="col-md-8">선택한 상품/옵션</th>
			      	<th class="col-md-4">합계</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr class="pt-2">
			      	<td>
				      	<div class="position-relative">
							<img src="https://image.nbkorea.com/NBRB_Product/20230331/NB20230331151327051001.jpg" id="product_image" name="product_image" width="150"/>					  
							<span id="badge_count" class="position-absolute translate-middle p-2 ml-n3 mt-n2 badge border border-light rounded-circle">
								<span class="visually-hidden">10</span>
							</span>
						</div>
			      	</td>
			      	<td class="text-left">
			      		<div id="product_name" name="product_name">프레쉬폼x 860 V13 (남성, D)</div>
			      		<div id="product_color" name="product_color">(BF)black graphic<span>,&nbsp;</span><span id="product_size" name="product_size">260</span></div>
			      		<div id="product_price" name="product_price">￦169,000</div>
			      	</td>
			      	<td style="font-size: 14pt; font-weight: bold;" id="total_product_price" name="total_product_price">￦338,000</td>
			    </tr>
			    
			    <%-- 중복된 부분!! 나중에 forEach 로 할 예정 --%>
			    <tr class="pt-2">
			      	<td>
				      	<div class="position-relative">
							<img src="https://image.nbkorea.com/NBRB_Product/20230331/NB20230331151327051001.jpg" id="product_image" name="product_image" width="150"/>					  
								<span id="badge_count" class="position-absolute translate-middle p-2 ml-n3 mt-n2 badge border border-light rounded-circle">
									<span class="visually-hidden">10</span>
							</span>
						</div>
			      	</td>
			      	<td class="text-left">
			      		<div id="product_name" name="product_name">프레쉬폼x 860 V13 (남성, D)</div>
			      		<div id="product_color" name="product_color">(BF)black graphic<span>,&nbsp;</span><span id="product_size" name="product_size">260</span></div>
			      		<div id="product_price" name="product_price">￦169,000</div>
			      	</td>
			      	<td style="font-size: 14pt; font-weight: bold;" id="total_product_price" name="total_product_price">￦338,000</td>
			    </tr>
			  </tbody>
			</table>
		</div>

		<div class="row my-3 px-0 mx-auto col-md-10">
			<div class="col-md-6"></div>
			<div id="div_price" class="py-3 col-md-6">
				<div class="row my-3">
					<div class="col-md-10 text-right"><input type="text" id="coupon" class="py-1" placeholder="할인코드적용"/></div>
					<button type="button" id="btnCoupon" class="btn col-md-2 mx-auto">적용</button>
				</div>
			
				<div class="row m-1 mt-5">
					<div class="col-md-5"></div>
					<div class="col-md-3">주문금액</div>
					<div class="col-md-4 text-right" id="price_sum" name="price_sum">￦636,000</div>
				</div>
				<div class="row m-1">
					<div class="col-md-5"></div>
					<div class="col-md-3">배송비</div>
					<div class="col-md-4 text-right" id="delivery_fee" name="delivery_fee">￦0</div>
				</div>
				<div class="row m-1">
					<div class="col-md-5"></div>
					<div class="col-md-3">할인금액</div>
					<div class="col-md-4 text-right" id="price_discount" name="total_price">￦0</div>
				</div>
				<div class="row m-1">
					<div class="col-md-5"></div>
					<div class="col-md-4" style="color: red;">할인코드 적용</div>
					<div class="col-md-3 text-right" id="coupon" name="coupon" style="color: red;">없음</div>
				</div>
				<div class="row m-1 my-5">
					<div class="col-md-5"></div>
					<div class="col-md-3" style="font-size: 14pt; font-weight: bold;">결제금액</div>
					<div class="col-md-4 text-right" id="total_price" name="total_price" style="font-size: 14pt; font-weight: bold;">￦636,000</div>
				</div>

				<div class="row m-1 my-5">
					<div class="col-md-7"></div>
					<div class="col-md-5">
						<button type="button" id="btnPay" class="btn btn-lg">결제하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../jaesik/footer.jsp" />
	