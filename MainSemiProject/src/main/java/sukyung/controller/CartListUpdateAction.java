package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import sukyung.model.*;

public class CartListUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) { // POST 방식
			
			String cart_no = request.getParameter("cart_no");
			String cart_product_count = request.getParameter("cart_product_count");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("cart_no", cart_no);
			paraMap.put("cart_product_count", cart_product_count);
			
			// tbl_cart 테이블에서 cart_no 의 수량을 cart_product_count 으로 변경
			InterProductDAO pdao = new ProductDAO();
			int result = pdao.cartCountUpdate(paraMap);
			
			JSONObject jsonObj = new JSONObject(); 
			jsonObj.put("result", result); 

			String json = jsonObj.toString();
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/sukyung/jsonview.jsp");
		
		}
		else { // GET 방식
			String message = "비정상적인 경로로 접근하였습니다.";
			String loc = request.getContextPath()+"/index.moc";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/sukyung/msg.jsp");
		}
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}