<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../jaesik/header.jsp"/>

<style type="text/css">



	
	
	
		
	
</style>

<script type="text/javascript">

	let start = 1;
	
	// HIT 상품 "스크롤" 할 때 보여줄 상품의 개수(단위) 크기
	let lenALL = 8;

	$(document).ready(function() {
		
		$("span#totalAllCount").hide();
		$("span#countAll").hide();
		
		// ALL상품 게시물을 더보기 위하여 "scroll" 이벤트에 대한 초기값 호출하기 
        // 즉, 맨처음에는 "scroll" 을 하지 않더라도 scroll한 것 처럼 8개의 ALL상품을 게시해주어야 한다는 말이다. 
		displayAll(start); // 문서가 로딩되자마자 함수 호출시켜서 제품을 자동으로 보여줌
		
		// === scroll 이벤트 발생시키기 시작 === //
		$(window).scroll(function() {

			// 스크롤탑의 위치값 
		    // console.log( "$(window).scrollTop() => " + $(window).scrollTop() );
			
			// 보여주어야할 문서의 높이값(더보기를 해주므로 append 되어져서 높이가 계속 증가 될것이다)
       		// console.log( "$(document).height() => " + $(document).height() );	
			
       		// 웹브라우저창의 높이값(디바이스마다 다르게 표현되는 고정값) 
            // console.log( "$(window).height() => " + $(window).height() );
			
			// 아래는 scroll 되어진 scroll 탑의 위치값이 웹브라우저창의 높이만큼 내려갔을 경우를 알아보는 것이다.
			console.log( "$(window).scrollTop() => " + $(window).scrollTop() );
	        console.log( "$(document).height() - $(window).height() => " + ( $(document).height() - $(window).height() ) );
			
	         
	        // 아래는 만약에 위의 값이 제대로 안나오는 경우 이벤트가 발생되는 숫자를 만들기 위해서 스크롤탑의 위치값에 +1 을 더해서 보정해준 것이다. 
            // console.log( "$(window).scrollTop() + 1  => " + ( $(window).scrollTop() + 1  ) );
            // console.log( "$(document).height() - $(window).height() => " + ( $(document).height() - $(window).height() ) ); 
			
            if($(window).scrollTop() +1 >= $(document).height() - $(window).height() ) {
            	// 만약 스크롤이 잘 안되면 아래의 것 중 하나를 골라서 하도록 한다.
	            // if($(window).scrollTop() +1 >= $(document).height() - $(window).height() ) {
	            // if( $(window).scrollTop() == $(document).height() - $(window).height() )	
	            //	alert("기존 문서 내용을 끝까지 봤습니다. 이제 새로운 내용을 읽어다가 보여드리겠습니다.");
	            $("span#totalHITCount").text();
	            $("span#countHIT").text();
	            
	            if( $("span#totalAllCount").text() != $("span#countAll").text() ) {
		            start += lenALL;
		            displayALL(start); 
	            }
	            
	         }
	            
            if( $(window).scrollTop() == 0 ) {
            	// 다시 처음부터 시작하도록 한다.
            	
            	$("div#displayALL").empty();
            	$("span#end").empty();
            	$("span#countAll").text(0);
            	
            	start = 1;
            	displayALL(start);
            	
            }
			
		});	//end of $(window).scroll(function()---------------------------
		
					
		// === scroll 이벤트 발생시키기 끝 === //
		
		
	}); // end of $(document).ready(function() -----------------

			
			
			
	// Function Declaration
	
	// display할 전체상품 정보 추가 요청(Ajax로 처리)
	function displayAll(start) {
		
		$ajax({
			url:"<%= request.getContextPath()%>/shop/mallDisplayJSON.up",
			type:"GET", // default값임
			data:{"shoes_category_no":"product_no",
				  "start":start,
				  "len":lenALL}
			dataType:"json",
		//	async:true, // 비동기방식, default도 비동기임
			success:function(json){
					
					console.log("확인용 json => " + json);
					console.log("json 의 타입 => " + typeof json);
				
				/*	console.log("확인용 json => " + JSON.stringify(json)); // JSON객체를 string 타입으로 변경시켜준다.
					
					//	console.log("JSON.stringify(json) 의 타입 => " + typeof JSON.stringify(json)); // JSON.stringify(json) 의 타입 => string
					
					// 또는 
					// json => []
				*/				
					let html = "";
					
					if(start == "1" && json.length == 0) {
						// 처음부터 데이터가 존재하지 않는 경우라면 
						// 주의 !!! json == null 이 아님!!!
				        // json.length == 0 으로 해야함. []은 빈배열이기 때문
						html += "현재 상품 준비중...";
						
						// HIT 상품 결과물 출력하기
						$("div#displayALL").html(html);
					}
					
					else if(json,length > 0) {
						// 데이터가 존재하는 경우
						
						// 자바스크립트를 사용하는 경우
						<%--
						json.forEach(function(item, index, array) {
							
						});
						--%>
						
						// 제이쿼리를 사용하는 경우
						$.each(json, function(index, item) {
							
							html +=  "<div class='col-md-6 col-lg-3'>"+
				                        "<div class='card mb-3'>"+
				                            "<img src='/MyMVC/images/"+item.product_image+"' class='card-img-top' style='width: 100%' />"+
				                            "<div class='card-body' style='padding: 0; font-size: 11pt;'>"+
				                              "<ul class='list-unstyled mt-3 pl-3'>"+
				                                 "<li><label class='prodInfo'>제품명</label>"+item.pname+"</li>"+
				                                 "<li><label class='prodInfo'>정가</label><span style=\"color: red; text-decoration: line-through;\">"+(item.price).toLocaleString('en')+" 원</span></li>"+
				                                   "<li><label class='prodInfo'>판매가</label><span style=\"color: red; font-weight: bold;\">"+(item.saleprice).toLocaleString('en')+" 원</span></li>"+
				                                   "<li><label class='prodInfo'>할인율</label><span style=\"color: blue; font-weight: bold;\">["+item.discoutPercent+"%] 할인</span></li>"+
				                                   "<li><label class='prodInfo'>포인트</label><span style=\"color: orange;\">"+(item.point).toLocaleString('en')+" POINT</span></li>"+ 
				                                   "<li class='text-center'><a href='/MyMVC/shop/prodView.up?pnum="+item.pnum+"' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li>"+ 
				                                   <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>         
				                              "</ul>"+
				                            "</div>"+
				                         "</div>"+ 
				                      "</div>";
				                      
				                      
		                     html += "<div class='col-md-6 col-lg-4 col-xl-4'>"+
										"<div id='product-1' class='single-product' href='#'>"+
										"<div class='part-1'>"+
											"<img alt='제품' style='width:inherit; height:inherit;' src='+tem.product_image+'>"+
											"<ul>+"
												"<li><a href='#'><i class='fas fa-shopping-cart'></i></a></li>"+
												"<li><a href='#'><i class='fa-solid fa-credit-card'></i></a></li>"+
												"<li><a href='#'><i class='fas fa-expand'></i></a></li>"+
											"</ul>"+
										"</div>"+
										"<div class='part-2'>"+
											"<h3 class='product-title'>"+item.product_price+"</h3>"+
											"<h4 class='product-price'>"+item.product_price+"</h4>"+
										"</div>"+
										"</div>"+
									"</div>";  
				                     
				                      
				                      
				                      
				                      
				                      
				                      
				                      
						});// end of $.each(json, function(index, item)-------------------
						
						// HIT 상품 결과물 출력하기
						$("div#displayALL").append(html);		
						
						// $("span#countAll") 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
						$("span#countAll").text( Number($("span#countAll").text()) + json.length ); // span 태그는 value값이 없다. 그래서 text로 해준다.(아래 태그를 보면 이해할 수 있다.)
																						  // text()는 읽어온다는 것 text(내용)은 넣어준다는 것
																				
					     // 스크롤을 계속해서 countHIT 값과 totalAllCount 값이 일치하는 경우 
		                if( $("span#totalAllCount").text() == $("span#countAll").text() ) {
		                    $("span#end").html("더이상 조회할 제품이 없습니다.");
		                   
						}
						
					}// end of else if(json,length > 0)-------------------------
										
				},
				
				error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
				
			});
						
		}); // end of Ajax
		
		
	}// end of function displayAll(start)---------------------------
	
			

