<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String ctxPath = request.getContextPath(); 
%>

<style type="text/css">

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

</style>

<nav id="nav_bar_circle" class="navbar navbar-expand-sm container py-0 mt-3" style="display: block; height: 100px;">
	<ul class="navbar-nav justify-content-center col-md-12">
		<li class="nav-item my-auto px-2 col-md-2">
			<a class="nav-link h4 mx-auto" href="<%= ctxPath%>/shop/cartList.moc" data-transition="fade" style="font-size: 12pt; color: black;">장바구니</a>
		</li>
		<li class="nav-item my-auto px-2 col-md-3">
			<a class="nav-link h4 mx-auto" href="<%= ctxPath%>/shop/delivery.moc" data-transition="fade"style="font-size: 12pt; color: black;">배송정보</a>
		</li>
		<li class="nav-item my-auto px-2 col-md-2">
			<a class="nav-link h4 mx-auto" href="<%= ctxPath%>/shop/payment.moc" data-transition="fade" style="font-size: 12pt; color: black;">결제하기</a>
		</li>
	</ul>
	<ul class="navbar-nav justify-content-center col-md-12" width="100">
    	<li class="nav-item">
	      	<div class="mx-auto">
	      		<a href="<%= ctxPath%>/shop/cartList.moc" data-transition="fade"><span id="navbar_page" class="rounded-circle"></span></a>
	      	</div>
		</li>
		<li class="nav-item mx-n5">
	      	<div class="mx-auto">
				<hr style="border: solid 1px white; width: 200px;"> 
	      	</div>
		</li>
		<li class="nav-item">
	      	<div class="mx-auto">
	      		<a href="<%= ctxPath%>/shop/delivery.moc" data-transition="fade"><span id="navbar_page" class="rounded-circle"></span></a>
	      	</div>
		</li>
		<li class="nav-item mx-n5">
	      	<div class="mx-auto">
				<hr style="border: solid 1px white; width: 200px;"> 
	      	</div>
		</li>
		<li class="nav-item">
	      	<div class="mx-auto">
	      	<a href="<%= ctxPath%>/shop/payment.moc" data-transition="fade"><span id="navbar_page" class="rounded-circle" style="background-color: white;"></span></a>
	      	</div>
		</li>
	</ul>
	</nav>
