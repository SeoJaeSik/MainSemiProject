package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import sukyung.model.InterProductDAO;
import sukyung.model.ProductDAO;

public class OrderAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) { // 로그인한 경우
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST방식

				// 주문정보 Map 에 저장하기
				Map<String, Object> prodMap = new HashMap<>();

			// *** 1. 장바구니에서 결제 - CartListFrm 에 있는 주문정보 Map 에 저장하기
	     		String join_cart_no = request.getParameter("join_cart_no"); // 장바구니번호(문자열)
			
				if(join_cart_no != null) {
					String join_product_no = request.getParameter("join_product_no");	// 제품번호(문자열)
		     		String join_order_count = request.getParameter("join_order_count"); // 주문수량(문자열)

					prodMap.put("join_product_no", join_product_no);
					prodMap.put("join_order_count", join_order_count);
					prodMap.put("join_cart_no", join_cart_no);
				}

			// *** 2. 제품상세에서 바로결제
				else { // join_cart_no 이 null 이면
					String product_name = request.getParameter("product_name"); 			// 제품명
					String product_color = request.getParameter("product_color"); 			// 제품색상
					String product_size = request.getParameter("product_size"); 			// 제품사이즈
					String cart_product_count = request.getParameter("cart_product_count"); // 주문수량

					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("product_name", product_name);
					paraMap.put("product_color", product_color);
					paraMap.put("product_size", product_size);
					
					// tbl_product 테이블에서 제품명, 제품색상, 제품사이즈를 이용하여 product_no 를 select
					InterProductDAO pdao = new ProductDAO();
					String product_no = pdao.selectProduct_no(paraMap);

		     		prodMap.put("product_no", product_no);
		     		prodMap.put("order_count", cart_product_count);
				}
				
				HttpSession session = request.getSession();
				session.setAttribute("prodMap", prodMap); // sessionScope 에 저장

				int isSuccess = 0;
				if(prodMap.get("join_product_no") != null || prodMap.get("product_no") != null) { 
					// 주문정보가 제대로 저장된 경우
					isSuccess = 1;
				}
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("isSuccess", isSuccess);
				
				String json = jsonObj.toString();
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/sukyung/jsonview.jsp");

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
