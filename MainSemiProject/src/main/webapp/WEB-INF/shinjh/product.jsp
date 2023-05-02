<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
%>
    
<jsp:include page="./header.jsp"/>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
   
<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<!-- jQueryUI CSS 및 JS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>


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
	a#link:link,
	a#link:visited,
	a#link:hover {
		color: black;
		text-decoration: underline;
	}
	
	a#link:hover {
		color: gray;
	}
		
	h1.product-main_title.h1 {
		font: 27px gotham-htf-bold, arial, sans-serif;
		font-weight: bold;
	}
	
	span#price {
		font: 28px courier, arial, sans-serif;
	}
	
	img#img_select {
		width: 18%;
		margin: 2%;
		padding: 1%;
		cursor: pointer;
	}
	
	button#btn_select {
		border: solid 1px black;
		cursor: pointer;
	}
	
	.img_selected {
		border: solid 1px #FDD007;
	}
	
	.img_not_selected {
		border: solid 1px gray;
	}

	.checked {
		color: orange;
	}
	
	
	ul {
		list-style: none;
	}
	
	.wrap {
		display: flex;
		flex-wrap: wrap;
	}
	
	
	div#testimonial{
		display: flex;
		height: 500px;
		text-align: center;
		justify-content: center;
		margin-bottom: 20px;
	}
	
	div#testimonial_container{
		display: flex;
		height: 100%;
		width: 100%;
	}
	
	div#testimonial_left{
		height: 100%;
		text-align:left;
		background-color: #fdd007;
	}
	
	div#testimonial_left_contents{
		padding: 60px 0px 0px 0px ;
		height: 100%;
		width: 90%;
	}
	
	img#img_logo {
		width: 140px;
		height: 25px;
		margin: auto;
		display: block;
	}
		
	div#testimonial_right{
		background-color: black;
		height: 100%; 
		padding: 40px 0px 40px 50px;
	}
	
	p#testimonial_text{
		width: 100%;
		/* margin: 0; */
		font: 28px courier, arial, sans-serif;
		text-align: center;
	}
	
	.loading {
		background-image: url('spinner.gif');
		background-repeat: no-repeat;
		background-position: center;
		cursor: wait;
	}
	
	.loader {
	    position: relative;
		justify-content: center;
		align-items: center;
	}
	
	.img_loader {
	    position: relative;
	    background: #fdd007;
		width: 100px;
		height: 100px;
		border-radius: 50%;
		top: 50%;
		left: 50%;
  		transform: translate(-50%, -50%);
	}
	
	img#img_wagon {
		position: absolute;
		top: 50%;
		left: 50%;
  		transform: translate(-50%, -50%);
	}

</style>

