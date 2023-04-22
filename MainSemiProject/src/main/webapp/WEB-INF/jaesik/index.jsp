<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	String ctxPath = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MOSACOYA</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
																
<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">    

<!-- 구글 폰트 import (메인 로고 사용) -->
<link rel="preconnect" href="https://fonts.googleapis.com">

<style type="text/css">

	@keyframes slidein { 
		from {
			margin-bottom: 100%;
			width: 300%;
		}
	
		to {
			margin-bottom: 0%;
			width: 100%;
		}
	}
	
	nav#header_nav_bar{
		display: flex !important; 
		height: 100%;
		/* animation-duration: 3s;
		animation-name: slidein; */
	}

</style>

<script type="text/javascript">
	
	
	$(document).ready(function(){
		
		$("div.nav-group").hide();
		$("a#main_logo").hide();
		$("div#nav_bar_menu").hide();
		navView(); 	<%-- 네비바까지 스크롤했을때 네비게이션 addClass 함수--%>
		
		// 네비게이션 호버 이벤트
		$("a.header_nav_link").hover(function(e) {
							  $(e.target).css({"color":"#fdd007","font-weight":"bold"});
							  },
							  function(e) {
							  $(e.target).css({"color":"white","font-weight":"normal"});
		}) // end $("a.header_nav_link").hover
		
		
		// 구독버튼 호버이벤트
		$("div#email_submit_button").hover(function(e) {
										$("div#email_submit_button").html("SUBSCRIBE  <i class='fa-solid fa-arrow-right fa-fade' style='color: #000000;'></i>");
										}, function(e) {
										$("div#email_submit_button").html("SUBSCRIBE");
		}) // end $("div#email_submit_button").hover

		
		// 헤더 네비에 mouseover 시 메뉴 보여주는 이벤트
		$("#nav_bar_position > li a.header_nav_link").bind("mouseover", function(e){
			    
			$("div.nav-group").hide().css("opacity","0");
			const index = $("#nav_bar_position > li a.header_nav_link").index($(e.target));
			$("div.nav-group").eq(index).show().css("opacity","1");
			
			$("div#main_header").bind("mouseover", function(e){
				$("div.nav-group").hide().css("opacity","0");
			});
			$("div#body").bind("mouseover", function(e){
				$("div.nav-group").hide().css("opacity","0");
			});
		});
		
		
		
		
	}); // end $(document).ready

	function navView (){
		const header_nav_bar = document.getElementById("header_nav_bar");
		const nav_bar_Height = header_nav_bar.clientHeight;

		document.addEventListener('scroll', onScroll, {passive: true});
		
		function onScroll () {
			const scrollposition = pageYOffset; // 스크롤 위치
			
			if (nav_bar_Height <= scrollposition){ // 만약 헤더높이 <= 스크롤위치라면
				header_nav_bar.classList.add('nav_increment') //  nav_increment 클래스를 네비에 추가
				header_nav_bar.classList.add("animation-init");
				$("a#main_logo").fadeIn();
				$("div#nav_bar_menu").fadeIn();
			}
			else { // 스크롤 안했을 때
				header_nav_bar.classList.remove('nav_increment'); // nav_increment 클래스를 네비에서 제거
				$("a#main_logo").fadeOut();
				$("div#nav_bar_menu").fadeOut();
			}
		}
	} // end function navView ()
	
	
	<%-- 구독하기 클릭했을때 해당 이메일로 쿠폰이 전송되는 함수 --%>
	function goSubscribe(){
		// 이메일 유효성 검사필요 툴팁으로 구현예정
		
	} // end function goSubscribe()
	
	
</script>

</head>

