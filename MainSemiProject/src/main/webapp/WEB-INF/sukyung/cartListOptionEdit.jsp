<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<style type="text/css">
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
		padding: 5px 0px 5px 15px;
		border-radius: 3px;
		text-align: center;
	}
	label#label_size{border:solid 1px gray;}
	input.btn{opacity: 0;}
	label:hover{
		cursor: pointer;
	}
	button {
		margin: 0 10px auto;
		box-shadow: 1px 1px 1px 1px #e6e6e6;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		
		
	}); // end of $(document).ready(function(){})

</script>

</head>

<body>

<div class="container mt-5 mx-auto align-self-center">
	<div class="table-responsive mx-auto">
		<table class="table text-center" id="tbl_optionEdit" style="border-top:solid 1px gray; border-bottom:solid 1px gray;" >
		  <thead>
		    <tr>
		    	<th colspan="2" class="h4" style="border-bottom: solid 1px gray; border-top: solid 1px gray; background-color: #fff9e5;">색상/사이즈 변경하기</th>
		    </tr>
		  </thead>
		  <tbody>
		 	<tr>
		      	<td class="mx-auto p-0" width="85">
		      		<div class="mx-auto my-3">
			      		<div id="product_name" name="product_name" class="my-2 h6">${pvo.product_name}</div>
			      		<img src="${pvo.product_image}" id="product_image" name="product_image" width="200" class="img-thumbnail my-2"/>
		      		</div>
		      	</td>
		      	<td class="mx-auto p-0" width="100">
			      	<div class="mx-auto my-4">
			      		<div id="product_color" name="product_color">
			      			<p class="h6 my-1">색상</p>
			      			<label for="product_color">${pvo.product_color}
			      				<span id="product_color" name="product_color" class="rounded-circle" style="background-color: ${pvo.product_color};"></span>
			      				<input type="radio" class="btn" id="product_color" name="product_color" value="${pvo.product_color}" />
			      			</label>
			      			<label for="product_color">${pvo.product_color}
			      				<span id="product_color" name="product_color" class="rounded-circle" style="background-color: ${pvo.product_color};"></span>
			      				<input type="radio" class="btn" id="product_color" name="product_color" value="${pvo.product_color}" />
			      			</label>
			      		</div>
		      			<div id="product_size" name="product_size">
		      				<p class="h6 my-4">사이즈</p>
			      			<div>
			      			<ul class="my-2 px-0">
			      				<li>
			      					<label for="product_size" id="label_size">${pvo.product_size}
			      						<input type="radio" class="btn" id="product_size" name="product_size" value="${pvo.product_size}" />
			      					</label>
			      				</li>
			      				<li>
			      					<label for="product_size" id="label_size">${pvo.product_size}
			      						<input type="radio" class="btn" id="product_size" name="product_size" value="${pvo.product_size}" />
			      					</label>
			      				</li>
			      				<li>
			      					<label for="product_size" id="label_size">${pvo.product_size}
			      						<input type="radio" class="btn" id="product_size" name="product_size" value="${pvo.product_size}" />
			      					</label>
			      				</li>
			      				<li>
			      					<label for="product_size" id="label_size">${pvo.product_size}
			      						<input type="radio" class="btn" id="product_size" name="product_size" value="${pvo.product_size}" />
			      					</label>
			      				</li>
			      				<li>
			      					<label for="product_size" id="label_size">${pvo.product_size}
			      						<input type="radio" class="btn" id="product_size" name="product_size" value="${pvo.product_size}" />
			      					</label>
			      				</li>
			      				<li>
			      					<label for="product_size" id="label_size">${pvo.product_size}
			      						<input type="radio" class="btn" id="product_size" name="product_size" value="${pvo.product_size}" />
			      					</label>
			      				</li>
			      				<li>
			      					<label for="product_size" id="label_size">${pvo.product_size}
			      						<input type="radio" class="btn" id="product_size" name="product_size" value="${pvo.product_size}" />
			      					</label>
			      				</li>
			      				<li>
			      					<label for="product_size" id="label_size">${pvo.product_size}
			      						<input type="radio" class="btn" id="product_size" name="product_size" value="${pvo.product_size}" />
			      					</label>
			      				</li>
			      			</ul>
			      			</div>
						</div>
		      		</div>
		      	</td>
		 	</tr>
		  </tbody>
		  <tfoot>
		  	<tr>
		    	<td colspan="2" class="pb-4" style="border-bottom: solid 1px gray; border-top: none;">
					<button type="button" class="btn" onclick="goOptionEdit()" style="background-color: #fdd007;">변경</button>		    	
					<button type="reset" class="btn btn-dark">취소</button>		    	
		    	</td>
		  	</tr>
		  </tfoot>
		</table>
	</div>
</div>

</body>
</html>