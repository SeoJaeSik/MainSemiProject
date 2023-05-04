<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
%>
    
<jsp:include page="../jaesik/header.jsp" />

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
		opacity: 0;
		font: 13px courier, arial, sans-serif;
	}
	
	nav.breadcrumbs.p2 {
		margin-top: 30px;
		padding-top: 20px;
	}
	
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
	
	span[name="product_price"] {
		font: 28px courier, arial, sans-serif;
	}
	
	button#btn_select {
		border: solid 1px black;
	}
	
	.selected {
		border: solid 3px #FDD007;
	}
	
	.not_selected {
		border: solid 1px gray;
		cursor: pointer;
	}

	.checked {
		color: orange;
	}
	
	ul {
		list-style: none;
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
		
		let btn_html; 		// 버튼의 원래 값을 담을 변수
		
		moreImg(); 			// 추가이미지, 사이즈 ajax 처리
		
		imgSelected(); 		// 선택된 이미지 강조 표시		
		colorSelected(); 	// 선택된 색상 강조 표시
		sizeSelected(); 	// 선택된 사이즈 강조 표시
		
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
	
	
	// 추가이미지, 사이즈 ajax 처리
	function moreImg() {
		
		$('div.container').css('opacity', 0);
		    
		$.ajax({
			url:"<%= ctxPath%>/moreImgJSON.moc",
     		data:{"product_name":"${requestScope.pvo.product_name}",
				"product_color": $('input[name="product_color"]').val()
     			}, 
	  		type:"get",
	 		dataType:"json",
	 		async:false,
	 		success:function(json) {
	 			
	 			// 추가이미지 넣기
	 			let html = '';
	 			
	 			if(!$.isEmptyObject(json.imgList)) {
	 				
	 			    html += '<div class="col-md-12">'+
	 				  		  '<img id="expandedImg" class="col-md-12" src="'+json.imgList[0]+'">'+
	 				  		  '<div class="row flex-wrap">';
	 				
	 				$.each(json.imgList, function(index, item){

		 			    html += '<img id="img_select" name="imgList" class="col-md-2 m-3 p-1" src="'+item+'" onclick="imgSelect(this);">';
				 			    
				 	});// end of if(!$.isEmptyObject(json.imgList))
	 				
	 				html += '</div></div>';
	 				
	 				// 추가이미지 출력하기
					$("div#img_list").html(html);
	 			}
	 			
	 			
	 			// 사이즈 넣기
	 			html = '';
	 			
	 			if(!$.isEmptyObject(json.sizeList)) {
	 				
	 				$.each(json.sizeList, function(index, item){
	 					
	 				    html += '<div class="col-md-2 mt-2">'+
	 		                      '<button type="button" id="btn_select" name="sizeList" class="btn btn-white" value="'+item+'" onclick="sizeSelect(this);">'+item+'</button>'+	        
	 		                    '</div>';
	 				});// end of $.each(json.sizeList, function(index, item)

	 				// 사이즈 출력하기
					$("div#size_list").html(html);
	 			}
	 			
	 		},
	 		error: function(request, status, error) {
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
 		});
	 				
		$('div.container').animate({opacity: 1}, 1000);
	 				
	}
	
	
 	// 선택된 이미지 강조 표시
	function imgSelected() {
		$('img[name="imgList"]').each(function() {
			
			let img1 = $(this).attr('src');
			
			let img2 = $('#expandedImg').attr('src');
	
		    if ( img1.substring("http://localhost:9090".length) == img2
		    		|| img1 == img2 ) {
		    	
		    	$(this).addClass('selected').removeClass('not_selected');
		    
		    } else {
		    	
		    	$(this).addClass('not_selected').removeClass('selected');
		    
		    }
		});
	}
	
	// 선택된 색상 강조 표시
	function colorSelected() {
		
		$('img[name="colorList"]').each(function() {
			
			let img1 = $(this).attr('value');
			
			let img2 = $('input[name="product_color"]').val();

	
		    if ( img1 == img2 ) {
		    	
		    	$(this).addClass('selected').removeClass('not_selected');
		    
		    } else {
		    	
		    	$(this).addClass('not_selected').removeClass('selected');
		    
		    }
		});
	}
	
	// 선택된 사이즈 강조 표시
	function sizeSelected() {
		
		$('button[name="sizeList"]').each(function() {
			
			let size1 = $(this).val();
			let size2 = $('input[name="product_size"]').val();
	
		    if (size1 == size2) {
		    	$(this).addClass('btn-warning').removeClass('btn-white');
		    } else {
		    	$(this).addClass('btn-white').removeClass('btn-warning');
		    }
		});
	}
	
	// *** 이미지 클릭 ***//
	function imgSelect(img) {		
		
	    $('#expandedImg').attr('src', $(img).attr('src'));
	    
	 	// 선택된 이미지 강조 표시
		imgSelected();
	}
	
	
	// *** 색상 클릭 ***//
	function colorSelect(img) {

		let img1 = $(img).attr('value');
		
		let img2 = $('input[name="product_color"]').val();

	    if ( img1 != img2 ) { // 다른 색상을 클릭했을 경우			
	    	
	    	// 색상정보를 갱신한다
	    	$('input[name="product_color"]').val($(img).attr('value'));
	    	
			// 추가이미지, 사이즈 구현하기!
			moreImg();
	    
			// 선택된 이미지 강조 표시
			imgSelected();
			 				
		 	// 선택된 색상 강조 표시
		    colorSelected();
		 	
		 	// 선택된 사이즈 강조 표시
			sizeSelected();
	 	
	    }// end of if
	}// end of function colorSelect(img)
	
	
	// *** 사이즈 클릭 ***//
	function sizeSelect(btn) {
		
	    $('input[name="product_size"]').val($(btn).val());
	    
	 	// 선택된 사이즈 강조 표시
		sizeSelected();
	}
	
	
   // *** 장바구니 담기 ***//
   function goCart(btn) {
	   
      start_loading(btn); // 버튼 로딩처리
   
      // === 주문량에 대한 유효성 검사하기 === //
      var frm = document.cartOrderFrm;
      
      var oqty = $("input#spinner").val();
      var regExp = /^[0-9]+$/;  // 숫자만 체크하는 정규표현식
      var bool = regExp.test($("input#spinner").val());
      
      if(!bool) {
         // 숫자 이외의 값이 들어온 경우 
         alert("주문갯수에는 숫자만 입력해주세요.");
         $("input#spinner").val("1");
         $("input#spinner").focus();
         
         end_loading(btn); // 로딩버튼 원상복구
         return; // 종료 
      }
      
      // 문자형태로 숫자로만 들어온 경우
      oqty = parseInt(oqty);
      if(oqty < 1) {
         alert("주문갯수는 1개 이상이어야 합니다.");
         $("input#spinner").val("1");
         $("input#spinner").focus();
         
         end_loading(btn); // 로딩버튼 원상복구
         return; // 종료 
      }
      
      // 주문개수가 1개 이상인 경우
      // *** 장바구니 담기 *** // 
      
      if(${not empty sessionScope.loginuser}){
    	  
			$.ajax({
				url:"<%= request.getContextPath()%>/shop/cartListAdd.moc",
				type:"post",
				data:{"product_name":"${requestScope.pvo.product_name}",
					"product_color":$('input[name="product_color"]').val(),
					"product_size":$('input[name="product_size"]').val(),
					"cart_product_count":$("input#spinner").val(),
					},
				dataType:"json",
				success:function(json) {
					// json은 {"result":1} 또는 {"result":0}이다.
					
					if(json.result == 1) {
						if(confirm("장바구니에 상품을 담았습니다.\n장바구니로 이동하시겠습니까?")){
							
							location.href="<%= request.getContextPath()%>/shop/cartList.moc";
						}
						
						end_loading(btn); // 로딩버튼 원상복구
						
					}
				},
	        	 error: function(request, status, error){
	                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
				
			});	
			
      }
      else {
    	  location.href="<%= request.getContextPath()%>/login/login.moc";
      }
		
	}// end of function goCart()-------------------------
   
	
   // *** 바로주문하기 *** // 
   function goOrder(btn) {
		
	   start_loading(btn); // 버튼 로딩처리
		
		// 제품상세에서 바로결제
		 if(${not empty sessionScope.loginuser}){
		
			$.ajax({
				url:"<%= ctxPath%>/shop/orderAdd.moc",
	     		data:{"product_name":"${requestScope.pvo.product_name}",
					"product_color":"${requestScope.pvo.product_color}",
					"product_size":"${requestScope.pvo.product_size}",
					"cart_product_count":$("input#spinner").val(),
	     			}, 
		  		type:"post",
		 		dataType:"json",
		 		async:false,
		 		success:function(json) {
			    	if(json.isSuccess == 1) { // 배송정보로 이동
			    		end_loading(btn); // 로딩버튼 원상복구
				    	location.href="<%= ctxPath%>/shop/delivery.moc";
				    }
				    else {
						location.href="javascript:history.go(0);"; // 새로고침
				    }
		 		},
		 		error: function(request, status, error) {
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
	 		});
      }
      else {
    	  location.href="<%= request.getContextPath()%>/login/login.moc";
      }
		
			
   } // end of function goOrder()----------------------   
   
   
	// 로딩 버튼으로 만들기
	function start_loading(btn) {
  
		btn_html = $(btn).html();
		$(btn).html('<i class="fa-solid fa-circle-notch fa-spin"></i> loading');
		$(btn).attr("disabled", true);
  
	}
 
 
	// 로딩버튼 되돌리기
	function end_loading(btn) {
	
		$(btn).html(btn_html);
		$(btn).attr("disabled", false);
	  
	}
   
</script>  
   
<!-- container -->
<div class="container my-5">
 
  <!-- product-breadcrumbs -->
  <div class="product-breadcrumbs">
    <nav class="breadcrumbs p2">
    
      <a id="link" href="<%= ctxPath%>/index.moc" title="HOME" >HOME</a>
      /
      <a id="link" href="<%= ctxPath%>/shop/allproduct.moc" title="${requestScope.pvo.btvo.buyer_type_name}">${requestScope.pvo.btvo.buyer_type_name}</a>
      <%-- <a id="link" href="<%= ctxPath%>/allproduct.moc?buyer_type_no='${requestScope.pvo.btvo.buyer_type_no}'" title="${requestScope.pvo.btvo.buyer_type_name}">${requestScope.pvo.btvo.buyer_type_name}</a> --%>
      /
      <a id="link" href="<%= ctxPath%>/shop/allproduct.moc" title="${requestScope.pvo.scvo.shoes_category_name}">${requestScope.pvo.scvo.shoes_category_name}</a>
      <%-- <a id="link" href="<%= ctxPath%>/allproduct.moc?buyer_type_no='${requestScope.pvo.btvo.buyer_type_no}'&shoes_category_no='${requestScope.pvo.scvo.shoes_category_no}'" title="${requestScope.pvo.scvo.shoes_category_name}">${requestScope.pvo.scvo.shoes_category_name}</a>--%>
      /
      <span>${requestScope.pvo.product_name}</span>
     
    </nav>
  </div>
  <!-- // product-breadcrumbs -->  
  
  <!-- detail_top -->
  <div class="detail_top row">
  
	<div id="img_list"></div>
    
    <div class="col-md-5 product-main_block">
      <h1 class="product-main_title h1">${requestScope.pvo.product_name}</h1>
    
        <div class="d-flex product-main_meta">
          <span class="col product-main_price p1">
            <span name="product_price"><fmt:formatNumber value="${requestScope.pvo.product_price}" pattern="###,###" />원</span>
          </span>
          <%-- 
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
        --%>
      </div>
      
      <div class="mt-3">
	      <span class="color_select">색상</span>  
	      <hr/>
      </div>
      
	  <div class="row">	
	    <c:if test="${not empty requestScope.colorList}">
	      <c:forEach var="colorList" items="${requestScope.colorList}">
	        <img id="img_select" name="colorList" class="col-md-2 m-3 p-1" src="${colorList.product_image}" value="${colorList.product_color}" title="${colorList.product_color}" onclick="colorSelect(this);">	        
	      </c:forEach>
	    </c:if>
      </div>

    
      <div class="mt-5"> 
        <p>사이즈</p>
        <hr/>
        
        
	    <div class="row">
          <div class="col-md-12">
            <div id="size_list" class="btn-group flex-wrap" role="group">
            </div>
          </div>
        </div>

        <div class="mt-3 d-flex flex-column justify-content-between">
          <div class="align-self-end">
            <ul class="text-right">
              <li>
                <label for="spinner">주문갯수&nbsp;</label>
                <input id="spinner" name="oqty" value="1" style="width: 110px;">
              </li>
            </ul>
          </div>
          <div class="d-flex justify-content-between mt-3">
            <button type="button" id="btn_select" class="col-4 btn btn-white" onClick="goCart(this)">장바구니</button>
            <button type="button" id="btn_select" class="col-8 ml-1 btn btn-warning" onClick="goOrder(this)">구매하기</button>
          </div>
          
          <input type="hidden" name="product_no" value="${requestScope.pvo.product_no}" />
          <input type="hidden" name="product_color" value="${requestScope.pvo.product_color}" />
          <input type="hidden" name="product_size" value="${requestScope.pvo.product_size}" />
          <input type="hidden" name="product_image" value="${requestScope.pvo.product_image}" />
          
        </div>
     
      </div>
    </div>
  </div>
  <!-- // detail_top -->

</div>
<!-- // container -->

<%-- 
<div id="container_review" class="col-md-12 container">
  <div id="container_headline" class="align-c">
    <h2 class="product-reviews_title" class="align-c">Reviews</h2>
    <button class="pull-right">write a review</button>
  </div>
</div>
--%>

<%--
<div class="row">	
	    <c:if test="${not empty requestScope.colorList}">
	      <c:forEach var="colorList" items="${requestScope.colorList}">
	        <img id="img_select" name="colorList" class="col-md-2 m-3 p-1" src="${colorList.product_image}" value="${colorList.product_color}" title="${colorList.product_color}" onclick="colorSelect(this);">	        
	      </c:forEach>
	    </c:if>
      </div>
--%> 

<%--
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
--%>
  
<jsp:include page="../jaesik/footer.jsp" />	