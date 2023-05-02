package sukyung.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.MemberVO;

public class PaymentTryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(super.checkLogin(request)) { // 로그인한 경우
		
			// 결제정보
			String payment_name = request.getParameter("payment_name"); // 결제명
			String total_price = request.getParameter("total_price");   // 결제금액
			
			request.setAttribute("payment_name", payment_name); 
			request.setAttribute("total_price", Integer.parseInt(total_price)); 

			// buyer(구매자) 정보
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			request.setAttribute("email", loginuser.getEmail());   // buyer_email
			request.setAttribute("name", loginuser.getName());     // buyer_name
			request.setAttribute("mobile", loginuser.getMobile()); // buyer_tel
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/sukyung/paymentGateway.jsp");
			
		}
		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
