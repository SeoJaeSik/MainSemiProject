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
<title>옵션변경</title>
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

<style>
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');
</style>

<style type="text/css">
 	div#div_container{
		font-family: 'Noto Sans KR', serif;	
		font-weight: 300;
	}
	table > thead > tr > th {
		font-family: 'Noto Sans KR', serif;
		font-weight: 400;
	}
	span#product_color {
		display: inline-block;
		width: 20px;
		height: 20px;
		margin-left: 10px;
		position: relative;
		top: 5px;
		border: solid 1px gray;  
	}
	li{
		display: inline-block;
		list-style-type: none;
		-webkit-box-sizing: border-box;
	}
	label{
		border: solid 1px #333333;
		padding: 5px 15px 5px 0px;
		border-radius: 3px;
		text-align: center;
		box-shadow: 1px 1px 1px 1px #e6e6e6;
	}
	input.btn{opacity: 0;}
	label:hover{
		cursor: pointer;
	}
	button {
		margin: 0 10px auto;
		box-shadow: 1px 1px 1px 1px #e6e6e6;
	}
	.selected {
		background-color: #fdd007;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
	
		$("img[name='product_image']").hide();

		let selectedColor = "${pvo.product_color}";
		let selectedSize = "${pvo.product_size}";
		
		// 회원의 원래옵션(색상) checked 로 표시하기
		$("input:radio[name='product_color']").each(function(index, elmt){
			if($(elmt).val() == "${pvo.product_color}"){
				$(elmt).prop("checked", true);
				$("label#product_color").removeClass('selected');
				$(elmt).parent().addClass('selected');
			}
		}); // end of $("input:radio[name='product_color']").each(function(index, elmt){})

		
		// 회원의 원래옵션(사이즈) checked 로 표시하기
		$("input:radio[name='product_size']").each(function(index, elmt){
			if($(elmt).val() == "${pvo.product_size}"){
				$(elmt).prop("checked", true);
				$("label#product_size").removeClass('selected');
				$(elmt).parent().addClass('selected');
			}
		}); // end of $("input:radio[name='product_color']").each(function(index, elmt){})
		

		// 회원의 원래옵션(이미지) 보여주기
		$("img[name='product_image']").each(function(index, elmt){
			if($(elmt).attr('src') == "${pvo.product_image}"){
				$(elmt).show();
			}
		}); // end of $("img[name='product_image']").each(function(index, elmt){})
		
		
		// 선택한 색상의 css 변경
		$("input:radio[name='product_color']").click(function(){
			if($(this).prop("checked")){
				$("label#product_color").removeClass('selected', {duration:1000});
				$(this).parent().addClass('selected', {duration:1000});
				selectedColor = $(this).val();

				// 선택한 색상에 따른 이미지 보여주기
				$("img[name='product_image']").each(function(index, elmt){
					if($(elmt).parent().attr('id') == selectedColor){
						$("img[name='product_image']").hide();
						$(elmt).show();
					}
				}); // end of $("img[name='product_image']").each(function(index, elmt){})
			}
		}); // end of $("input:radio[name='product_color']")

		
		// 선택한 사이즈의 css 변경
		$("input:radio[name='product_size']").click(function(){
			if($(this).prop("checked")){
				$("label#product_size").removeClass('selected', {duration:500});
				$(this).parent().addClass('selected', {duration:500});
				selectedSize = $(this).val();
			}
		}); // end of $("input:radio[name='product_size']").click(function(){})

		
		// 취소 클릭하면 팝업창 닫기
		$("button[type='reset']").click(function(){
			self.close();
		}); // end of $("button[type='reset']").click(function(){})
		
	}); // end of $(document).ready(function(){})

	///////////////////////////////////////////////////////////////////////////////////////////
	
	// "변경" 클릭하면 호출되는 함수
	function goOptionEdit() {
		const frm = document.OptionEditFrm;
		frm.action = "<%= request.getContextPath()%>/shop/cartListOptionEdit.moc";
		frm.method = "post";
		frm.submit();
	} // end of function goOptionEdit()
	
</script>

</head>

<body>

<form name="OptionEditFrm">
  <input type="hidden" name="cart_no" value="${requestScope.cart_no}">
  <input type="hidden" name="product_name" value="${pvo.product_name}">

	<div id="div_container" class="container mt-5 mx-auto align-self-center">
		<div class="table-responsive mx-auto" style="background-color: #fefce7; border-radius: 2%; box-shadow: 1px 1px 1px 1px #e6e6e6;">
			<table class="table text-center table-borderless" id="tbl_optionEdit">
			  <thead>
			    <tr>
			    	<th colspan="2">
			    		<div id="product_name" name="product_name" class="mt-3 h5">${pvo.product_name}</div>
			    	</th>
			    </tr>
			  </thead>
			  <tbody>
			 	<tr>
			      	<td class="mx-auto p-0" width="85">
			      		<div class="mx-auto mb-3">
				      		<c:forEach var="colorpvo" items="${requestScope.colorList}" varStatus="status" >
		      				  <span id="${colorpvo.product_color}">
		      					<img src="${colorpvo.product_image}" id="product_image${status.index}" name="product_image" width="200" class="img-thumbnail my-2"/>
		      				  </span>
				      		</c:forEach>
			      		</div>
			      	</td>
			      	<td class="mx-auto p-0" width="100">
				      	<div class="mx-auto">
				      		<div id="product_color" name="product_color">
				      			<p class="h6 mb-3">색상</p>
				      			<c:forEach var="colorpvo" items="${requestScope.colorList}" varStatus="status">
					      			<label for="product_color${status.index}" id="product_color">
					      				<input type="radio" class="btn" id="product_color${status.index}" name="product_color" value="${colorpvo.product_color}" />
					      				${colorpvo.product_color}
					      				<span id="product_color" name="product_color" class="rounded-circle" style="background-color: ${colorpvo.product_color};"></span>
					      			</label>
				      			</c:forEach>
				      		</div>
	
			      			<div id="product_size" name="product_size">
			      				<p class="h6 my-3">사이즈</p>
				      			<div>
				      			  <ul class="my-2 px-0">
					      			<c:forEach var="sizepvo" items="${requestScope.sizeList}" varStatus="status">
					      			  <li>
				      					<label for="product_size${status.index}" id="product_size">
				      						<input type="radio" class="btn" id="product_size${status.index}" name="product_size" value="${sizepvo.product_size}" />
				      						${sizepvo.product_size}
				      					</label>
					      			  </li>		      			
					      			</c:forEach>
				      			  </ul>
				      			</div>
							</div>
			      		</div>
			      	</td>
			 	</tr>
			  </tbody>
			  <tfoot>
			  	<tr>
			    	<td colspan="2" class="pb-4">
						<button type="button" class="btn mx-2 px-3" onclick="goOptionEdit()" style="background-color: #fdd007;">변경</button>		    	
						<button type="reset" class="btn btn-dark mx-2 px-3">취소</button>		    	
			    	</td>
			  	</tr>
			  </tfoot>
			</table>
		</div>
	</div>
</form>
<div style="height: 50px;"></div>
</body>
</html>