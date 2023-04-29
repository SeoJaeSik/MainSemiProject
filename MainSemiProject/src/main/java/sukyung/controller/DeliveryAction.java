package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import common.controller.AbstractController;

public class DeliveryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) { // 로그인한 경우
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST방식

				// 주문정보 Map 에 저장하기
				Map<String, Object> orderMap = new HashMap<>();

			// *** 1. 장바구니에서 결제 - CartListFrm 에 있는 주문정보 Map 에 저장하기
	     		String cart_no = request.getParameter("cart_no"); // 장바구니번호(배열)
			
				
				if(cart_no != null) {
					String product_no = request.getParameter("product_no"); 		 // 제품번호(배열)
		     		String order_count = request.getParameter("cart_product_count"); // 주문수량(배열)
		     		String order_price = request.getParameter("order_price"); 		 // 제품별 주문금액(배열)
					String total_price = request.getParameter("total_price");   	 // 총 주문금액
					String delivery_fee = request.getParameter("delivery_fee");		 // 배송비

					orderMap.put("arr_product_no", product_no.split("\\,"));
					orderMap.put("arr_order_count", order_count.split("\\,"));
					orderMap.put("arr_order_price", order_price.split("\\,"));
					orderMap.put("arr_cart_no", cart_no.split("\\,"));
					orderMap.put("total_price", total_price);
					orderMap.put("delivery_fee", delivery_fee);
				}

			// *** 2. 제품상세에서 바로결제
				else { // cart_no 이 null 이면
					String product_no = request.getParameter("product_no");       // 제품번호
		     		String order_count = request.getParameter("order_count");     // 주문수량
		     		String product_price = request.getParameter("product_price"); // 제품금액
		     		int order_price = Integer.parseInt(order_count)*Integer.parseInt(product_price); // 주문금액
					String delivery_fee = request.getParameter("delivery_fee");	  // 배송비
					
					orderMap.put("product_no", product_no);
					orderMap.put("order_count", order_count);
					orderMap.put("order_price", order_price);
					orderMap.put("total_price", order_price); // total_price = order_price
					orderMap.put("delivery_fee", delivery_fee);
				}
				
				request.setAttribute("orderMap", orderMap);

				super.setRedirect(false);
				super.setViewPage("/WEB-INF/sukyung/delivery.jsp");

			} // end of POST방식
			
			else { // GET방식 ==> 장바구니 페이지로 이동
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/shop/cartList.up");
			}
		}
		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
