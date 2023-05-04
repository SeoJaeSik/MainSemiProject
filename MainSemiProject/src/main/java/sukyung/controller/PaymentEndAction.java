package sukyung.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import sujin.model.MemberVO;
import sukyung.model.*;

public class PaymentEndAction extends AbstractController {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(super.checkLogin(request)) { // 로그인한 경우
			
			String method = request. getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST 방식 ==> 트랜잭션

				HttpSession session = request.getSession();
				
			// *** 1. AJAX 에서 넘어오는 정보 받기
				String delivery_fee = request.getParameter("delivery_fee"); 	// 배송비
				String coupon_no = request.getParameter("coupon_no"); 			// 쿠폰번호(쿠폰사용하지 않으면 null)
				String point_redeem = request.getParameter("point_redeem"); 	// 포인트 사용금액
				String point_saveup = request.getParameter("point_saveup"); 	// 포인트 적립금액
				String total_price = request.getParameter("total_price");   	// 결제금액
				String discount_price = request.getParameter("discount_price"); // 결제금액
								
			//////////////////////////////////////////////////////////////////////////////////////////////////////////

			// *** 2. 트랜잭션
				InterProductDAO pdao = new ProductDAO();
				Map<String, Object> paraMap = new HashMap<>(); // 트랜잭션 DAO 에 보낼 map
				
				Map<String, Object> prodMap = (Map<String, Object>) session.getAttribute("prodMap");

			// 1) 주문 테이블(tbl_order) - insert 주문번호(생성), 회원아이디(fk), 배송비, 결제금액
				// 주문번호 오늘날짜(8자리) + 0001 ex) 20230501 0001, 20230501 0002
				// 주문날짜 orderdate 가 sysdate 인 주문들 중 가장 마지막에 주문된 주문번호 알아오기
				Date now = new Date();
				SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd");
				String today = smdatefm.format(now);
				String order_no = today+pdao.getOrder_no(); // 주문번호 ex) 202305010001
				
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				paraMap.put("order_no", order_no);			   // 주문번호
				paraMap.put("userid", loginuser.getUserid());  // 회원아이디
				paraMap.put("delivery_fee", delivery_fee);     // 배송비
				paraMap.put("total_price", total_price);       // 결제금액
				paraMap.put("discount_price", discount_price); // 할인받은금액
				
				
			// 2) 주문상세 테이블(tbl_order_detail) - insert 주문상세일련번호(생성), 제품번호(fk), 주문번호(fk), 주문수량, 제품별 주문금액
				// 주문상세일련번호 - 주문번호_1...10
				
			// === 장바구니에서 결제하는 경우
			// 3) 장바구니 테이블(tbl_cart) - delete 결제된 장바구니 데이터 행 삭제
				if(prodMap.get("join_cart_no") != null) { 
					String[] arr_product_no = ((String) prodMap.get("join_product_no")).split("\\,");   // 제품번호
		     		String[] arr_order_count = ((String) prodMap.get("join_order_count")).split("\\,"); // 주문수량
		     		String[] arr_order_price = ((String) session.getAttribute("join_order_price")).split("\\,"); // 제품별 주문금액
		     		String join_cart_no = (String) prodMap.get("join_cart_no"); 						// 장바구니번호
		     		
					paraMap.put("arr_product_no", arr_product_no);   // 제품번호
					paraMap.put("arr_order_count", arr_order_count); // 주문수량
					paraMap.put("arr_order_price", arr_order_price); // 제품별 주문금액
					paraMap.put("join_cart_no", join_cart_no); 		 // 장바구니번호
				}
				
			// === 제품상세에서 바로결제하는 경우
				else {
					String product_no = (String) prodMap.get("product_no");   // 제품번호
		     		String order_count = (String) prodMap.get("order_count"); // 주문수량
		     		String order_price = (String) session.getAttribute("order_price"); // 주문금액
		     		
					paraMap.put("product_no", product_no);   // 제품번호
					paraMap.put("order_count", order_count); // 주문수량
					paraMap.put("order_price", order_price); // 주문금액
				}
				
	     		
			// 4) 제품 테이블(tbl_product) - update 주문수량 증가, 재고수량 감소 - ProductDAO 메소드에서 처리
				
			// 5) 회원 테이블(tbl_member) - update 회원아이디, 포인트 차감, 포인트 적립
				paraMap.put("point_redeem", point_redeem); // 포인트 사용금액
				paraMap.put("point_saveup", point_saveup); // 포인트 적립금액
				
			// 6) 쿠폰 테이블(tbl_user_coupon) - update 회원아이디(fk), 쿠폰번호, 쿠폰사용여부
				if(coupon_no != null) {
					paraMap.put("coupon_no", coupon_no); // 쿠폰번호(쿠폰사용하지 않으면 null)
				}

			// 7) 배송 테이블(tbl_delivery) - insert 주문번호(생성), 배송정보
				Map<String, String> shipMap = (Map<String, String>) session.getAttribute("shipMap");
				
	     		// 송장번호 랜덤 생성하기 ==> 4자리 - 4자리 - 4자리 - 4자리
				Random rnd = new Random();
				String delivery_invoice = "";
				for(int i=1; i<20; i++) { // 숫자 0 부터 9 까지 랜덤하게 1개를 만든다.
					if(i%5 == 0) {
						delivery_invoice += "-";
					}
					else {
						int rndnum = rnd.nextInt(9-0+1)+0;
						delivery_invoice += rndnum;
					}
				} // end of for
	     		
	     		paraMap.put("delivery_name", shipMap.get("delivery_name"));		  // 수령자성명
	     		paraMap.put("delivery_mobile", shipMap.get("delivery_mobile"));   // 수령자연락처
	     		paraMap.put("delivery_address", shipMap.get("delivery_address")); // 수령자주소(우편번호, 주소, 참고주소, 상세주소)
	     		paraMap.put("delivery_comment", shipMap.get("delivery_comment")); // 요청사항
	     		paraMap.put("delivery_invoice", delivery_invoice);				  // 송장번호
	     		
			// 8) 트랜잭션 처리해주는 메소드 호출
				if(pdao.paymentEnd(paraMap)) {
				// *** 3. 트랜잭션 후 세션 재설정 - 회원 포인트, 장바구니수량
					// 회원의 포인트 = 보유포인트 - 포인트사용금액 + 포인트적립금액
					loginuser.setPoint((loginuser.getPoint() - Integer.parseInt(point_redeem) + Integer.parseInt(point_saveup)));
					loginuser.setCartCount(pdao.cartCount(loginuser.getUserid()));
					
				} // 트랜잭션 성공
				
			// *** 4. AJAX 로 JSON 결과 넘겨주기	
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("order_no", order_no);
				
				String json = jsonObj.toString();
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/sukyung/jsonview.jsp");
			
			} // end of POST
		}
		
		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
