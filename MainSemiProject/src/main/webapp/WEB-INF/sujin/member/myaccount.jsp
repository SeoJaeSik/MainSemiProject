<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../jaesik/header.jsp"/>

<!-- 다음소스 가져오기 !-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("small.error").hide();  	// 처음에 경고문구 다 안 뜨게 숨겨놓고,
		$("input#name").focus(); 	// 성명 입력창에 포커스를 놓는다
		
	});//end of ready()-------------------------------------
	
	// == 로그아웃 ==
	function goLogOut() {
		
		// 로그아웃하면 메인으로감
		location.href = "<%= request.getContextPath()%>/login/logout.moc";
		
	}//end of goLogOut()-------------------------------------
	
	
	// == 개인정보수정 == 
   	function goEditPersonal(userid) {
   		
   		// div#memberEdit 안에 나타내기
   		const url = "<%= request.getContextPath()%>/member/memberEdit.moc?userid=" + userid;
  
   		
   	}//end of goEditPersonal()---------------------------------

</script>



<div class="bg-white container mt-5 mx-auto">
	<div class="container">
		<div class="세로">
			<section>
				<div class="row col-md-10 mx-auto my-5 justify-content-end">
					<div class="col-3"> </div>
					<div class="col-6"><h2 style="font-weight: bold; text-align: center;">YOUR ACCOUNT</h2></div>
					<div class="col-3 text-center"><button class="btn btn-warning btn-md" id="btnPay" onclick="goLogOut();">LOG OUT</button></div>
	  			</div>
			
				<!-- Pills를 토글 가능하게 만들려면 각 링크에 data-toggle 속성을 data-toggle="pill"로 변경하십시오. 
				         그런 다음 모든 탭에 대해 고유한 ID가 있는 .tab-pane 클래스를 추가하고 .tab-content 클래스가 있는 <div> 요소 안에 래핑합니다.
		                         
		                         탭을 클릭할 때 탭이 페이드 인 및 페이드 아웃되도록 하려면 .fade 클래스를 .tab-pane에 추가하세요. 
		        -->
				<ul class="nav nav-pills justify-content-around" style="margin-bottom: 80px;">
				  	<li class="nav-item">
				    	<a class="accout_nav nav-link active" data-toggle="pill" href="#memberEdit">개인정보수정</a>
				  	</li>
		
				  	<li class="nav-item">
				    	<a class="accout_nav nav-link" data-toggle="pill" href="#orderList">주문내역</a>
				  	</li>
				  	<li class="nav-item">
				    	<a class="accout_nav nav-link" data-toggle="pill" href="#qna">고객센터</a>
				  	</li>
				</ul>
				
				<!-- 탭누르면 각자 태그에 맞게 나오는 곳 -->
				<div class="tab-content py-3" style="background-color:#fefce7;" >
				  	<div class="tab-pane container active"  id="memberEdit">
				  		<h4 class="my-3" style="font-weight: bold; text-align: center;">개인정보 수정하기</h4>
						<form class="col-md-10 py-3 mx-auto">
					  
						  	<div class="form-group row col-md-10 mx-auto">
							    <label class="col-3 col-form-label text-left">성명&nbsp;<span class="star">*</span></label>
							    <input class="col-6 form-control" type="text" id="name" class="requiredInfo" placeholder = "Name"></input>
						  	</div>
						  
						  	<div class="form-group row col-md-10 mx-auto" >
							    <label class="col-3 col-form-label text-left">이메일&nbsp;<span class="star">*</span></label>
							    <input class="col-6 form-control" type="text" id="email"  class="requiredInfo" placeholder = "Email" />&nbsp;
							    <button class="btn btn-secondary btn-sm col-3" id="duplicatechk" style="border-radius: 20px;" onclick="isExistEmailCheck();">Email 중복확인</button>
							    <span id="emailCheckResult"></span>
							    <span><small class="error" style="color:red">The email format is not correct.</small></span>
						  	</div>
						  
						  	<div class="form-group row col-md-10 mx-auto">
							    <label class="col-3 col-form-label text-left">비밀번호&nbsp;<span class="star">*</span></label>
							    <input class="col-6 form-control" type="password" id="pwd" class="requiredInfo" placeholder = "Password"></input>
							    <span><small class="error" style="color:red">Password is required</small></span>
						  	</div>
						  
						  	<div class="form-group row col-md-10 mx-auto">
							    <label class="col-3 col-form-label text-left">비밀번호확인&nbsp;<span class="star">*</span></label>
							    <input class="col-6 form-control" type="password" id="pwdcheck" class="requiredInfo" placeholder = "Confirm Password"></input>
							    <span><small class="error" style="color:red">Please enter valid, matching passwords.</small></span>
						  	</div>
						  
						  	<div class="form-group row col-md-10 mx-auto">
							    <label class="col-3 col-form-label text-left">연락처</label>	 
							    <input class="col-2 form-control" type="text" id="hp1" name="hp1" value="010" readonly />&nbsp; <!-- readonly : 읽기전용으로 010 만 보여주고 변경할 수 없도록 해준다 -->
					           	<input class="col-2 form-control" type="text" id="hp2" name="hp2" />&nbsp;
					           	<input class="col-2 form-control" type="text" id="hp3" name="hp3" />
					           	<span><small class="error" style="color:red">It's not phone number type.</small></span>
						  	</div>
						  	
						  	<div class="form-group row col-md-10 mx-auto">
							    <label class="col-3 col-form-label text-left">우편번호</label>
							    <input type="text" class="col-3 form-control" id="postcode" placeholder="우편번호" />&nbsp;
							    <button class="btn btn-secondary btn-sm col-3" id="zipcodeSearch" style="border-radius: 20px;">우편번호찾기</button>
								<span><small class="error" style="color:red">It's not postcode type.</small></span>
						  	</div>
						  
						  	<div class="form-group row col-md-10 mx-auto">
							    <label class="col-3 col-form-label text-left">주소</label>
							    <input class="col-8 form-control" type="text" id="address" placeholder="Address" />
						  	</div>
						  	<div class="form-group row col-md-10 mx-auto">	 
							    <label class="col-3 col-form-label"> </label>
					           	<input class="col-8 form-control" type="text" id="detailaddress" placeholder="Detail Address" />
				          	</div>
				          	<div class="form-group row col-md-10 mx-auto"> 	
					           	<label class="col-3 col-form-label"> </label>
					           	<input class="col-8 form-control" type="text" id="extraaddress" placeholder="Extra Address" />
						  	</div>
						  
						  	<div class="form-group row col-md-10 mx-auto">
							    <label class="col-3 col-form-label text-left">생년월일</label>	 
							    <input class="col-3 form-control" type="number" id="birthyyyy" min="1950" max="2050" step="1" value="1995" required />&nbsp;
					           	<select class="col-2 form-control" type="number" id="birthmm" ></select>&nbsp;
					           	<select class="col-2 form-control" type="number" id="birthdd" ></select>
						  	</div>
						  	
						  	<div class="form-group row col-md-10 mx-auto">
				            	<input class="col-1 form-control" style="height:15px; margin-top:12px; margin-left:30px;" type="checkbox" name="agree" id="agree" />&nbsp;&nbsp;
				            	<label class="col-form-label" for="agree" ><small>Get updates on MOSACOYA news and promotions.</small></label>
				         	</div>
				
						  	<div class="form-group row col-md-10 mx-auto">
							  	<!-- <input type="button" class="btn btn-secondary btn-sm mt-3" id="btnUpdate" onClick="goEdit();" value="수정" style="font-size: 15pt;" />
	            				<input type="button" class="btn btn-secondary btn-sm mt-3 ml-5" onClick="self.close()" value="취소" style="font-size: 15pt;" />  -->
								<button class="btn btn-md col-4 mx-auto" style="border-radius: 5px; font-weight:bold; background-color:#f0e68f; " id="btnUpdate" onclick="goEdit()">수정하기</button>
								<button class="btn btn-md col-4 mx-auto" style="border-radius: 5px; font-weight:bold; background-color:#f0e68f; " onclick="self.close()">취소하기</button>
						  	</div>
					  	
						</form>
				  	</div>
				  
				  	<div class="tab-pane container fade" id="orderList">
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
							<button class="btn btn-lg col-4 mx-auto" style="border-radius: 5px; font-weight:bold; background-color:#f0e68f; " id="btnUpdate" onclick="goEdit()">지금 쇼핑하기</button>
						</div>
						<br><br><br><br><br>
				  	</div>
				  	<div class="tab-pane container fade" id="qna">
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
							    <li class="page-item"><a class="page-link" style="color:black;" href="#">3</a></li>
							    <li class="page-item"><a class="page-link" style="color:black;" href="#">Next</a></li>
						  	</ul>
						</nav>
					
					</div>
				</div>
						
				<br><br><br><br><br><br><br><br>
				
			</section>

		</div>
	</div>
</div>


<jsp:include page="../../jaesik/footer.jsp"/>