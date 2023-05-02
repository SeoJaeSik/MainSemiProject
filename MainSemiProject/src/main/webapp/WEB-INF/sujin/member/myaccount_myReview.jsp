<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	div#viewmy2 {
		background-color:#fefce7; 
		padding-top:40px;
		padding-bottom:40px;
	}

</style>

<div class="tab-pane container fade" id="viewmy2" >

  	<h4 class="my-3" style="font-weight: bold; text-align: center;">내가 작성한 리뷰 보기</h4>
  	
  	<form name="reviewListFrm" class="col-md-12 py-3 mx-auto">
  	<div class="row justify-content-around my-4 ">
	    <div class="col-2 text-center">NO</div>
	    <div class="col-2 text-center">주문상품</div>
	    <div class="col-2 text-center">리뷰제목</div>
	    <div class="col-2 text-center">리뷰내용</div>
	</div>
	
	<hr>
	
	<br><br><br>
	<div class="text-center">리뷰 내역이 없습니다.</div>
	<br><br>
	<div class="text-center">
		<button class="btn btn-lg col-4 mx-auto" style="border-radius: 5px; font-weight:bold; background-color:#ffeb99; " id="btnUpdate" onclick="goshopping()">리뷰작성하기</button>
	</div>
	<br><br><br>
	
	</form>
</div>
