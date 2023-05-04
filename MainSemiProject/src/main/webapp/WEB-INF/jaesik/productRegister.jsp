<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp"/>

<style type="text/css">

	table#tblProdInput {border: solid gray 1px; 
                        border-collapse: collapse; }
                       
    table#tblProdInput td {border: solid gray 1px; 
                           padding-left: 10px;
                           height: 50px; }
                          
    .prodInputName {background-color:#ffeb99; 
                    font-weight: bold; }                                                 
   
    .error {color: red; font-weight: bold; font-size: 9pt;}
    
    #tblProdInput > tbody > tr > td:nth-child(2) { 
    	background-color: #fefce7;
    }
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		$("input#product_date").datepicker({
			dateFormat: 'yy-mm-dd'   // Input Display Format 변경
            ,showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true // 년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true        // 콤보박스에서 년 선택 가능
            ,changeMonth: true       // 콤보박스에서 월 선택 가능                
            ,showOn: "both"          // button:버튼을 표시하고, 버튼을 눌러야만 달력 표시됨. 
            						 // both:버튼을 표시하고, 버튼을 누르거나 input을 클릭하면 달력 표시됨.  
            ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" // 버튼 이미지 경로   
            ,buttonImageOnly: true   // 기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
            ,buttonText: "선택"       // 버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년"        // 달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] // 달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
			// 달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] // 달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] // 달력의 요일 부분 Tooltip 텍스트
          //,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
          //,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)
		
		});
		
		
		// 이미지 추가 버튼 클릭시
		let cnt = $("button#imgAdd").val();
		$("button#imgAdd").bind("click", function(){
			let html = "";
			cnt++;

			if ( cnt > 10) {
				alert("추가 이미지 첨부는 최대 10개 까지만 가능합니다.");
				cnt = 10;
				return;
			}
			
			$("button#imgAdd").val(cnt);
			for (var i = 0; i < Number(cnt) ; i++) {
				html += "<br><input type='file' name='attach"+i+"' class='btn btn-default img_file' accept='image/*' />";
			}
			
			$("div#divfileattach").html(html);
			$("input#attachCount").val(cnt);
			alert($("input#attachCount").val());
		});
		
		// 이미지 삭제 버튼 클릭시
		$("button#imgRemove").bind("click", function(){
			
			let html = "";
			cnt--;
			$("button#imgAdd").val(cnt);
			
			if ( cnt < 0 ){
				cnt = 0;
				return;
			}
			for (var i = 0; i < Number(cnt) ; i++) {
				html += "<br><input type='file' name='attach"+i+"' class='btn btn-default img_file' accept='image/*' />";
			}
			
			$("div#divfileattach").html(html);
			$("input#attachCount").val(cnt);
			alert($("input#attachCount").val());
		});
		
		
		$(document).on("change", "input.img_file", function(e){
			const input_file = $(e.target).get(0); 
             
	        const fileReader = new FileReader();
	     	// File 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
	         
	        fileReader.readAsDataURL(input_file.files[0]); // FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
	      
	        fileReader.onload = function() { // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임. 

	        	document.getElementById("previewImg").src = fileReader.result;
	        };
		}); // end $(document).on("change", "input.img_file", function(e)
		
		
		// 제품 등록하기
		$("input#btnRegister").click(function(){
			$("span.error").hide();
			
			let flag = false;
			$(".infoData").each(function(i , elmt) {
				const val = $(elmt).val().trim();
				if (val == ""){
					$(elmt).next().show();
					flag = true;
					return false;
				}
			});
			
			if ( !flag ){
				const frm = document.prodInputFrm;
				frm.action = "<%= request.getContextPath()%>/shop/admin/productRegister.moc";
				frm.method = "post";
				frm.submit();
			}
		}); 
		
		// 취소하기
		$("input[type='reset']").click(function(){
			$("span.error").hide();
			$("div#divfileattach").empty();
			$("img#previewImg").hide();
		});
		
	}); // end $(document).ready


</script>

