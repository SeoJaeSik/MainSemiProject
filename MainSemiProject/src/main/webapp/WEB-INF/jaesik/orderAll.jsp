<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp"/>

<style type="text/css">

	span.li_style {
		font-weight: bold;
		font-size: 13pt; 
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	}); // end $(document).ready
	

</script>

<div class="container-fluid my-5 px-5" style="text-align: -webkit-center;">
	<div class="my-5">
		<p class="h2 text-center" style="font-weight: bold;">전체 주문내역 조회</p>
	</div>
	
	<div>
		<form name="frmDeliver">
			<table id="tblOrderList" style="width: 100%;">
			    <tr bgcolor="#cfcfcf" style="font-size: 15pt;">
					<th width="13%" style="text-align: center;">주문코드</th>
					<th width="11%" style="text-align: center;">주문일자</th>
					<th width="40%" style="text-align: center;">제품정보</th>
					<th width="10%" style="text-align: center;">총 주문 금액</th>   
					<th width="26%" style="text-align: center;">주문자정보</th>
			    </tr>
				<c:if test="${empty requestScope.orderList}" > 
					<tr>
						<td colspan="6" align="center">
						<span style="color: red; font-weight: bold;">주문내역이 없습니다.</span>
					</tr>
				</c:if>
				
				<c:if test="${not empty requestScope.orderList}">
					<c:forEach var="odrmap" items="${requestScope.orderList}" varStatus="status">
						<%--
							 varStatus 는 반복문의 상태정보를 알려주는 애트리뷰트이다.
							 status.index : 0 부터 시작한다.
							 status.count : 반복문 횟수를 알려주는 것이다.
						 --%>
						<tr>
							<td align="center" style="font-weight: bold;">
								전체 주문번호<br>${fn:substring(odrmap.order_no, 0, 4)}-${fn:substring(odrmap.order_no, 4, 8)}-${fn:substring(odrmap.order_no, 8, 20)}
								<br><br>
								상세 주문번호<br>${fn:substring(odrmap.order_detail_no, 0, 4)}-${fn:substring(odrmap.order_detail_no, 4, 8)}-${fn:substring(odrmap.order_detail_no, 8, 20)}
							</td>
							<td align="center">${odrmap.orderdate}</td>
							<td style="cursor:pointer;" onclick="javascript:location.href='<%= ctxPath%>/product.moc?product_name=${odrmap.product_name}'">
								<div style="display: flex; padding-top: 10px; justify-content: space-between;">
									<div style="width: 44%;">
									    <img src="${odrmap.product_image}" width="100%"  />
									</div>
									<div style="width: 54%; padding-top: 5%;">
									    <ul class="list-unstyled">
									       <li><span class="li_style">제품 번호</span> : ${odrmap.fk_product_no}</li>
									       <li><span class="li_style">제품명</span> : ${odrmap.product_name}</li>
									       <li><span class="li_style">제품 색상</span> : ${fn:toUpperCase(odrmap.product_color)}</li>
									       <li><span class="li_style">제품 사이즈</span> : ${odrmap.product_size} mm</li>
									       <li><span class="li_style">주문 수량</span> : ${odrmap.order_count} 개</li>
									       <li><span class="li_style">제품 가격 (정가)</span> : <span class="font-weight-bold"><fmt:formatNumber value="${odrmap.order_price}" pattern="###,###" /></span> 원</li>
									       <li><span class="li_style">실 결제금액</span> : <span class="font-weight-bold"><fmt:formatNumber value="${odrmap.total_price}" pattern="###,###" /></span> 원</li>
									    </ul>
								    </div>
							    </div> 
							</td>
							<td align="center" style="font-weight: bold;">
							     <c:set var="su" value="${odrmap.order_count}" />
							     <c:set var="danga" value="${odrmap.order_price}" />
							     <c:set var="totalmoney" value="${su * danga}" />
								 <fmt:formatNumber value="${totalmoney}" pattern="###,###" /> 원
							</td>
							<td>
								<ul class="list-unstyled">
							       <li><span class="li_style">주문자 ID</span> : ${odrmap.fk_userid}</li>
							       <li><span class="li_style">연락처</span> : ${fn:substring(odrmap.delivery_mobile, 0, 3)}-${fn:substring(odrmap.delivery_mobile, 3, 7)}-${fn:substring(odrmap.delivery_mobile, 7, 11)}</li>
							       <li><span class="li_style">배송지</span> : 우편번호 [ ${fn:substring(odrmap.delivery_address, 0, 5)} ] <br>${fn:substring(odrmap.delivery_address, 5, 200)}</li>
							       <li><span class="li_style">배송 요청사항</span> : ${odrmap.delivery_comment}</li>
							       <li><span class="li_style">송장번호</span> : ${odrmap.delivery_invoice}</li>
								</ul>					
							</td>
						</tr>
					</c:forEach>
					</c:if>
					
			</table>
		</form>  
	</div> 
	 
	<%-- === 페이지바 === --%>
	<nav class="my-5">
        <div style='display:flex; width:80%;'>
    	   <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
    	</div>
    </nav>
 
</div>

<jsp:include page="footer.jsp"/>