<body> 
<%-- 상단배너 시작 --%>
<header>
	<div id="main_header" class="container-fluid px-0">
		<div class="row text-center mx-5 py-4">
			<div id="header_bar" class="col-lg-4">
				<p><img src="https://cdn.shopify.com/s/files/1/2403/8187/files/PLANE.svg?v=1602619275"/></p>
				<p id="header_bar_font">FREE WORLDWIDE SHIPPING<p>
			</div>
			<div id="header_center" class="col-lg-4">
				<a id="header_home" href="<%= ctxPath %>/index.moc">
					<p id=header_logo class="mb-1">MOSACOYA</p>
					<p id=header_logo_subtitle>SSANGYONG&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;MADE BY TEAM 2&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;SINCE 2023</p>
				</a>
			</div>
			<div id="header_menu" class="col-lg-4">
				<img alt="Republic of Korea" class="mx-3" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" style="background-image: url(https://cdn.flow.io/util/icons/flags-v2/svg/iso_2_flags.svg); background-position: -46px -204px; width: 21px; height:15px; display: inline-block">
				<a href="<%= ctxPath %>/login/login.moc" style="color:black;" class="header-menu__link a1 mx-1" title="Login">Login</a>
				<a href="#"><i class="fa-solid fa-magnifying-glass mx-1" style="color: #000000;"></i></a>
				<a href="<%= ctxPath %>/shop/cartList.moc"><i class="fa-solid fa-cart-shopping mx-1" style="color: #000000;"></i><span id="cart_count">0</span></a>
			</div>
		</div>
	</div>
</header>
<%-- 상단배너 끝 --%>

<%-- Sticky Navbar 시작 --%>
<nav id="header_nav_bar" class="navbar navbar-expand-sm sticky-top container-fluid py-0" style="display: block; height: 60px; background-color: black; color: white; animation-duration: 3s; animation-name: slidein; transition:transform 0.5s; /* 스크롤시 네비바 확대되는 속도 */">
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#header_collapsibleNavbar">
		<span class="navbar-toggler-icon"><i class="fa-solid fa-list fa-xl" style="color: #ffffff;"></i></span>
	</button>	
	
	<div class="collapse navbar-collapse" id="header_collapsibleNavbar">
		<ul id="nav_bar_position" class="navbar-nav">
			<a id="main_logo" href="#">MOSACOYA</a>
			
			<li class="nav-item my-auto px-2">
				<a class="nav-link header_nav_link" href="<%= ctxPath %>/shop/allproduct.moc" >All</a>
				<div id="nav-group_ALL" class="nav-group" data-group="group-collections">
					<div id="prod_view" class="container">
						<ul id="prod_view_ul">
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">All 상품 이미지</p> <%-- p태그 넓이 이미지 250px --%></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
						</ul> 
					</div>
				</div>
			</li>
	
			<li class="nav-item my-auto px-2">
				<a class="nav-link header_nav_link" href="#" >Men</a>
				<div id="nav-group_Men" class="nav-group" data-group="group-collections">
					<div id="prod_view" class="container">
						<ul id="prod_view_ul">
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">Men 상품 이미지</p> <%-- p태그 넓이 이미지 250px --%></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
						</ul> 
					</div>
				</div>
			</li>
			
			<li class="nav-item my-auto px-2">
				<a class="nav-link header_nav_link" href="#">Women</a>
				<div id="nav-group_Women" class="nav-group" data-group="group-collections">
					<div id="prod_view" class="container">
						<ul id="prod_view_ul">
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">Woman 상품 이미지</p> <%-- p태그 넓이 이미지 250px --%></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
						</ul> 
					</div>
				</div>
			</li>
			
			<li class="nav-item my-auto px-2">
				<a class="nav-link header_nav_link" href="#">Kids</a>
				<div id="nav-group_Kids" class="nav-group" data-group="group-collections">
					<div id="prod_view" class="container">
						<ul id="prod_view_ul">
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">Kids 상품 이미지</p> <%-- p태그 넓이 이미지 250px --%></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
						</ul> 
					</div>
				</div>
			</li>
			
			<li class="nav-item my-auto px-2">
				<a class="nav-link header_nav_link" href="#">INFO</a>
				<div id="nav-group_Info" class="nav-group" data-group="group-collections">
					<div id="prod_view" class="container">
						<ul id="prod_view_ul">
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">INFO 상품 이미지</p> <%-- p태그 넓이 이미지 250px --%></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image"><p class="prod_image">상품 이미지</p></a>
								<a href="#" class="prod_text"><p class="prod_text">상품 설명</p></a>
							</li>
						</ul> 
					</div>
				</div>
			</li>
			
		</ul>
	</div>
	<div id="nav_bar_menu" class="col md-3">
		<img alt="Republic of Korea" class="mx-3" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" style="background-image: url(https://cdn.flow.io/util/icons/flags-v2/svg/iso_2_flags.svg); background-position: -46px -204px; width: 21px; height:15px; display: inline-block">
		<a href="#" style="color:white; text-decoration: none;" class="header-menu__link a1 mx-1" title="Login">Login</a>
		<a href="#"><i class="fa-solid fa-magnifying-glass mx-1" style="color: #ffffff;"></i></a>
	</div>
</nav>
<%-- Sticky Navbar 끝 --%>


<%-- carousel 시작 --%>
<div id="body" >
	
	<div id="carouselView1" class="carousel slide carousel-fade" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselView1" data-slide-to="0" class="active"></li>
			<li data-target="#carouselView1" data-slide-to="1"></li>
			<li data-target="#carouselView1" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="<%= ctxPath%>/images/img_g.png" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="<%= ctxPath%>/images/img_b.png" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="<%= ctxPath%>/images/img_r.png" class="d-block w-100" alt="...">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselView1" role="button" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="carousel-control-next" href="#carouselView1" role="button" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	
	
	<%-- 두번째 carousel --%>
	<div id="carouselView2" class="carousel slide carousel-fade" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselView2" data-slide-to="0" class="active"></li>
			<li data-target="#carouselView2" data-slide-to="1"></li>
			<li data-target="#carouselView2" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="https://image.nbkorea.com/NBRB_Site/20230306/NB20230306093539119001.jpg" class="d-block w-100" alt="...">
				<!-- 캐러셀 내부의 블럭 (참조 글씨 넣기)  
				<div class="carousel-caption d-none d-md-block">
					<h5>아이유</h5>
					<p>아이유 내용</p>
				</div> 
				"https://image.nbkorea.com/NBRB_PC/event/imc/nbpantsfit/img_top.jpg"
				-->
			</div>
			<div class="carousel-item">
				<img src="https://image.nbkorea.com/NBRB_Site/20230406/NB20230406085126936001.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="https://image.nbkorea.com/NBRB_Site/20230308/NB20230308105355932001.jpg" class="d-block w-100" alt="...">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselView2" role="button" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a class="carousel-control-next" href="#carouselView2" role="button" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	
	<img src="https://image.nbkorea.com/NBRB_Collection/20230413/NB20230413130306777001.jpg	" class="d-block w-100 test1" alt="...">
	
</div>
<%-- carousel 끝 --%>

<%-- footer 시작 --%>
<footer id="footer" class="container-fluid px-0">
	<div id="footer_top">
		<div id="footer_top_container" class="container py-4 px-0">
			<div id="footer_title">JOIN THE<br>FAMILY</div>
			<div id="footer_content">Enjoy 10% off your first online purchase and<br>stay up to date on all things MOSCOT.</div>
			<div id="footer_email">
				<input id="footer_email_input" type="text" placeholder="Enter email">
				<div id="email_submit_button" onclick="goSubscribe()" class="button">SUBSCRIBE</div>
				<span style="font-size: 10pt; color: white;">See our <a style="color: white; text-decoration: underline; letter-spacing: 1px;" href="https://privacy.moscot.com/">Privacy Policy</a></span>
			</div> 
		</div>
	</div>
	
	<div id="footer_center">
		<div id="footer_center_container" class="row">
			<div id="footer_center_left" class="col-md-6 px-5 pt-4">
				<p id="foot_info"> 
					<a style="color:black; font-weight: bold; text-decoration-line: none;" href="https://www.nbkorea.com/support/terms.action?tabCode=PP">개인정보 처리방침</a> / 이용약관 / (주)이랜드월드패션사업부 <br>
					서울특별시 금천구 가산디지털1로 159 이랜드월드<br>
					온라인 고객센터 : 1566-0086<br>
					AS/오프라인 고객센터 : 080-999-0456<br>
					대표 이메일 : abcd1234@naver.com<br>
					호스팅 서비스 제공자 : (주)라드씨엔에스<br><br>
					대표이사 : 최운식   사업자등록번호 : 113-85-19030<br>
					통신판매업신고 : 금천구청 제 2005-01053<br>
					개인정보보호책임자 : 최운식 
				</p>
			</div>
			<div id="footer_center_right" class="col-md-6">
				<div id="foot_complain">
					<div id="complain_title">ASK A MOSCOT FRAME FIT SPECIALIST</div>
					<div id="complain_content">
						<p id="complain_content_p">
							Whether you're a MOSCOT collector or visiting for<br>
							the very first time, we're here to assist!
						</p>
						<p style="display: flex; justify-content: space-around;"class="space-around">
							<a class="complain_img" href="#">
								<i class="fa-solid fa-phone fa-2xl" style="color: #000000;"></i>
							</a>
							<a class="complain_img" href="#">
								<i class="fa-regular fa-envelope fa-2xl" style="color: #000000;"></i>
							</a>
							<a class="complain_img" href="#">
								<i class="fa-regular fa-comment fa-2xl" style="color: #000000;"></i>
							</a>
						</p>
						<p style="display: flex; justify-content: space-around;"class="space-around">
							<a class="complain_text" href="#"><span style="font-size: 8pt; letter-spacing: 1px;">(+82) MOSACOYA</span></a> 
							<a class="complain_text" href="#"><span style="font-size: 8pt; letter-spacing: 1px;">support@mosacoya.com</span></a>
							<a class="complain_text" href="#"><span style="font-size: 8pt; letter-spacing: 1px;">Chat With Us</span></a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="footer_bottom">
		<div id="foot_social">
			<ul id="social_list">
				<li class="social_items"><a href="#"><i class="fa-brands fa-facebook-f fa-xl" style="color: #000000;"></i></a></li>
				<li class="social_items"><a href="#"><i class="fa-brands fa-tiktok fa-xl" style="color: #000000;"></i></a></li>
				<li class="social_items"><a href="#"><i class="fa-brands fa-instagram fa-xl" style="color: #000000;"></i></a></li>
				<li class="social_items"><a href="#"><i class="fa-brands fa-youtube fa-xl" style="color: #000000;"></i></a></li>
			</ul>
		</div>
	</div>
	<div id="footer_bottom2">
		<div id="foot_last">
			<ul id="foot_bottom_list">
				<li class="foot_bottom_list"><p>&copy; 2023 MOSACOYA</p></li>
				<li class="foot_bottom_list"><p>Made By</p></li>
				<li class="foot_bottom_list"><p>Oh Yun Hwan</p></li>
				<li class="foot_bottom_list"><p>Seo Su Kyung</p></li>
				<li class="foot_bottom_list"><p>Seo Jae Sik</p></li>
				<li class="foot_bottom_list"><p>Shin Jun Ha</p></li>
				<li class="foot_bottom_list"><p>Yong Su Jin</p></li>
			</ul>
		</div>
	</div>
</footer>
<%-- footer 끝 --%> 


</body>
</html>