<script type="text/javascript">

	$(document).ready(function() {
		 
	    $("p#order_error_msg").css('display','none'); // 코인잔액 부족시 주문이 안된다는 표시해주는 곳. 
		
		// 초기 로딩 시 선택된 색상 강조 표시
		$('img[name="colorList"]').each(function() {
			let img1 = this.src;
			let img2 = $('input[name="product_image"]').val();

		    if (img1 == img2) {
		    	$(this).addClass('img_selected').removeClass('img_not_selected');
		    } else {
		    	$(this).addClass('img_not_selected').removeClass('img_selected');
		    }
		});
		
		// 초기 로딩 시 선택된 사이즈 강조 표시
		$('button[name="sizeList"]').each(function() {
			let size1 = $(this).val();
			let size2 = $('input[name="product_size"]').val();

		    if (size1 == size2) {
		    	$(this).addClass('btn-warning').removeClass('btn-white');
		    } else {
		    	$(this).addClass('btn-white').removeClass('btn-warning');
		    }
		});
		
		
		// 스피너
		$("input#spinner").spinner( {
	         spin: function(event, ui) {
	            if(ui.value > 100) {
	               $(this).spinner("value", 100);
	               return false;
	            }
	            else if(ui.value < 1) {
	               $(this).spinner("value", 1);
	               return false;
	            }
	         }
	      } );// end of $("input#spinner").spinner({});----------------   
				
	}); // end of $(document).ready();------------------------------

	// Function Declaration
	
	// *** 이미지 클릭 ***//
	function imgSelect(img) {
	    $('img[name="imgList"]').addClass('img_not_selected').removeClass('img_selected');
	    $(img).addClass('img_selected').removeClass('img_not_selected');
	    $('#expandedImg').attr('src', $(img).attr('src'));
	}
	
	// *** 색상 클릭 ***//
	function colorSelect(img) {
	    $('img[name="colorList"]').addClass('img_not_selected').removeClass('img_selected');
	    $(img).addClass('img_selected').removeClass('img_not_selected');
	    $('input[name="product_color"]').val($(img).attr('src'));
	}
	
	// *** 사이즈 클릭 ***//
	function sizeSelect(btn) {
	    $('button[name="sizeList"]').addClass('btn-white').removeClass('btn-warning');
	    $(btn).addClass('btn-warning').removeClass('btn-white');
	    $('input[name="product_size"]').val($(btn).val());
	}
	
	
   // *** 장바구니 담기 ***//
   function goCart() {
   
      // === 주문량에 대한 유효성 검사하기 === //
      var frm = document.cartOrderFrm;
      
      var regExp = /^[0-9]+$/;  // 숫자만 체크하는 정규표현식
      var oqty = frm.oqty.value;
      var bool = regExp.test(oqty);
      
      if(!bool) {
         // 숫자 이외의 값이 들어온 경우 
         alert("주문갯수는 1개 이상이어야 합니다.");
         frm.oqty.value = "1";
         frm.oqty.focus();
         return; // 종료 
      }
      
      // 문자형태로 숫자로만 들어온 경우
      oqty = parseInt(oqty);
      if(oqty < 1) {
         alert("주문갯수는 1개 이상이어야 합니다.");
         frm.oqty.value = "1";
         frm.oqty.focus();
         return; // 종료 
      }
      
      // 주문개수가 1개 이상인 경우
      frm.method = "POST";
      frm.action = "<%= request.getContextPath()%>/shop/cartAdd.up";
      frm.submit();
   
   }// end of function goCart()-------------------------
   
   
   // *** 바로주문하기 *** // 
   function goOrder(btn) {
	   
	   if( ${not empty sessionScope.loginuser} ) {
			   
		   const current_coin = Number("${sessionScope.loginuser.coin}"); // 현재코인액
		   const sum_totalPrice = Number("${requestScope.pvo.product_price}") * Number($("input#spinner").val()); // 제품총판매가
		   
			if( sum_totalPrice > current_coin) {
				$("p#order_error_msg").html("코인잔액이 부족하므로 주문이 불가합니다.<br>주문총액 : "+sum_totalPrice.toLocaleString('en')+"원 / 코인잔액 : "+current_coin.toLocaleString('en')+"원").css('display','');
				return;
			}
	   
	  		
		   else {
			   $("p#order_error_msg").css('display','none');
		   
			   if( confirm("총주문액 : " + sum_totalPrice.toLocaleString('en') + "원 결제하시겠습니까?") ) {

				   $(btn).html('<i class="fa-solid fa-circle-notch fa-spin"></i> loading');
				   
					$.ajax({
						url:"<%= request.getContextPath()%>/shop/orderAdd.up",
						type:"post",
						data:{"sum_totalPrice":sum_totalPrice,
							"product_no_join":"${requestScope.pvo.product_no}",
							"oqty_join":$("input#spinner").val(),
							"totalPrice_join":sum_totalPrice
							},
						dataType:"json",
						success:function(json) {
							// json은 {"isSuccess":1} 또는 {"isSuccess":0}이다.
							
							if(json.isSuccess == 1) {
								location.href="<%= request.getContextPath()%>/shop/orderList.up";
							}
							else {
								location.href="<%=request.getContextPath()%>/shop/orderError.up";
							}
							
						},
			        	 error: function(request, status, error){
			                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				        }
							
					});
					   
					}// end of if
				}
			}// end of if
		
		else {
	   		alert("주문을 하시려면 먼저 로그인 하세요!!");
	   }
			
   } // end of function goOrder()----------------------   
   
   
</script>  
   
