<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../jaesik/header.jsp"/>

<script type="text/javascript">

	let start = 1;
	
	let lenAll = 9; // HIT 상품 "스크롤" 할 때 보여줄 상품의 개수(단위) 크기
	
	let category = 00;
	

	$(document).ready(function() {
	 	
		$("span#totalAllCount").hide();
		$("span#countAll").hide(); 
		
	   displayAll(start); 
	  // === scroll 이벤트 발생시키기 시작 === //
		$(window).scroll(function() {

            if($(window).scrollTop() +1 >= $(document).height() - $(window).height() ) {
	            $("span#totalAllCount").text();
	            $("span#countAll").text();
	            
	            if( $("span#totalAllCount").text() != $("span#countAll").text() ) {
		            start += lenAll;
		            displayAll(start); 
	            }
	         }
            if( $(window).scrollTop() == 0 ) {
            	$("div#displayAll").empty();
            	$("span#end").empty();
            	$("span#countAll").text(0);
            	
            	start = 1;
            	displayAll(start);
            }
		});	//end of $(window).scroll(function()--------------------------- // === scroll 이벤트 발생시키기 끝 === //
		
				
		/* 새로 추가한 이벤트, + html 사이드바 카테고리 부분에도 data-category 추가해놨음  */		
		$(".category-link").click(function(event) {
		    event.preventDefault(); // 기본 동작 방지
		    category = $(this).data("category"); // data-category 속성 값 가져오기
		    console.log("선택한 카테고리: " + category);
		    // 여기서 가져온 category 변수를 ajax 요청의 data 객체에 추가하여 서버에 전송하면 됩니다.

		    $("div#displayAll").empty();
		    displayAll(start);
		    
		  });		
		
		
	}); // end of $(document).ready(function() -----------------
			
	// 모든 제품에 대한 정보를 DB에서 가져와 뿌려주는 함수
	function displayAll(start) {
       
		$.ajax({
			url:"<%= request.getContextPath()%>/shop/mallDisplayJSON.moc",
			// 클라이언트(웹브라우저)가 서버에 데이터를 요청할 때 사용하는 URL (HTTP 요청을 보낼 서버의 주소) 사용자가 지정한 URL경로에 데이터를 전송하고 받아온다. , 접속할 페이지 주소
			type:"GET",
			data:{"start":start,
				  "len":lenAll,
				  "category":category
				  },
			dataType:"json",
			async:true,
			success:function(json){ 
			//	console.log("확인용 json => " + json);
			//	console.log("json 의 타입 => " + typeof json);
			//	console.log("확인용 json => " + JSON.stringify(json));
			//	console.log("JSON.stringify(json) 의 타입 => " + typeof JSON.stringify(json));
			
			if(start == 1) {
				$("div#displayAll").empty();
				$("span#totalAllCount").text("0");
				$("span#end").empty();
				
			}
			
			
			let html = "";
				
				if(start == "1" && json.length == 0) {
				    html += "현재 상품 준비중...";
					$("div#displayAll").html(html); // id가 displayAll인 div에 값을 뿌려준다.
					
				}
				else if(json.length > 0) {
					
					$.each(json, function(index, item) {
					    
						if(index%3 == 0) {
							html += "<div style='display:flex'>";		
						}
						
						html += "<div class='col-md-6 col-lg-4 col-xl-4' style='margin= 0 auto; padding=0px'>"+
									"<div id='product-1' class='single-product' style='display: flex; justify-content: center; align-items: center;'>"+
										"<div class='part-1'>"+
											"<a href='/MainSemiProject/shop/product.moc' style='width:inherit; height:inherit; text-align:center;'><img alt='제품 준비 중입니다.' style='width:inherit; height:inherit; text-align:center;' src="+item.product_image+"></a>"+
											"<ul>"+
												"<li><a href='/product.moc?product_name="+item.product_name+"&product_color="+item.product_color+"'><i class='fas fa-shopping-cart'></i></a></li>"+
											"</ul>"+
										"</div>"+
									"</div>"+
										"<div class='part-2' style='text-align:center;'>"+
											"<h3 class='product-title'>"+item.product_name+"</h3>"+
											"<h4 class='product-price'><i class='fa fa-krw' style='font-size:14px'>&nbsp;"+(item.product_price).toLocaleString('en')+"</i></h4>"+
										"</div>"+
								"</div>";
						
						if((index+1)%3 == 0) {
							html += "</div>";		
						}
						
						$("div#displayAll")
						
					});// end of $.each(json, function(index, item)-------------------
				
					// 전체상품 상품 결과물 출력하기
					$("div#displayAll").append(html);		
					
					// $("span#countHIT") 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
					$("span#countAll").text( Number($("span#countAll").text()) + json.length ); // span 태그는 value값이 없다. 그래서 text로 해준다.(아래 태그를 보면 이해할 수 있다.)
																		
					// 스크롤을 계속해서 countHIT 값과 totalHITCount 값이 일치하는 경우 
					if( $("span#totalAllCount").text() == $("span#countAll").text() ) {
					    $("span#end").html("더이상 조회할 제품이 없습니다.");
					    $("span#countAll").text(0);
					}
				
				}// end of else if(json,length > 0)-------------------------
						
			},
			error: function(request, status, error){ // 통신 실패시 실행할 함수
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of $.ajax --------------
		        
	}// end of function displayAll(start)------------------------------------
			
		
		
		
		
		
		
	

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
				      <a class="nav-link big_cat category-link" data-category="00" href="#">ALL</a>
				    </li>
				    <li class="nav-item sidebar_title_name">  
				      <a class="nav-link middle_cat category-link" data-category="001" href="#">running</a>
				    </li>  
				    <li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="002" href="#">walking</a>
				    </li>  
				    <li class="nav-item sidebar_title_name"> 
				      <a class="nav-link middle_cat category-link" data-category="003" href="#">golf</a>
				    </li>  
				    <li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="004" href="#">sandal</a>

				    </li>
				    <li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="3002" href="#">aqua shoes</a>

				    </li>
				  </ul>  
				</div>
				
				<div >    
				  <ul class="navbar-nav all_sidebar">
					<li class="nav-item sidebar_title_name">	
				      <a class="nav-link big_cat category-link" data-category="100" href="#">MENS</a>
				    </li>  
					<li class="nav-item sidebar_title_name">	
				      <a class="nav-link middle_cat category-link" data-category="1001" href="#">running</a>
				    </li>  
					<li class="nav-item sidebar_title_name">	
				      <a class="nav-link middle_cat category-link" data-category="1002" href="#">walking</a>
				    </li>  
					<li class="nav-item sidebar_title_name">	
				      <a class="nav-link middle_cat category-link" data-category="1003" href="#">golf</a>
				    </li>  
					<li class="nav-item sidebar_name">	
				      <a class="nav-link middle_cat category-link" data-category="1004" style="color: black;" href="#">sandal</a>
				    </li>  
				  </ul>  
				</div>  
				  
				<div>    
				  <ul class="navbar-nav all_sidebar">
					<li class="nav-item sidebar_title_name">

				      <a class="nav-link big_cat category-link" data-category="200" href="#">WOMEN</a>

				      <a class="nav-link big_cat category-link" data-category="200" href="#">LADIES</a>

				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="2001" href="#">running</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="2002" href="#">walking</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="2003" href="#">golf</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="2004" href="#">sandal</a>
				    </li>  
				  </ul>  
				</div>    
					
				<div>    
				  <ul class="navbar-nav all_sidebar">
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link big_cat category-link" data-category="300" href="#">KIDS</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="3001" href="#">running</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_cat category-link" data-category="3002" href="#">aqua shoes</a>
				    </li>  
					<li class="nav-item sidebar_title_name">
				      <a class="nav-link middle_ca category-link" style="color: black;" data-category="3003" href="#">sandal</a>
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
		            </li>
		            <li class="colors">
		                <a href="#"><span></span></a>
		                <a href="#"><span></span></a>
		                <a href="#"><span></span></a>
		            </li>
		            <li class="colors">
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
				<div class="exist_select" id="product_order_list">
					<!-- 상품 정렬 select 태그 -->
					<div style="padding-top: 42px; padding-right: 20px; padding-bottom: 0px; text-align: right;">
						<a href="javascript:recentlist();" style="color: black;">최신순</a>&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp
						<a href="javascript:pricelist();" style="color: black;">낮은가격</a>&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp
						<a href="javascript:pricelistdesc();" style="color: black;">높은가격</a> 
						<br>
						<br>
						<hr>
					</div>
					<!-- 상품 정렬 select 태그 끝 -->
					
						
					
			<!-- select 태그 섹션 끝 -->
				</div>
			</div>
			<!-- select 태그 섹션 끝 -->
			
			
			<!-- 제품목록 섹션 -->
				<div class="section-products">
					<div class="container">
						<div id="displayAll" style="padding: 0;"> <%-- 이 안에 Ajax가 들어갈 것이다. --%>
							<!-- Single Product -->
						<%-- 	
			 		 		<div class="col-md-6 col-lg-4 col-xl-4">
								<div id="product-1" class="single-product">
									<div class="part-1">
										<img alt="제품 준비중" style="width:inherit; height:inherit;" src="https://image.nbkorea.com/NBRB_Product/20230321/NB20230321153529285001.jpg">
									</div>
									<div class="part-2">
										<h3 class="product-title">Here Product Title</h3>
										<h4 class="product-price">$49.99</h4>
									</div>
								</div>   
							</div>  
						--%>   
							<!-- ajax로 제품 들어올 자리 -->
						</div>
					</div>
				</div>
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