package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.MemberVO;
import sukyung.model.*;

public class OrderListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
/*
		if(super.checkLogin(request)) { // 로그인한 경우
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String userid = request.getParameter("userid");
			
			if(loginuser.getUserid().equals(userid)) {
*/				// 로그인한 회원아이디와 GET 방식으로 넘어온 아이디가 같은지 확인
		String order_no = request.getParameter("order_no");
				
				InterProductDAO pdao = new ProductDAO();
				
				// 주문번호(order_no) 를 이용하여 주문정보(주문테이블, 배송테이블) 조회(select)
				Map<String, String> orderMap = pdao.showOrderList(order_no);
				request.setAttribute("orderMap", orderMap);

				// 주문번호(order_no) 를 이용하여 주문상세내역 정보(주문상세테이블, 상품테이블) 조회(select)
				List<OrderDetailVO> orderDetailList = pdao.showOrderDetailList(order_no);
				request.setAttribute("orderDetailList", orderDetailList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/sukyung/orderList.jsp");
				
/*			} // end of if(loginuser.getUserid().equals(userid))

		} // if(super.checkLogin(request)) 로그인한 경우
		
		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}
*/
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