<!-- container -->
<div class="container">
 
  <!-- product-breadcrumbs -->
  <div class="product-breadcrumbs">
    <nav class="breadcrumbs p2">
    
      <a id="link" href="<%= ctxPath%>/index.moc" title="HOME" >HOME</a>
      /
      <a id="link" href="<%= ctxPath%>/allproduct.moc?buyer_type_no='${requestScope.pvo.btvo.buyer_type_no}'" title="${requestScope.pvo.btvo.buyer_type_name}">${requestScope.pvo.btvo.buyer_type_name}</a>
      /
      <a id="link" href="<%= ctxPath%>/allproduct.moc?buyer_type_no='${requestScope.pvo.btvo.buyer_type_no}'&shoes_category_no='${requestScope.pvo.scvo.shoes_category_no}'" title="${requestScope.pvo.scvo.shoes_category_name}">${requestScope.pvo.scvo.shoes_category_name}</a>
      /
      <span>${requestScope.pvo.product_name}</span>
     
    </nav>
  </div>
  <!-- // product-breadcrumbs -->  
  
  <!-- detail_top -->
  <div class="mt-3 detail_top row">
  
    <div class="col-md-7">
	  <div class="container">
	    <img id="expandedImg" class="col-md-12" src="${requestScope.pvo.product_image}">
	  </div>
	
	  <div class="row">
	    <div class="column">
	      <img id="img_select" name="imgList" class="img_small img_selected" src="${requestScope.pvo.product_image}" onclick="imgSelect(this);">
	    </div>
	
	    <c:if test="${not empty requestScope.imgList}">
	      <c:forEach var="imgfilename" items="${requestScope.imgList}">
	        <div class="column">
	          <img id="img_select" name="imgList" class="col-md-2 img_small img_not_selected" src="${imgfilename}" style="width:100%" onclick="colorSelect(this);">
	        </div>
	      </c:forEach>
	    </c:if>
      </div>
    </div>
    
    <div class="col-md-5 product-main_block">
      <h1 class="product-main_title h1">${requestScope.pvo.product_name}</h1>
    
        <div class="d-flex product-main_meta">
          <span class="col product-main_price p1">
            <span id="price"><fmt:formatNumber value="${requestScope.pvo.product_price}" pattern="###,###" /></span>
          </span>
        <div class="ml-5 pt-2 review">
          <span class="fa-stars">
            <span class="fa fa-star checked"></span>
            <span class="fa fa-star checked"></span>
            <span class="fa fa-star checked"></span>
            <span class="fa fa-star"></span>
            <span class="fa fa-star"></span>
          </span>
        <a id="link" href="#" class="text-m">538 리뷰</a>
        </div>
      </div>
      
      <div class="mt-3">
	      <span class="color_select">색상</span>  
	      <hr/>
      </div>
      
	  <div class="row">	
	    <c:if test="${not empty requestScope.colorList}">
	      <c:forEach var="colorfilename" items="${requestScope.colorList}">
	        <img id="img_select" name="colorList" class="img_small col-2" src="${colorfilename}" onclick="colorSelect(this);">	        
	      </c:forEach>
	    </c:if>
      </div>

    
      <div class="mt-5"> 
        <p>사이즈
          <a id="link" style="float:right;">가이드</a>
        </p>
        <hr/>
        
        
	    <div class="row">
          <div class="col-md-12">
            <div class="btn-group wrap" role="group">	
	          <c:if test="${not empty requestScope.sizeList}">
	            <c:forEach var="size" items="${requestScope.sizeList}">
	              <div class="col-md-2 mt-2">
	                <button type="button" id="btn_select" name="sizeList" class="btn btn-white" value="${size}" onclick="sizeSelect(this);">${size}</button>	        
	              </div>
	            </c:forEach>
	          </c:if>
            </div>
          </div>
        </div>
    
    
      <%--  
      <ul class="">
        <li>
          <label for="spinner">주문개수&nbsp;</label>
          <input id="spinner" name="oqty" value="1" style="width: 110px;">
        </li>
      </ul>
      <div>
	      <button type="button" id="btn_select" class="col-4 btn btn-white" onClick="goCart()">장바구니</button>
	      <button type="button" id="btn_select" class="col-8 ml-1 btn btn-warning" onClick="goOrder(this)">구매하기</button>
      </div>
    </div>
    --%>
        <form name="cartOrderFrm">
          <div class="mt-3 d-flex flex-column justify-content-between">
            <div class="align-self-end">
              <ul class="text-right">
                <li>
                  <label for="spinner">주문개수&nbsp;</label>
                  <input id="spinner" name="oqty" value="1" style="width: 110px;">
                </li>
              </ul>
            </div>
            <div class="d-flex justify-content-between mt-3">
              <button type="button" id="btn_select" class="col-4 btn btn-white" onClick="goCart()">장바구니</button>
              <button type="button" id="btn_select" class="col-8 ml-1 btn btn-warning" onClick="goOrder(this)">구매하기</button>
            </div>
          </div>
          <input type="hidden" name="product_no" value="${requestScope.pvo.product_no}" />
          <input type="hidden" name="product_color" value="${requestScope.pvo.product_color}" />
          <input type="hidden" name="product_size" value="${requestScope.pvo.product_size}" />
          <input type="hidden" name="product_image" value="${requestScope.pvo.product_image}" />
        </form>  
    
         
	    <div>
		  <p id="order_error_msg" class="text-center text-danger font-weight-bold h4">코인잔액이 부족하므로<br>주문이 불가합니다.</p>
	    </div>
     
      </div>
    </div>
  </div>
  <!-- // detail_top -->

 <%-- 
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
  <a id="link" class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a id="link" class="carousel-control-next" href="#carousel" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
<!-- // carousel -->
  --%>
</div>
<!-- // container -->

 
<div id="testimonial" class="my-5">
  <div id="testimonial_container" class="row">
    <div id="testimonial_left" class="col-md-6 px-5 pt-4">
      <div id="testimonial_left_contents" class="col">
      <p id="testimonial_text">
        "유명한 변덕스러운 패션 비즈니스의<br>
        썰물과 흐름을 극복하면서 100 년 <br>
        이상의 사업을 자랑하는 브랜드는 거 <br>
        의 없습니다. 가족 관계를 유지하면<br>
        서 글로벌 인지도를 가진 비즈니스를 <br>
        성장시키는 것은 확실히 축하할만한 <br>
        일입니다."
      </p>
    <img id="img_logo" title="Los Angeles Times" alt="Los Angeles Times" src="https://cdn.accentuate.io/752526983272/-1679306522877/Los_Angeles_Times_logo-v1679947630614.png?1280x161">
    </div>
  </div>
    <div id="testimonial_right" class="col-md-6">
    </div>
  </div> 
</div>

  
<jsp:include page="./footer.jsp"/>