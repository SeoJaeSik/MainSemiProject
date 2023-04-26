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
  		console.log("로그인 하고 myaccount 오면 url => " + url);
   		
   	}//end of goEditPersonal()---------------------------------

</script>

<div class="bg-white container mt-5 mx-auto">
	<div class="container">
		<div class="세로">
			<section>
				<div class="row col-md-10 mx-auto my-5 justify-content-end">
					<div class="col-3"> </div>
					<div class="col-6"><h2 style="font-weight: bold; text-align: center;">YOUR ACCOUNT</h2></div>
					<div class="col-3 text-center"><button class="btn btn-warning btn-lg" id="btnPay" onclick="goLogOut();">LOG OUT</button></div>
	  			</div>
			
				<!-- Pills를 토글 가능하게 만들려면 각 링크에 data-toggle 속성을 data-toggle="pill"로 변경하십시오. 
				         그런 다음 모든 탭에 대해 고유한 ID가 있는 .tab-pane 클래스를 추가하고 .tab-content 클래스가 있는 <div> 요소 안에 래핑합니다.
		                 탭을 클릭할 때 탭이 페이드 인 및 페이드 아웃되도록 하려면 .fade 클래스를 .tab-pane에 추가하세요. 
		        -->
				<ul class="nav nav-pills justify-content-around" style="margin-bottom: 80px;">
					<li class="nav-item">
				    	<a class="accout_nav nav-link" data-toggle="pill" href="#viewmyInfo" style="font-size:15pt; height: 40px;">MY INFORMATION</a>
				  	</li>
					<li class="nav-item">
				    	<a class="accout_nav nav-link" data-toggle="pill" href="#memberEdit" style="font-size:15pt; height: 40px;">MY REVIEW</a>
				  	</li>
				  	<li class="nav-item">
				    	<a class="accout_nav nav-link" data-toggle="pill" href="#orderList" style="font-size:15pt; height: 40px;">MY ORDERLIST</a>
				  	</li>
				  	<li class="nav-item">
				    	<a class="accout_nav nav-link" data-toggle="pill" href="#qna" style="font-size:15pt; height: 40px;">FAQs / QNA</a>
				  	</li>
				</ul>
				
				<!-- 탭누르면 각자 태그에 맞게 나오는 곳 -->
				<div class="tab-content py-3" style="background-color:#fefce7;" >
				
					<%-- 나의정보보기  --%>
					<jsp:include page="myaccount_myInfo.jsp"/>
				
					<%-- 내가 작성한 리뷰 보기 --%>
					<jsp:include page="myaccount_myReview.jsp"/>
					
				  	<%-- 주문내역 및 배송현황 --%>
				  	<jsp:include page="myaccount_orderList.jsp"/>
				  	
				  	<%-- 게시판 --%>
				  	<jsp:include page="myaccount_board.jsp"/>
					
				</div>
						
				<br><br><br><br><br><br><br><br>
				
			</section>

		</div>
	</div>
</div>


<jsp:include page="../../jaesik/footer.jsp"/>