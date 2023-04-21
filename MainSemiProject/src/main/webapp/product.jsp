<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
%>
    
<jsp:include page="/header.jsp"/>

<style type="text/css">

	div.container{
		font: 13px courier, arial, sans-serif;
	}
	
	nav.breadcrumbs.p2 {
		margin-top: 30px;
		padding-top: 20px;
	}
	
/* 	
	a.breadcrumbs__item.a1:link,
	a.breadcrumbs__item.a1:visited {
		color: black;
		text-decoration: underline;
	}
	
	a.breadcrumbs__item.a1:hover {
		color: gray;
		text-decoration: underline;
	}
*/
	a:link,
	a:visited,
	a:hover {
		color: black;
		text-decoration: underline;
	}
	
	a:hover {
		color: gray;
	}
		
	h1.product-main_title.h1 {
		font: 27px gotham-htf-bold, arial, sans-serif;
		font-weight: bold;
	}
	
	span.price {
		font: 28px courier, arial, sans-serif;
	}
	
	div.review {
		margin-left: 25px;
		padding-top: 5px;
	}

	.checked {
		color: orange;
	}
	
	/* 컬러서클 */
	li.colors {
	    display:flex;
	    padding:5px; 
	}
	
	li.colors > a > span  {
	    width:15px;
	    height:15px;
	    border-radius:50%;
	    cursor:pointer;
	    display:flex;
	    margin-right:6px;	
	}

	ul.color-select > li.colors > a:nth-child(1) > span {
	    background-color:silver;
	}
	
	ul.color-select > li.colors > a:nth-child(2) > span {
	    background-color:black;
	}
	
	ul.color-select > li.colors > a:nth-child(3) > span {
	    background-color:cyan;
	}
	
	ul.color-select > li.colors > a:nth-child(4) > span {
	    background-color:black;
	}		
	
	ul {
		list-style: none;
	}
	
	p.product-testimonial_text bq {
		font: 28px courier, arial, sans-serif;
	}

