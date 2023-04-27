<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
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

<!-- 페이지로고 -->
<link rel="icon" href="<%= ctxPath%>/images/KakaoTalk_20230424_170300653.png">
 
<script type="text/javascript">
	
	
	$(document).ready(function(){
		
		$('[data-toggle="popover_complain"]').popover();
		
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
		
		
		// 헤더 메뉴 호버 이벤트
		$("a.header_menu").hover(function(e) {
						  if( $(e.target).children().hasClass("fa-cart-shopping") == true ){
							  $(e.target).css("opacity","1");
							  $("i.fa-cart-shopping").addClass("fa-bounce");
						  }
						  else{
							  $(e.target).css("opacity","0.5");
						  }
						  },
						  function(e) {
						  if( $(e.target).children().hasClass("fa-cart-shopping") == true ){
							  $("i.fa-cart-shopping").removeClass("fa-bounce");
							  $(e.target).css("opacity","1");
						  }
						  else{
							  $(e.target).css("opacity","1");
						  }
		}) // end $("a.header_menu").hover
		
		
		// 푸터 고객센터 메뉴 호버 이벤트
		$("a.complain_menu").hover(function(e) {
								  $(e.target).parent().css("opacity","0.5");
								  },
								  function(e) {
								  $(e.target).parent().css("opacity","1");
		}) // end $("a.header_menu").hover
		
		 
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

			$("nav#header_nav_bar").bind("mouseleave", function(e){
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
		
		const user_Email_Val = $("input#footer_email_input").val().trim();
		if (user_Email_Val == ""){
			alert("이메일 입력하세요.");
			return;
		}
		
		const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
		const bool = regExp.test(user_Email_Val);
		
		if (!bool) {
			alert("올바른 이메일을 입력하세요");
			return;
		}
		
		const frm = document.submit_email;
		frm.action = "<%= ctxPath%>/main/submitCoupon.moc";
		frm.email.value = user_Email_Val;
		frm.method = "POST";
		frm.submit();
		
	} // end function goSubscribe()
	
	function send_message() {
		
		const userid = $("input#userid").val().trim();
		const title = $("input#board_title").val().trim();
		const content = $("textarea#board_content").val().trim();
	
		if ( userid == "" ) {
			alert("아이디를 입력하세요");
			$("input#userid").focus();
			return;
		}
		
		if ( title == "" ) {
			alert("제목을 입력하세요");
			$("input#board_title").focus();
			return;
		}
		
		if ( content == "" ) {
			alert("내용을 입력하세요");
			$("textarea#board_content").focus();
			return;
		}
		
		const frm = document.customer_content;
		frm.action = "<%= ctxPath%>/main/submitComplain.moc";
		frm.method = "POST"; 
		frm.submit();
		
	} // end function send_message
	
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
				<a id="header_home" href="<%= ctxPath%>/index.moc">
					<p id=header_logo class="mb-1">MOSACOYA</p>
					<p id=header_logo_subtitle>SSANGYONG&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;MADE BY TEAM 2&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;SINCE 2023</p>
				</a>
			</div>
			<div id="header_menu" class="col-lg-4">
				<img alt="Republic of Korea" class="mx-3" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" style="background-image: url(https://cdn.flow.io/util/icons/flags-v2/svg/iso_2_flags.svg); background-position: -46px -204px; width: 21px; height:15px; display: inline-block">
				<c:if test="${empty sessionScope.loginuser}">
					<a href="<%= ctxPath%>/login/login.moc" style="color:black; text-decoration: none;" class="header-menu__link a1 mx-1 header_menu" title="Login">Login</a>
				</c:if>
				<c:if test="${not empty sessionScope.loginuser}">
					<a href="<%= ctxPath%>/member/myaccount.moc" style="color:black; text-decoration: none;" class="header-menu__link a1 mx-1 header_menu" title="Login">My Account</a>
				</c:if>
				<a href="#" class="header_menu" ><i class="fa-solid fa-magnifying-glass mx-1" style="color: #000000;"></i></a>
				<c:if test="${empty sessionScope.loginuser}">
					<a href="<%= ctxPath%>/shop/cartList.moc" style="display: inline-block; width: auto;" class="header_menu"><i class="fa-solid fa-cart-shopping mx-1" style="color: #000000;"></i><span id="cart_count">0</span></a>
				</c:if>
				<c:if test="${not empty sessionScope.loginuser}">
					<a href="<%= ctxPath%>/shop/cartList.moc" style="display: inline-block; width: auto;" class="header_menu"><i class="fa-solid fa-cart-shopping mx-1" style="color: #000000;"></i><span id="cart_count">${sessionScope.loginuser.cartCount}</span></a>
				</c:if>
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
			<a id="main_logo" href="<%= ctxPath%>/index.moc">MOSACOYA</a>
			
			<li class="nav-item my-auto px-2">
				<a class="nav-link header_nav_link" href="<%= ctxPath%>/shop/allproduct.moc" >All</a>
				<div id="nav-group_ALL" class="nav-group" data-group="group-collections">
					<div id="prod_view" class="container">
						<ul id="prod_view_ul">
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/all1.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-danger">BEST</span></h2>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/all2.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-danger">BEST</span></h2>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/all3.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-danger">BEST</span></h2>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
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
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/men1.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-danger">BEST</span></h2>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/men2.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/men3.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
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
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/women1.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-danger">BEST</span></h2>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/women2.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/women3.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
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
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/kids1.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-danger">BEST</span></h2>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/kids2.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
							<li class="prod_view_list">
								<a href="#" class="prod_image" style="width: 100%;"><img src="<%= ctxPath%>/images/kids3.jpg" style="width: 100%; "/></a>
								<h2 style="display: inline-block;"><span class="badge badge-primary">NEW</span></h2>
							</li>
						</ul> 
					</div>
				</div>
			</li>
			
			<li class="nav-item my-auto px-2">
				<a class="nav-link header_nav_link" href="#">INFO</a>
			</li>
			
			<c:if test="${sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin'}">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle menufont_size header_nav_link" style="color: white;" href="#" id="navbarDropdown" data-toggle="dropdown"> 
			           관리자전용 
					</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item text-body" href="<%= ctxPath %>/member/admin/memberList.moc">회원목록</a>
						<a class="dropdown-item text-body" href="<%= ctxPath %>/shop/admin/productRegister.moc">제품등록</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item text-body" href="#">전체주문내역</a>
					</div>
				</li>
			</c:if>
			
		</ul>
	</div>
	<div id="nav_bar_menu" class="col md-3">
		<img alt="Republic of Korea" class="mx-3" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" style="background-image: url(https://cdn.flow.io/util/icons/flags-v2/svg/iso_2_flags.svg); background-position: -46px -204px; width: 21px; height:15px; display: inline-block">
		<c:if test="${empty sessionScope.loginuser}">
			<a href="<%= ctxPath%>/login/login.moc" style="color:white; text-decoration: none;" class="header-menu__link a1 mx-1 header_menu" title="Login">Login</a>
		</c:if>
		<c:if test="${not empty sessionScope.loginuser}">
			<a href="<%= ctxPath%>/member/myaccount.moc" style="color:white; text-decoration: none;" class="header-menu__link a1 mx-1 header_menu" title="Login">My Account</a>
		</c:if>
		<a href="#" class="header_menu"><i class="fa-solid fa-magnifying-glass mx-1" style="color: #ffffff;"></i></a>
	</div>
</nav>
<%-- Sticky Navbar 끝 --%>