</script>

<body>
<!-- 전체 틀 (사이드바 및 제품목록 포함) -->
<div class="container-fluid" id="sidefull">

<!-- 전체 틀-->
	<div class="row" id="div_row">
	
	
	<!-- 사이드구역 및 사이드바 -->
		<div class="col-md-2" id="side_md_2">
		
			<!-- 사이드바 구역 -->
			<div id="sidebar_area">
			<!-- 사이드바 시작 -->
		  	<!-- 대분류 카테고리 그룹핑 -->
			  	<nav class="navbar" id="sidebar_group">
			  	<div>
				  <ul class="navbar-nav all_sidebar">
				  	<li class="nav-item sidebar_title_name">
				      <a class="nav-link big_cat" href="#">ALL</a>
				    </li>
				    <li class="nav-item sidebar_title_name">  
				      <a class="nav-link middle_cat" href="#">running</a>
				    </li>  
				    <li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">walking</a>
				    </li>  
				    <li class="nav-item sidebar_title_name"> 
				      <a class="nav-link middle_cat" href="#">golf</a>
				    </li>  
				    <li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">sandal</a>
				    </li>
				  </ul>  
				</div>
				
				<div >    
				  <ul class="navbar-nav all_sidebar">
					<li class="nav-item sidebar_title_name">	
				      <a class="nav-link big_cat" href="#">MENS</a>
				    </li>  
					<li class="nav-item sidebar_title_name">	
				      <a class="nav-link middle_cat" href="#">running</a>
				    </li>  
					<li class="nav-item sidebar_title_name">	
				      <a class="nav-link middle_cat" href="#">walking</a>
				    </li>  
					<li class="nav-item sidebar_title_name">	
				      <a class="nav-link middle_cat" href="#">golf</a>
				    </li>  
					<li class="nav-item sidebar_name">	
				      <a class="nav-link middle_cat" href="#">sandal</a>
				    </li>  
				  </ul>  
				</div>  
				  
				<div>    
				  <ul class="navbar-nav all_sidebar">
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link big_cat" href="#">LADIES</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">running</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">walking</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">golf</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">sandal</a>
				    </li>  
				  </ul>  
				</div>    
					
				<div>    
				  <ul class="navbar-nav all_sidebar">
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link big_cat" href="#">KIDS</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">running</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">aqua shoes</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat" href="#">sandal</a>
				    </li>  
				  </ul>  
				  
				<hr style="width: 80%; margin-left: 0; text-align: left;">	
				</div>    
				  <!-- 사이즈 추가 -->
				  
				   	
				  
				  
				  
				  
				<!-- 컬러 서클	 -->
				
				<div class="d-flex justify-content-between align-items-center mt-2 mb-2">
		        	<ul class="navbar-nav"  id="sidebar_color">
		        	<li class="color_title">COLOR</li>
		            <li class="colors">
		                <a href="#"><span></span></a>
		                <a href="#"><span></span></a>
		                <a href="#"><span></span></a>
		                <a href="#"><span></span></a>
		            </li>
		            <li class="colors">
		                <a href="#"><span></span></a>
		                <a href="#"><span></span></a>
		                <a href="#"><span></span></a>
		                <a href="#"><span></span></a>
		            </li>
		            </ul>
	        	</div>
				
				
				  <!-- 가격버튼	 -->
				  
				  
				  
				</nav>  
	<!-- 사이드바 끝 -->
			</div>
		</div>
	<!-- 사이드섹션 끝 -->
	
	
	<!-- 우측 제품목록 및 기타 기능 섹션 -->
		<div class="col-md-10">
		
			<!-- select 태그 섹션 -->
			<div>
			<!-- select 태그 섹션 -->
				<div class="exist_select">
					<p>Product List</p>
						<!-- 상품 정렬 select 태그 -->
					<select class="select" name="sortbar">
						<option value="recommend" style="text-align: center;">추천순</option>
						<option value="title-ascending" style="text-align: center;">이름 오름차순</option>
						<option value="title-descending" style="text-align: center;">이름 내림차순</option>
					</select>
					<!-- 상품 정렬 select 태그 끝 -->	
					
			<!-- select 태그 섹션 끝 -->
				</div>
			</div>
			<!-- select 태그 섹션 끝 -->
			
			
			<!-- 제품목록 섹션 -->
				<section class="section-products">
					<div class="container">
						<div class="row" id="displayAll">
							<!-- Single Product -->
							<!-- ajax로 제품 들어올 자리 -->
						</div>
					</div>
				</section>
			<!-- 제품목록 섹션 끝 -->
			
				<div>
			         <p class="text-center">
			            <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: black;"></span> 
			            <span id="totalAllCount">${requestScope.totalAllCount}</span>
			            <span id="countAll">0</span>
			         </p>
      			</div>
			
			</div>
	<!-- 우측 제품목록 및 기타 기능 섹션  -->
	
			
	
		</div>
<!-- 전체 섹션 끝-->


	</div>
<!-- 전체 틀 (사이드바 및 제품목록 포함) 끝 -->
</body>	



    
<jsp:include page="../jaesik/footer.jsp"/>