</style>

 <!-- container -->
 <div class="container">
 
  <!-- product-breadcrumbs -->
  <div class="product-breadcrumbs">
   <nav class="breadcrumbs p2">
    
    <a class="breadcrumbs_item a1" href="#" title="HOME" >HOME</a>
    /
    <a class="breadcrumbs_item a1" href="#" title="남성">남성</a>
    /
    <span class="breadcrumbs_item">제품명</span>
     
   </nav>
  </div>
  <!-- // product-breadcrumbs -->  
  
  <!-- detail_top -->
  <div class="detail_top row">
  
   <div class="col-md-7">
    <div class="img">
     <img src="https://image.nbkorea.com/NBRB_Product/20230201/NB20230201135427272001.jpg" width="100%">
    </div>
	
	<div class="mt-3"> 
	
	 <img src="https://image.nbkorea.com/NBRB_Product/20230201/NB20230201135427272001.jpg" style="width:18%;">
    
     <img src="https://image.nbkorea.com/NBRB_Product/20230201/NB20230201135431504001.jpg" style="width:18%;">
     
     <img src="https://image.nbkorea.com/NBRB_Product/20230201/NB20230201135435350001.jpg" style="width:18%;">
    
     <img src="https://image.nbkorea.com/NBRB_Product/20230201/NB20230201135439519001.jpg" style="width:18%;">
      
     <img src="https://image.nbkorea.com/NBRB_Product/20230201/NB20230201135443160001.jpg" style="width:18%;">
 
     <img src="https://image.nbkorea.com/NBRB_Product/20230201/NB20230201135446884001.jpg" style="width:18%;">
    
    </div> 
   </div>
    
   <div class="col-md-5 product-main_block">
    <h1 class="product-main_title h1">프레쉬폼x 1080 V12 (남성, 4E)</h1>
    
    <div class="d-flex product-main_meta">
     <span class="col product-main_price p1">
      <span class="price">169,000원
      </span>
     </span>
     <div class="pt-2 review">
      <span class="fa-stars">
       <span class="fa fa-star checked"></span>
       <span class="fa fa-star checked"></span>
       <span class="fa fa-star checked"></span>
       <span class="fa fa-star"></span>
       <span class="fa fa-star"></span>
      </span>
      <a href="#" class="text-m">538 리뷰</a>
     </div>
    </div>
     
     
    <br>
    
    <span class="color_select">색상</span>  
    <hr/>
	<ul class="pl-0 color-select">
	 <li class="colors">
	  <a href="#"><span></span></a>
	  <a href="#"><span></span></a>
	  <a href="#"><span></span></a>
      <a href="#"><span></span></a>
   	 </li>
	</ul>  
     
    
    <div class="mt-5"> 
     <p>사이즈
      <a style="float:right;">가이드</a>
     </p>
     <hr/>
     
     <button type="button" class="mt-1 btn btn-warning">250</button>
     <button type="button" class="mt-1 btn btn-warning">255</button>
     <button type="button" class="mt-1 btn btn-warning">260</button>
     <button type="button" class="mt-1 btn btn-warning">265</button>
     <button type="button" class="mt-1 btn btn-warning">270</button>
     <button type="button" class="mt-1 btn btn-warning">275</button>
     <button type="button" class="mt-1 btn btn-warning">280</button>
    
     
     <button type="button" class="mt-1 btn btn-warning">285</button>
     <button type="button" class="mt-1 btn btn-warning">290</button>
     <button type="button" class="mt-1 btn btn-warning">295</button>
     <button type="button" class="mt-1 btn btn-warning">300</button>
     <button type="button" class="mt-1 btn btn-warning">305</button>
     <button type="button" class="mt-1 btn btn-warning">310</button>
    
    </div>
    
    <div class="mt-5"> 
     <p>발볼 넓이</p>
     <button type="button" class="btn btn-secondary">4E(넓음)</button>
    </div>
    <br><br>
    
    <div class="d-flex mt-5"> 
     <button type="button" class="col-4 btn btn-warning">장바구니</button>
     <button type="button" class="col-8 ml-1 btn btn-warning">구매하기</button>
    </div> 
     
   </div>
  </div>
  <!-- // detail_top -->
  
 <!-- carousel -->
 <div id="carousel" class="mt-5 carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carousel" data-slide-to="0" class="active"></li>
    <li data-target="#carousel" data-slide-to="1"></li>
    <li data-target="#carousel" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="https://assets3.cre.ma/p/nbkorea-com/reviews/00/00/28/35/10/image2/1d11934b947299d7.jpg" class="d-block w-100" alt="..."> <!-- d-block 은 display: block; 이고  w-100 은 width 의 크기는 <div class="carousel-item active">의 width 100% 로 잡으라는 것이다. -->
      <div class="carousel-caption d-none d-md-block"> <!-- d-none 은 display : none; 이므로 화면에 보이지 않다가, d-md-block 이므로 d-md-block 은 width 가 768px이상인 것에서만 display: block; 으로 보여라는 말이다.  --> 
	  </div>
    </div>
    <div class="carousel-item">
      <img src="https://assets3.cre.ma/p/nbkorea-com/reviews/00/00/21/49/76/image1/96ce41d0c3d31582.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
	  </div>		      
    </div>
    <div class="carousel-item">
      <img src="https://assets3.cre.ma/p/nbkorea-com/reviews/00/00/21/49/76/image2/7ca48ca6b27a741e.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
	  </div>		      
    </div>
  </div>
  <a class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carousel" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
<!-- // carousel -->

</div>
 <!-- // container -->
 
 <!-- 
    <div class="row" style="width:100%; height: 500px;">
  <div class="col-md-6" style="background-color:#fdd007; height: 500px; padding:auto;">
  <div>
  <p class="product-testimonial_text bq">
  "유명한 변덕스러운 패션 비즈니스의<br>
   썰물과 흐름을 극복하면서 100 년 <br>
   이상의 사업을 자랑하는 브랜드는 거의 없습니다. 가족 관계를 유지하면<br>
   서 글로벌 인지도를 가진 비즈니스를 <br>
   성장시키는 것은 확실히 축하할만한 <br>
   일입니다."
   </p>
   </div>
   	</div>
  <div class="col-md-6" style="background-color:black; height: 500px;">
  </div>
 </div> 
  --> 
  
	<div id="footer_center" style="height: 683px;">
		<div id="footer_center_container" class="row">
			<div id="footer_center_left" class="col-md-6 px-5 pt-4">
				<p class="product-testimonial_text bq">"유명한 변덕스러운 패션 비즈니스의 썰물과 흐름을 극복하면서 100 년 이상의 사업을 자랑하는 브랜드는 거의 없습니다. 가족 관계를 유지하면서 글로벌 인지도를 가진 비즈니스를 성장시키는 것은 확실히 축하할만한 일입니다."</p>
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

<jsp:include page="/footer.jsp"/>