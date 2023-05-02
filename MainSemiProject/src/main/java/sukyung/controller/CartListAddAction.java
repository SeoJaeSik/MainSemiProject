package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import sujin.model.MemberVO;
import sukyung.model.*;

public class CartListAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) { // POST 방식
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String userid = loginuser.getUserid();
			String product_no = request.getParameter("product_no");

			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("product_no", product_no);
			
			// tbl_cart 테이블에서 cart_no 의 데이터행을 추가
			InterProductDAO pdao = new ProductDAO();
			int result = pdao.cartAdd(paraMap);

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