<div align="center" class="container" style="margin-bottom: 20px;">

	<div style="width: 250px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px;">       
		<span style="font-size: 18pt; font-weight: bold;">제품등록&nbsp;[관리자전용]</span>
	</div>
<br/>

<%-- !!!!! ==== 중요 ==== !!!!! --%>
<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
     enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
<form name="prodInputFrm"
      enctype="multipart/form-data"> 
      
<table id="tblProdInput" style="width: 80%;">
<tbody>
   <tr>
      <td width="25%" class="prodInputName">고객유형</td>
      <td width="75%" align="left">
         <select name="buyer_type" class="infoData">
			<option value="">전체</option>
            <c:forEach var="bvo" items="${requestScope.buyerType}">
            	<option value="${bvo.buyer_type_no}">${bvo.buyer_type_name}</option>
            </c:forEach>
         </select>
         <span class="error">필수입력</span>
      </td>   
   </tr>
   <tr>
      <td width="25%" class="prodInputName">카테고리</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
         <select name="shoes_category" class="infoData">
			<option value="">전체</option>
            <c:forEach var="shoevo" items="${requestScope.categoryList}">
            	<option value="${shoevo.shoes_category_no}">(${shoevo.fk_buyer_type_no}) ${shoevo.shoes_category_no}_${shoevo.shoes_category_name}</option>
            </c:forEach>
         </select>
         <span class="error">필수입력</span>
      </td>   
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품명</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
         <input type="text" style="width: 300px;" name="product_name" class="box infoData" />
         <span class="error">필수입력</span>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품색상</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
         <select name="product_color" class="infoData">
			<option value="">전체</option>
            <c:forEach var="colorlist" items="${requestScope.colorList}">
            	<option value="${colorlist}">${colorlist}</option>
            </c:forEach>
         </select>
         <span class="error">필수입력</span>
      </td>   
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품사이즈</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
         <select name="product_size" class="infoData">
			<option value="">전체</option>
            <c:forEach var="sizeList" items="${requestScope.sizeList}">
            	<option value="${sizeList}">${sizeList}</option>
            </c:forEach>
         </select>
         <span class="error">필수입력</span>
      </td>   
   </tr>
   <tr>
      <td width="25%" class="prodInputName">생산일자</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
         <input type="text" style="width: 300px;" id="product_date" name="product_date" class="box infoData"/>
         <span class="error">필수입력</span>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">재고량</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
         <input type="text" style="width: 300px;" name="stock_count" class="box infoData"/> 개
         <span class="error">필수입력</span>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품가격 (판매가)</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
         <input type="text" style="width: 100px;" name="product_price" class="box infoData" /> 원
         <span class="error">필수입력</span>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품설명 (내용)</td>
      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
         <textarea name="product_content" rows="5" cols="60"></textarea>
      </td>
   </tr>
   <tr>
      <td width="25%" class="prodInputName">제품이미지</td>
      <td width="75%" align="left" style="border-top: hidden;">
         <input type="file" name="product_image" class="infoData img_file" />
         <span class="error">필수입력</span>
      </td>
   </tr>
   
   <%-- ==== 첨부파일 타입 추가하기 ==== --%>
	<tr>
		<td width="25%" class="prodInputName">추가이미지파일 (선택)</td>
        <td>
       		<button id="imgAdd" type="button" class="btn btn-primary" value="0">추가</button>
       		<button id="imgRemove" type="button" class="btn btn-danger">삭제</button>
            <div id="divfileattach"></div>
            
            <input type="hidden" name="attachCount" id="attachCount" />
            
        </td>
	</tr>
    
    <%-- ==== 이미지파일 미리보여주기 ==== --%>
    <tr>
		<td width="25%" class="prodInputName">이미지파일 미리보기</td>
		<td>
			<img id="previewImg" width="300" />
		</td>
    </tr>
   
   <tr style="height: 70px;">
      <td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
          <input type="button" value="제품등록" id="btnRegister" style="width: 80px;" /> 
          &nbsp;
          <input type="reset" value="취소"  style="width: 80px;" />   
      </td>
   </tr>
</tbody>
</table>
</form>
</div>

<jsp:include page="footer.jsp"/>