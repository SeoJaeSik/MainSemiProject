package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.MemberVO;
import sukyung.model.*;

public class PaymentAction extends AbstractController {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) { // 로그인한 경우
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST방식

			// *** 1. 결제정보 넘겨주기
				
				// sessionScope 에 저장된 주문정보 prodMap 받아오기
				HttpSession session = request.getSession();
				Map<String, Object> prodMap = (Map<String, Object>) session.getAttribute("prodMap");

				InterProductDAO pdao = new ProductDAO();
	     		Map<String, String> paraMap = null;
					     		
				// 총 주문금액 및 배송비
				int total_price = 0;     // 총 주문금액
				int delivery_fee = 3000; // 배송비
	     		
	     		List<CartVO> orderList = new ArrayList<>();

				// *** 1) 장바구니에서 결제 - CartListFrm 에 있는 주문정보가 담긴 prodMap (배열 포함)
				if(prodMap.get("join_cart_no") != null) { 
					// 제품번호, 주문수량, 장바구니번호 - 조인한 문자열을 배열로 만들어준다.
					String[] arr_product_no = ((String) prodMap.get("join_product_no")).split("\\,");   // 제품번호
		     		String[] arr_order_count = ((String) prodMap.get("join_order_count")).split("\\,"); // 주문수량
		     		String[] arr_cart_no = ((String) prodMap.get("join_cart_no")).split("\\,"); 		// 장바구니번호
		     		String join_order_price = "";
		     		
					for(int i=0; i<arr_cart_no.length; i++) {
						paraMap = new HashMap<>();
						paraMap.put("product_no", arr_product_no[i]);
						paraMap.put("order_count", arr_order_count[i]);	
						paraMap.put("cart_no", arr_cart_no[i]);	
						
						// product_no 로 제품정보(주문정보 포함) 알아오는 메소드 호출
						CartVO cvo = pdao.showProdInfo(paraMap);
						orderList.add(cvo);
						
						total_price += cvo.getPvo().getOrder_price(); // 총 주문금액
						
						// 제품별 주문금액 세션에 저장하기
						String str_add = (i != arr_cart_no.length-1)? ",":"";
						join_order_price += cvo.getPvo().getOrder_price()+str_add; // 제품별 주문금액(문자열)
					} // end of for
					
					session.setAttribute("join_order_price", join_order_price);
				}

				// *** 2) 제품상세에서 바로결제 - 제품정보가 담긴 prodMap(배열 없음)
				else { // arr_cart_no 이 null 이면
					String product_no = (String) prodMap.get("product_no");   // 제품번호
		     		String order_count = (String) prodMap.get("order_count"); // 주문수량

					paraMap = new HashMap<>();
					paraMap.put("product_no", product_no);
					paraMap.put("order_count", order_count);	
					
					// product_no 로 제품정보(주문정보 포함) 알아오는 메소드 호출
					CartVO cvo = pdao.showProdInfo(paraMap);
					orderList.add(cvo);

		     		System.out.println("확인용 cvo.getPvo().getProduct_no() : " + cvo.getPvo().getProduct_no());
		     		
					total_price += cvo.getPvo().getOrder_price(); 	 // 총 주문금액
					
					String order_price = String.valueOf(cvo.getPvo().getOrder_price()); // 제품별 주문금액
					session.setAttribute("order_price", order_price);
				}

				if(total_price >= 50000) { // 총 주문금액 5만원 이상이면 배송비 무료
					delivery_fee = 0;
				}
	     		System.out.println("확인용 orderList : " + orderList);

				request.setAttribute("orderList", orderList);
				request.setAttribute("total_price", total_price);
	     		request.setAttribute("delivery_fee", delivery_fee);

	     		
			// *** 2. 로그인한회원 정보 및 배송정보 세션에 저장하기
	     		String delivery_name = request.getParameter("delivery_name");		// 수령자성명
	     		String delivery_mobile = request.getParameter("delivery_mobile");	// 수령자연락처
	     		String delivery_address = request.getParameter("delivery_address"); // 수령자주소(우편번호, 주소, 참고주소, 상세주소)
	     		String delivery_comment = request.getParameter("delivery_comment"); // 요청사항
	     		
	     		Map<String, String> shipMap = new HashMap<>();
	     		shipMap.put("delivery_name", delivery_name);
	     		shipMap.put("delivery_mobile", delivery_mobile);
	     		shipMap.put("delivery_address", delivery_address);
	     		shipMap.put("delivery_comment", delivery_comment);

	     		session.setAttribute("shipMap", shipMap); // sessionScope 에 저장

	     	// *** 3. 로그인한회원의 쿠폰 조회하는 메소드 호출
	     		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	     		String userid = loginuser.getUserid();
	     		List<Map<String, String>> couponList = pdao.showUserCoupon(userid);
	     		
	     		request.setAttribute("couponList", couponList);
	     		
	     		super.setRedirect(false);
				super.setViewPage("/WEB-INF/sukyung/payment.jsp");

			} // end of POST방식
			
			else { // GET방식 ==> 장바구니 페이지로 이동
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/shop/cartList.moc");
			}
		}
		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}

	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
