<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String ctxPath = request.getContextPath(); 
%>
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300;400;500;600;700&display=swap');
</style>

<style type="text/css">
 	nav#nav_bar_circle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight: light;
		font-weight: 300;
	}
	span#navbar_page {
		display: inline-block;
		width: 28px;
		height: 28px;
		margin: 0 auto;
		border: solid 3px white;
		position: relative;
		top: 5px;
		background-color: #fdd007;
		box-shadow: 1px 1px 1px 1px #cccccc;
	}
	hr {
		box-shadow: 1px 1px 1px 1px #cccccc;
	}
	#nav_bar_circle > ul > li > label > a > i {
		color: #333333;
		text-shadow: 1px 1px 1px #cccccc;
	}
	#nav_bar_circle > ul > li > label > a > i:hover {
		color: #fdd007;
	}
	
</style>

<nav id="nav_bar_circle" class="navbar navbar-expand-sm container py-0 mt-3" style="display: block; height: 100px;">
	<ul class="navbar-nav justify-content-center col-md-12">
		<li class="nav-item my-auto">
		  <label for="navbar_page">
			<a class="nav_bar_circle nav-link h4 mx-auto" id="btnCart" href="<%= ctxPath%>/shop/cartList.moc" data-transition="fade"><i class="fa-sharp fa-solid fa-cart-shopping fa-lg"></i></a>
	      	<div id="navbar_page_cartList" class="mx-auto text-center">
	      	  <span id="navbar_page" class="rounded-circle"><a class="nav-link h4 mx-auto" href="<%= ctxPath%>/shop/cartList.moc" data-transition="fade"></a></span>
	      	</div>
		  </label>
		</li>
		<li class="nav-item">
	      	<div class="mx-n4" style="margin-top: 40px;">
				<hr style="border: solid 1px white; width: 240px;"> 
	      	</div>
		</li>
		<li class="nav-item my-auto">
		  <label for="navbar_page">
			<a class="nav_bar_circle nav-link h4 mx-auto" type="button" id="btnOrder" data-transition="fade"><i class="fa-sharp fa-solid fa-truck fa-lg"></i></a>
	      	<div id="navbar_page_delivery" class="mx-auto text-center">
	      	  <span id="navbar_page" class="rounded-circle" style="background-color: white;"><a class="nav-link h4 mx-auto" type="button" id="btnOrder" data-transition="fade"></a></span>
	      	</div>
		  </label>
		</li>
		<li class="nav-item">
	      	<div class="mx-n4" style="margin-top: 40px;">
				<hr style="border: solid 1px white; width: 240px;"> 
	      	</div>
		</li>
		<li class="nav-item my-auto">
		  <label for="navbar_page">
			<a class="nav_bar_circle nav-link h4 mx-auto" type="button" id="btnPay" data-transition="fade"><i class="fa-solid fa-credit-card fa-lg"></i></a>
	      	<div id="navbar_page_payment" class="mx-auto text-center">
	      	  <span id="navbar_page" class="rounded-circle" style="background-color: white;"><a class="nav-link h4 mx-auto" type="button" id="btnPay" data-transition="fade"></a></span>
	      	</div>
		  </label>
	</ul>
</nav>
