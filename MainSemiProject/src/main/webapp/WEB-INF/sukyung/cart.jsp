<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	.change {
		color: red;
	}

</style>

<script type="text/javascript">

	let cart_product_count;

	$(document).ready(function(){
		
		$("div#body").hide();
		
	// *** 1. 수량 관련 이벤트
		// 수량에서 "+" 또는 "-" 를 클릭하면 발생하는 이벤트
		$("button.changeCount").click(function(){
			cart_product_count = $(this).parent().find('input').val();
			
			if($(this).text() == "+"){
				cart_product_count = Number(cart_product_count)+1;
				checkChangeCount();
				$(this).prev().val(cart_product_count);
				// 수량을 입력하는 input 태그의 value 값을 알아와서, 그 자리에 수량+1 한 값을 꽂아넣어준다.
			}
			else {
				cart_product_count = Number(cart_product_count)-1;
				checkChangeCount();
				$(this).next().val(cart_product_count);
				// 수량을 입력하는 input 태그의 value 값을 알아와서, 그 자리에 수량-1 한 값을 꽂아넣어준다.
			}
		}); // end of $("button.changeCount").click(function(){})

		// 수량이 변하면 발생하는 이벤트
		$("input#cart_product_count").bind("change", function(){
			cart_product_count = $(this).val();
			checkChangeCount();
			$(this).val(cart_product_count);
		}); // end of $("input#cart_product_count").bind("change", function(){})
		
	//////////////////////////////////////////////////////////////////////////////////////////
		
		$("input#CheckAll_product").prop("checked", true);
		$("input#CheckOne_product").prop("checked", true);
		
	// *** 2. 제품 체크박스 관련 이벤트
		// "전체상품선택" 체크박스를 클릭하면
		$("input#CheckAll_product").click((e)=>{
			if($(e.target).prop("checked")){ // 체크
				$("input#CheckOne_product").prop("checked", true);
			}
			else { // 체크해제
				$("input#CheckOne_product").prop("checked", false);
			}
		}); // end of $("input#CheckAll_product").click((e)=>{})

		// 제품한개 체크박스를 클릭하면
		$("input#CheckOne_product").click((e)=>{
			
			const bool = $(e.target).prop("checked");
			if(!bool){ // 제품한개 체크해제
				$("input#CheckAll_product").prop("checked", false);
			}
			else { // 제품한개 체크
				let b_flag = false;
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
			const frm = document.CartListFrm;
			frm.action = "<%= request.getContextPath()%>/shop/delivery.moc";
			frm.method = "post";
			frm.submit();
		}); // end of $("button#btnOrder").click(function(){})
		
	}); // end of $(document).ready(function(){})
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	// 수량이 변하면 호출되는 함수(1개~20개로 수량제한한다.)
	function checkChangeCount(){
		if(isNaN(cart_product_count) || cart_product_count <= 0){ 
			// 수량에 숫자가 아닌 값 또는 음수가 들어오면
			cart_product_count = "1";
		}
		else if(cart_product_count > 20){ // 수량이 20개보다 크면
			cart_product_count = "20";
			alert("최대 20개까지만 구매가능합니다.");
		}
	} // end of function checkChangeCount()
	
	
	// "추가하기" 버튼을 누르면 호출되는 함수
	function func_productAdd(){
		
		
	} // end of function func_productAdd()
	
</script>
	<form name="CartListFrm">
	<div class="container mt-5 mx-auto">
		
		<h2 class="text-center pb-3">장바구니</h2>
		<div class="row pb-3 mx-1">
			<div class="col-md-10 align-self-end">
				<label for="CheckAll_product"><input type="checkbox" name="CheckAll_product" id="CheckAll_product" /> 전체 상품 선택</label>
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
				      	  	<button type="button" class="btn btn-sm changeCount">-</button>
					      	<input type="text" value="1" id="cart_product_count" name="cart_product_count" class="col-md-4 text-center" style="border: none;"/>
					      	<button type="button" class="btn btn-sm changeCount">+</button>
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
				      	  	<button type="button" class="btn btn-sm changeCount">-</button>
					      	<input type="text" value="1" id="cart_product_count" name="cart_product_count" class="col-md-4 text-center" style="border: none;"/>
					      	<button type="button" class="btn btn-sm changeCount">+</button>
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
				<button type="button" id="btnAdd" class="btn btn-lg px-5 py-3" onclick="func_productAdd()">추가하기</button>
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
	</form>

		
<jsp:include page="../jaesik/footer.jsp" />
	