<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
<jsp:include page="../jaesik/header.jsp"/>

<style type="text/css">

	
</style>

<script type="text/javascript">

	$(document).ready(function() {
	 	
		$("span#totalAllCount").hide();
		$("span#countAll").hide(); 
	});

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
				      <a class="nav-link middle_cat" style="color: black;" href="#">sandal</a>
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
					<c:if test="${not empty requestScope.prodList}">
						<h4 style="margin-bottom: 50px; font-weight: bold">"${requestScope.search_word}" 에 대한 ${requestScope.searchResult}개의 검색결과</h4>
					</c:if>
					<div class="container">
						<div id="displayAll" style="padding: 0;"> <%-- 이 안에 Ajax가 들어갈 것이다. --%>
							<!-- Single Product -->
							<div style='display:flex; flex-wrap: wrap;'>
							
								<c:if test="${empty requestScope.prodList}">
									<h3>검색된 결과가 존재하지 않습니다.</h3>
								</c:if>
								
								<c:if test="${not empty requestScope.prodList}"> 
									<c:forEach var="pvo" items="${requestScope.prodList}">
										<div class='col-md-6 col-lg-4 col-xl-4' style='margin= 0 auto; padding=0px'>
											<div id='product-1' class='single-product' style='display: flex; justify-content: center; align-items: center;'>
												<div class='part-1'>
													<img alt='제품 준비 중입니다.' style='width:inherit; height:inherit; text-align:center;' src="${pvo.product_image}" href='/MainSemiProject/shop/product.moc'>
													<ul>
														<li><a href='/MainSemiProject/shop/cartList.moc'><i class='fas fa-shopping-cart'></i></a></li>
													</ul>
												</div>
											</div>
											<div class='part-2' style='text-align:center;'>
												<h3 class='product-title'>${pvo.product_no}</h3>
												<h3 class='product-title'>${pvo.product_name}</h3>
												<h4 class='product-price'><i class='fa fa-krw' style='font-size:14px'>&nbsp;<fmt:formatNumber value="${pvo.product_price}" pattern="###,###" /></i></h4>
											</div>
										</div>
									</c:forEach>
								</c:if>
							
							</div> 
							
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