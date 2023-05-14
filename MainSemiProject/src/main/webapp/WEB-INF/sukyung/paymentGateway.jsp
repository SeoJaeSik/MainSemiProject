<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<script type="text/javascript">

$(document).ready(function() {
   var IMP = window.IMP;     // 생략가능
   IMP.init('imp31465425');  // 중요!!  아임포트에 가입시 부여받은 "가맹점 식별코드". 

   // 결제요청하기
   IMP.request_pay({
       pg : 'html5_inicis', // 결제방식 PG사 구분
       pay_method : 'card',	// 결제 수단
       merchant_uid : 'merchant_' + new Date().getTime(), // 가맹점에서 생성/관리하는 고유 주문번호
       name : '${requestScope.payment_name}', // 결제명
       amount : 100, // 결제금액 number 타입
       buyer_email : '${requestScope.email}', // 구매자 email
       buyer_name : '${requestScope.name}',	  // 구매자 이름 
       buyer_tel : '${requestScope.mobile}',  // 구매자 전화번호
       buyer_addr : '',  
       buyer_postcode : '',
       m_redirect_url : ''  
   }, function(rsp) {

		if ( rsp.success ) { // PC 데스크탑용
			window.opener.goPaymentEnd();
			self.close(); // 자신의 팝업창(결제팝업창)을 닫는다.
		} else {
			alert("결제 중 오류가 발생하였습니다.");
			self.close(); // 자신의 팝업창(결제팝업창)을 닫는다.
		}

   }); // end of IMP.request_pay({})

}); // end of $(document).ready()-----------------------------

</script>
</head>	

<body>
</body>
</html>
