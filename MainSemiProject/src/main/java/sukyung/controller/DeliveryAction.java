package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class DeliveryAction extends AbstractController {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) { // 로그인한 경우

			HttpSession session = request.getSession();
			Map<String, Object> prodMap = (Map<String, Object>) session.getAttribute("prodMap");
			
			// sessionScope 에 prodMap(주문할 제품정보) 가 있을 경우
			if(prodMap != null) {
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/sukyung/delivery.jsp");
			}
			else { // 사용자가 주문할 제품정보를 체크하지 않고 바로 URL을 입력하여 들어온 경우
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/shop/cartList.moc"); // 장바구니로 이동
			}
		}
		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
