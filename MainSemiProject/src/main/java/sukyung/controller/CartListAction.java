package sukyung.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.MemberVO;
import sukyung.model.*;

public class CartListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(super.checkLogin(request)) { // 로그인한 경우
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String userid = loginuser.getUserid(); // 로그인한 회원아이디

			InterProductDAO pdao = new ProductDAO();
			int cartCount = pdao.cartCount(userid); // 로그인한 회원이 장바구니에 담은 상품수량
			loginuser.setCartCount(cartCount); // 세션에 저장된 로그인회원의 상품수량 업데이트
			
			List<CartVO> cartList = pdao.showCartList(userid);
			request.setAttribute("cartList", cartList);
			
			String buyer_type_no = loginuser.getGender() + "00"; // 고객유형코드 "100" 또는 "200"
			
			ProductVO rndpvo = pdao.showRandomItem(buyer_type_no);
			request.setAttribute("rndpvo", rndpvo);

			// 특정 제품의 사이즈 조회
			List<ProductVO> sizeList = pdao.selectSizeList(rndpvo);
			request.setAttribute("sizeList", sizeList);

			// 특정 제품의 색상(이미지) 조회
			List<ProductVO> colorList = pdao.selectColorList(rndpvo);
			request.setAttribute("colorList", colorList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/sukyung/cartList.jsp");
		}
		
		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
