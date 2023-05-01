<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="../jaesik/header.jsp"/>

<style type="text/css">


	
</style>

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
				<section class="section-products">
					<div class="container">
						<div class="row">
							<!-- Single Product -->
							<div class="col-md-6 col-lg-4 col-xl-4">
								<div id="product-1" class="single-product">
									<div class="part-1">
										<img alt="제품" src="https://cdn.shopify.com/s/files/1/2403/8187/products/lemtosh-color-tortoise-pos-2_600x.jpg?v=1679595410%22moscot.com/collections/optical">
									</div>
									<div class="part-2">
										<h3 class="product-title">Here Product Title</h3>
										<h4 class="product-price">$49.99</h4>
									</div>
								</div>
							</div>
							<!-- Single Product -->
							
						</div>
					</div>
				</section>
				
			<!-- 제품목록 섹션 끝 -->
			</div>
	<!-- 우측 제품목록 및 기타 기능 섹션  -->
	
			
	
		</div>
<!-- 전체 섹션 끝-->


	</div>
<!-- 전체 틀 (사이드바 및 제품목록 포함) 끝 -->
</body>	



    
<jsp:include page="../jaesik/footer.jsp"/>