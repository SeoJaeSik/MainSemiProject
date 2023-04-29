<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	div#viewmyqna {
		background-color:#fefce7; 
		padding-top:40px;
		padding-bottom:40px;
	}

</style>


<div class="tab-pane container fade" id="viewmyqna">
   	<h4 class="my-3" style="font-weight: bold; text-align: center;">자주 묻는 질문</h4>
   
   	<form name="memberFrm" class="col-md-10 py-3 mx-auto">
   		<div class="row col-md-10 mx-auto">
			<select id="searchType" name="searchType" class="col-3 form-control" style="height:38px;">
				<%-- sql 문의 colname 변수에 잘들어가기 위해서는 DB 에 있는 컬럼명과 동일해야 한다~! --%>
				<option value="">선택하세요</option> 
				<option value="name">상품/배송</option>   
				<option value="userid">취소/교환/반품</option>
				<option value="email">주문/결제</option>
			</select>&nbsp;
			<input type="text" id="searchWord" name="searchWord" class="col-6 form-control" />
			<%--
				form 태그내에서 데이터를 전송해야 할 input 태그가 만약에 1개 밖에 없을 경우에는
				input 태그내에 값을 넣고나서 그냥 엔터를 해버리면 '유효성 검사'가 있더라도 하지않고 submit 되어져 버린다.
				이것을 막으려면 input 태그가 2개 이상 존재하면 된다.
				그런데 실제 화면에 보여질 input 태그는 1개이어야 한다.
				이럴 경우 (--!무작성 hidden 넣으면 안되고!--) 아래와 같이 display 를 none 으로 해주면 된다. 
			--%>
			<input type="text" style="display:none;"/>
		
			<button type="button" class="btn btn-secondary col-2" style="margin-left: 30px; margin-right: 30px;" onclick="goSearch();">검색</button>
		</div>
	</form>
	
	<table class="table table-hover col-md-10 py-3 mx-auto">
		<thead>
            <tr>
                <th class="col-1">No</th>
              	<th class="col-2">분류</th>
              	<th class="col-9">질문</th>
           	</tr>
        </thead>
        <tbody>
        	<tr>
        		<td class="col-1">1</td>
				<td class="col-2">배송/상품</td>
				<td class="col-9">
					<button class="btn" data-toggle="collapse" data-target="#Q1">
			  		Q. 배송비는 어떻게 되나요?
		  			</button>
					<div class="collapse mb-1" id="Q1" >
						<!-- .collapse 은 내용물을 숨기는 것임. -->
					  	<div class="card card-body"  id="Q1_A">
					   		<div>상품페이지에서 상품의 배송비를 확인하실 수 있습니다.</div>
							<div>무료배송 상품의 경우 결제시 별도로 결제할 비용이 없으나, 유료배송 상품의 경우 결제시 배송비를 함께 결제하셔야 합니다.</div>
							<div>(단, 유료배송 상품이더라도 묶음배송을 통해 배송비 기준 금액을 초과하여 구매하실 경우 무료배송으로 변경됩니다.)</div>
							<div>단, 일부 상품의 경우 지역이나 배송조건에 따라 추가 비용이 발생할 수 있습니다.</div>  
				        </div>
					</div>
				</td>
			</tr>
			<tr>
        		<td class="col-1">2</td>
				<td class="col-2">취소/반품</td>
				<td class="col-9 mx-0">
					<button class="btn" data-toggle="collapse" data-target="#Q2">
			  		Q. 주문 취소 처리 후, 환불까지 얼마나 소요되나요?
		  			</button>
					<div class="collapse mb-1" id="Q2" >
						<!-- .collapse 은 내용물을 숨기는 것임. -->
					  	<div class="card card-body" id="Q2_A">
					   		<div>주문취소는 '결제완료' 단계에서는 직접 가능합니다.(단, 커스텀 상품 제외)</div> 
					   		<div>마이페이지 주문배송현황 페이지에서 취소하고자 하는 주문을 확인한 후 '주문취소' 버튼을 누르면 주문취소가 완료됩니다.</div> 
					   		<div>'상품준비중'인 경우에는 고객센터로 문의해주시기 바랍니다.</div>
					   	</div>
					</div>
				</td>
			</tr>	
			<tr>
        		<td class="col-1">3</td>
				<td class="col-2">주문/결제</td>
				<td class="col-9">
					<button class="btn" style="boder-line:none;" data-toggle="collapse" data-target="#Q3">
			  		Q. 지금까지 주문한 상품내역을 보고 싶어요.
		  			</button>
					<div class="collapse mb-1" id="Q3" >
						<!-- .collapse 은 내용물을 숨기는 것임. -->
					  	<div class="card card-body" id="Q3_A">
					   		<div>마이페이지 > 주문내역/배송현황 에서 주문하신 내역을 확인 하실 수 있습니다.</div> 
					   		<div>한번에 조회가능한 기간은 최대 6개월이며, 그 이전의 주문내역이 궁금하실 경우 고객센터 1522-1882로 문의해주십시오.</div>
					   	</div>
					</div>
				</td>
			</tr>		
		</tbody>
	</table>
	
	<!-- 페이지네이션 -->
	<nav>
	  	<ul class="pagination justify-content-center" >
		    <li class="page-item"><a class="page-link" style="color:black;" href="#">Previous</a></li>
		    <li class="page-item active"><a class="page-link" style="color:black;" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" style="color:black;" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" style="color:black;" href="#">Next</a></li>
	  	</ul>
	</nav>

</div>