<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="./header.jsp"/>

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
					<p>Product List
						<!-- 상품 정렬 select 태그 -->
					<select class="select" name="sortbar">
						<option value="recommend" style="text-align: center;">추천순</option>
						<option value="title-ascending" style="text-align: center;">이름 오름차순</option>
						<option value="title-descending" style="text-align: center;">이름 내림차순</option>
					</select>
					<!-- 상품 정렬 select 태그 끝 -->	
					</p>
					
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
										<ul>
											<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
											<li><a href="#"><i class="fas fa-heart"></i></a></li>
											<li><a href="#"><i class="fas fa-plus"></i></a></li>
											<li><a href="#"><i class="fas fa-expand"></i></a></li>
										</ul>
									</div>
									<div class="part-2">
										<h3 class="product-title">Here Product Title</h3>
										<h4 class="product-price">$49.99</h4>
									</div>
								</div>
							</div>
							<!-- Single Product -->
							<div class="col-md-6 col-lg-4 col-xl-4">
								<div id="product-1" class="single-product">
									<div class="part-1">
										<img alt="제품" src="https://cdn.shopify.com/s/files/1/2403/8187/products/lemtosh-color-tortoise-pos-2_600x.jpg?v=1679595410%22moscot.com/collections/optical">
										<ul>
											<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
											<li><a href="#"><i class="fas fa-heart"></i></a></li>
											<li><a href="#"><i class="fas fa-plus"></i></a></li>
											<li><a href="#"><i class="fas fa-expand"></i></a></li>
										</ul>
									</div>
									<div class="part-2">
										<h3 class="product-title">Here Product Title</h3>
										<h4 class="product-price">$49.99</h4>
									</div>
								</div>
							</div>
							<!-- Single Product -->
							<div class="col-md-6 col-lg-4 col-xl-4">
								<div id="product-2" class="single-product">
									<div class="part-1">
										<span class="discount">15% off</span>
										<ul>
											<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
											<li><a href="#"><i class="fas fa-heart"></i></a></li>
											<li><a href="#"><i class="fas fa-plus"></i></a></li>
											<li><a href="#"><i class="fas fa-expand"></i></a></li>
										</ul>
									</div>
									<div class="part-2">
										<h3 class="product-title">Here Product Title</h3>
										<h4 class="product-price">$49.99</h4>
									</div>
								</div>
							</div>
								<!-- Single Product -->
								<div class="col-md-6 col-lg-4 col-xl-4">
										<div id="product-3" class="single-product">
												<div class="part-1">
														<ul>
																<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
																<li><a href="#"><i class="fas fa-heart"></i></a></li>
																<li><a href="#"><i class="fas fa-plus"></i></a></li>
																<li><a href="#"><i class="fas fa-expand"></i></a></li>
														</ul>
												</div>
												<div class="part-2">
														<h3 class="product-title">Here Product Title</h3>
														<h4 class="product-old-price">$79.99</h4>
														<h4 class="product-price">$49.99</h4>
												</div>
										</div>
								</div>
								<!-- Single Product -->
								<div class="col-md-6 col-lg-4 col-xl-3">
										<div id="product-4" class="single-product">
												<div class="part-1">
														<span class="new">new</span>
														<ul>
																<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
																<li><a href="#"><i class="fas fa-heart"></i></a></li>
																<li><a href="#"><i class="fas fa-plus"></i></a></li>
																<li><a href="#"><i class="fas fa-expand"></i></a></li>
														</ul>
												</div>
												<div class="part-2">
														<h3 class="product-title">Here Product Title</h3>
														<h4 class="product-price">$49.99</h4>
												</div>
										</div>
								</div>
								<!-- Single Product -->
								<div class="col-md-6 col-lg-4 col-xl-3">
										<div id="product-1" class="single-product">
												<div class="part-1">
														<ul>
																<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
																<li><a href="#"><i class="fas fa-heart"></i></a></li>
																<li><a href="#"><i class="fas fa-plus"></i></a></li>
																<li><a href="#"><i class="fas fa-expand"></i></a></li>
														</ul>
												</div>
												<div class="part-2">
														<h3 class="product-title">Here Product Title</h3>
														<h4 class="product-old-price">$79.99</h4>
														<h4 class="product-price">$49.99</h4>
												</div>
										</div>
								</div>
								<!-- Single Product -->
								<div class="col-md-6 col-lg-4 col-xl-3">
										<div id="product-2" class="single-product">
												<div class="part-1">
														<span class="discount">15% off</span>
														<ul>
																<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
																<li><a href="#"><i class="fas fa-heart"></i></a></li>
																<li><a href="#"><i class="fas fa-plus"></i></a></li>
																<li><a href="#"><i class="fas fa-expand"></i></a></li>
														</ul>
												</div>
												<div class="part-2">
														<h3 class="product-title">Here Product Title</h3>
														<h4 class="product-price">$49.99</h4>
												</div>
										</div>
								</div>
								<!-- Single Product -->
								<div class="col-md-6 col-lg-4 col-xl-3">
										<div id="product-3" class="single-product">
												<div class="part-1">
														<ul>
																<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
																<li><a href="#"><i class="fas fa-heart"></i></a></li>
																<li><a href="#"><i class="fas fa-plus"></i></a></li>
																<li><a href="#"><i class="fas fa-expand"></i></a></li>
														</ul>
												</div>
												<div class="part-2">
														<h3 class="product-title">Here Product Title</h3>
														<h4 class="product-old-price">$79.99</h4>
														<h4 class="product-price">$49.99</h4>
												</div>
										</div>
								</div>
								<!-- Single Product -->
								<div class="col-md-6 col-lg-4 col-xl-3">
										<div id="product-4" class="single-product">
												<div class="part-1">
														<span class="new">new</span>
														<ul>
																<li><a href="#"><i class="fas fa-shopping-cart"></i></a></li>
																<li><a href="#"><i class="fas fa-heart"></i></a></li>
																<li><a href="#"><i class="fas fa-plus"></i></a></li>
																<li><a href="#"><i class="fas fa-expand"></i></a></li>
														</ul>
												</div>
												<div class="part-2">
														<h3 class="product-title">Here Product Title</h3>
														<h4 class="product-price">$49.99</h4>
												</div>
										</div>
								</div>
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



    
<jsp:include page="./Newfooter.jsp"/>