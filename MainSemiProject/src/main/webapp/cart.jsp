<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="header.jsp" />

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

</style>

<script type="text/javascript">

	$(document).ready(function(){

		// 수량에서 "+" 를 클릭하면 발생하는 이벤트
		$("button.count_plus").click((e)=>{
			const cart_product_count = $(e.target).prev().val(); 
			if(cart_product_count >= 20){ // 수량이 20개 이상이면
				$(e.target).prev().val("20");
				alert("최대 20개까지만 구매가능합니다.");
			}
			else {
				$(e.target).prev().val(Number(cart_product_count)+1);
				// 수량을 입력하는 input 태그의 value 값을 알아와서, 그 자리에 수량+1 한 값을 꽂아넣어준다.
			}
		});
		
		// 수량에서 "-" 를 클릭하면 발생하는 이벤트
		$("button.count_minus").click((e)=>{
			const cart_product_count = $(e.target).next().val(); 
			if(cart_product_count <= 1){ // 수량에 1개 이하이면
				$(e.target).next().val("1");
			}
			else {
				$(e.target).next().val(Number(cart_product_count)-1);
				// 수량을 입력하는 input 태그의 value 값을 알아와서, 그 자리에 수량-1 한 값을 꽂아넣어준다.
			}
		});
		
		// 수량이 변하면 발생하는 이벤트(1개~20개로 수량제한한다.)
		$("input#cart_product_count").bind("change", (e)=>{
			const cart_product_count = $(e.target).val(); 
			if(isNaN(cart_product_count)){ // 수량에 숫자가 아닌 값이 들어오면
				$(e.target).val("");
				$(e.target).val("1");
			}
			else if(cart_product_count <= 0){ // 수량에 음수가 들어오면
				$(e.target).val("");
				$(e.target).val("1");
			}
			else if(cart_product_count > 20){ // 수량이 20개보다 크면
				$(e.target).val("");
				$(e.target).val("20");
				alert("최대 20개까지만 구매가능합니다.");
			}
		});

	}); // end of $(document).ready(function(){})
	
	
</script>

	<div class="container mt-5 mx-auto">
		
		<h2 class="text-center pb-3">장바구니</h2>
		<div class="row pb-3 mx-1">
			<div class="col-md-10 align-self-end">
				<label for="CheckAll"><input type="checkbox" name="CheckAll_product" id="CheckAll_product" /> 전체 상품 선택</label>
			</div>
			<div class="col-md-2">
				<button type="button" id="btnOrder" class="btn btn-lg">주문하기</button>
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
			    <tr class="pt-2">
			    	<td><input type="checkbox" name="CheckOne_product" id="CheckOne_product" /></td>
			      	<td><img src="https://image.nbkorea.com/NBRB_Product/20230331/NB20230331151327051001.jpg" id="product_image" name="product_image" width="150"/></td>
			      	<td class="text-left">
			      		<div id="product_name" name="product_name">프레쉬폼x 860 V13 (남성, D)</div>
			      		<div id="product_color" name="product_color">(BF)black graphic<span>,&nbsp;</span><span id="product_size" name="product_size">260</span></div>
			      		<button type="button" id="btnOptionChange" class="btn btn-sm my-2">옵션변경</button>
			      	</td>
			      	<td id="product_price" name="product_price">￦169,000</td>
			      	<td>
				      	<span class="border py-1" style="border: solid 1px gray;">
				      	  	<button type="button" class="btn btn-sm count_minus">-</button>
					      	<input type="text" value="1" id="cart_product_count" name="cart_product_count" class="col-md-4 text-center" style="border: none;"/>
					      	<button type="button" class="btn btn-sm count_plus">+</button>
					    </span>
				    </td>
			      	<td style="font-size: 14pt; font-weight: bold;">￦338,000</td>
			    </tr>
			    
			    <%-- 중복된 부분!! 나중에 forEach 로 할 예정 --%>
			    <tr class="pt-2">
			    	<td><input type="checkbox" name="CheckOne_product" id="CheckOne_product" /></td>
			      	<td><img src="https://image.nbkorea.com/NBRB_Product/20230331/NB20230331151327051001.jpg" id="product_image" name="product_image" width="150"/></td>
			      	<td class="text-left">
			      		<div id="product_name" name="product_name">프레쉬폼x 860 V13 (남성, D)</div>
			      		<div id="product_color" name="product_color">(BF)black graphic<span>,&nbsp;</span><span id="product_size" name="product_size">260</span></div>
			      		<button type="button" id="btnOptionChange" class="btn btn-sm my-2">옵션변경</button>
			      	</td>
			      	<td id="product_price" name="product_price">￦169,000</td>
			      	<td>
				      	<span class="border py-1" style="border: solid 1px gray;">
				      	  	<button type="button" class="btn btn-sm count_minus">-</button>
					      	<input type="text" value="1" id="cart_product_count" name="cart_product_count" class="col-md-4 text-center" style="border: none;"/>
					      	<button type="button" class="btn btn-sm count_plus">+</button>
					    </span>
				    </td>
			      	<td style="font-size: 14pt; font-weight: bold;">￦338,000</td>
			    </tr>
			  </tbody>
			</table>
		</div>
		
		<div id="div_extra" class="row my-5 py-3 mx-1">
			<div class="col-md-3 text-right align-self-center">함께 구매하면 좋은 상품</div>
			<div class="col-md-2 text-center"><img src="https://image.nbkorea.com/NBRB_Product/20230331/NB20230331151327051001.jpg" id="product_image" name="product_image" width="120" class="img-thumbnail"/></div>
			<div class="col-md-4">
				<div class="my-1">
					<span id="product_name" name="product_name">프레쉬폼x 860 V13 (남성, D)</span>&nbsp;&nbsp;<span id="product_price" name="product_price">￦169,000</span>
				</div>
	      		<select id="product_size" name="product_size" class="my-1">
			    <%-- 중복된 부분!! 나중에 제이쿼리로 할 예정 --%>
	      			<option>사이즈</option>
	      			<option>220</option>
	      			<option>240</option>
	      			<option>260</option>
	      		</select>
	      		<div class="my-1">색상
	      			<span id="product_color" name="product_color" class="rounded-circle" style="background-color: red;"></span>
	      			<span id="product_color" name="product_color" class="rounded-circle" style="background-color: blue;"></span>
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
			<div class="row m-1">
				<div class="col-md-9"></div>
				<div class="col" style="font-size: 14pt; font-weight: bold;">주문금액</div>
				<div class="col text-right" id="total_price" name="total_price" style="font-size: 14pt; font-weight: bold;">￦636,000</div>
			</div>
			<div class="row m-1">
				<div class="col-md-9"></div>
				<div class="col" style="font-size: 14pt; font-weight: bold;">배송비</div>
				<div class="col text-right" id="delivery_fee" name="delivery_fee" style="font-size: 14pt; font-weight: bold;">￦0</div>
			</div>
		</div>

		<div class="row my-5 px-1">
			<div class="col-md-8"></div>
			<div class="col align-self-center text-right"><button type="button" id="btnContinue" class="btn btn-sm">쇼핑 계속하기</button></div>
			<div class="col align-self-center text-right"><button type="button" id="btnOrder" class="btn btn-lg">주문하기</button></div>
		</div>
		
	</div>

	
<jsp:include page="footer.jsp" />
	