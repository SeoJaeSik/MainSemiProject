<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp"/>

<style type="text/css">

	tr.memberInfo:hover {
      background-color: #fdf0b4;
      cursor:pointer;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		<%-- if ( "${fn:trim(requestScope.searchWord)}" != "" ) --%> 
		if( "${requestScope.searchType}" != "" && "${requestScope.searchWord}" != "" ) {
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		$("input#searchWord").keydown(function(e){
			if( e.keyCode == 13 ){ // 검색창에서 엔터를 입력하면 검색 함수를 실행
				goSearch();
			}
		});
		
		// select 태그에 대한 이벤트는 click이 아니라 change
		$("select#sizePerPage").change(function(){
			goSearch()
		});
		
		// 3 특정 회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다
		$("tr.memberInfo").click( (e) => {
	    // alert($(e.target).parent().html());
	    // parent() 을 함으로 아이디/회원명/이메일/성별 어디를 눌러도 한명을 선택한것이 된다
			const userid = $(e.target).parent().find(".userid").html();
	    	location.href="<%= ctxPath%>/member/admin/memberOneDetail.moc?userid="+userid;
	    });
	      
		
	}); // end $(document).ready
	
	function goSearch(){
		
		const frm = document.memberFrm;
		frm.action = "memberList.moc";
		frm.method = "get";
		frm.submit();
		
	}

</script>

<div class="container">
	<h2 class="text-center" style="margin: 40px; font-weight: bold; color: black;">회원 전체 목록</h2>
	<form name="memberFrm" class="text-center my-5">
		<select id="searchType" name="searchType">
			<option value="">선택하세요</option>
			<option value="name">회원명</option>
			<option value="userid">아이디</option>
			<option value="email">이메일</option>
		</select>
		<input type="text" id="searchWord" name="searchWord"/>
		<button type="button" class="btn bg-dark text-white" style="margin-right: 30px;" onclick="goSearch();">검색</button>
	</form>
	
	<form name="memberTBL">
		<table id="memberTbl" class="table table-bordered" style="width: 90%; margin-top: 20px;">
			<thead>
				<tr>
					<th>아이디</th>
					<th>회원명</th>
		            <th>이메일</th>
		            <th>연락처</th>
		            <th>주소</th>
	           </tr>
	        </thead>
	        <tbody>
	        	<c:if test="${not empty requestScope.memberList}">
	        		<%-- new를 한 객체이기 때문에 != null이 아닌 empty를 사용해야 한다. --%>
		        	<c:forEach items="${requestScope.memberList}" var="mvo">
		        		<tr class="memberInfo"> <!-- **************************** -->
                     		<td class="userid">${mvo.userid}</td>
	              			<td>${mvo.name}</td>
	              			<td>${mvo.email}</td>
	              			<td>${fn:substring(mvo.mobile, 0, 3)}-${fn:substring(mvo.mobile, 3, 7)}-${fn:substring(mvo.mobile, 7, 11)}</td>
	              			<td>${mvo.address}</td>
	            		</tr>
		        	</c:forEach>
	        	</c:if>
	        	
	        	<c:if test="${empty requestScope.memberList}">
	        		<tr>
	              		<td colspan="5">가입된 회원이 없습니다.</td>
	            	</tr>
	        	</c:if>
	        </tbody>
	    </table>
	
		<nav class="my-5">
			<div style='display:flex; width:80%;'>
				<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
			</div>
		</nav>
	</form>
</div>

<jsp:include page="footer.jsp"/>