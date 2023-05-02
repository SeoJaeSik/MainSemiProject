package sukyung.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.MemberVO;
import sukyung.model.*;

public class CartListOptionEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(super.checkLogin(request)) { // 로그인한 경우
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String userid = loginuser.getUserid(); // 로그인한 회원아이디

			String cart_no = request.getParameter("cart_no");
			
			// GET 방식으로 넘어온 cart_no 이 로그인한 회원아이디의 cart_no 인지 확인하기
			InterProductDAO pdao = new ProductDAO();
			List<CartVO> cartList = pdao.showCartList(userid);
			
			boolean isExist_cartno = false;
			
			ProductVO pvo = null;
			
			for(CartVO cvo : cartList) {
				if(Integer.parseInt(cart_no) == cvo.getCart_no()) {
					isExist_cartno = true;
					
					pvo = new ProductVO();
					pvo.setProduct_no(cvo.getPvo().getProduct_no());
					pvo.setProduct_name(cvo.getPvo().getProduct_name());
					pvo.setProduct_image(cvo.getPvo().getProduct_image());
					pvo.setProduct_color(cvo.getPvo().getProduct_color());
					pvo.setProduct_size(cvo.getPvo().getProduct_size());
					break;
				}
			} // end of for
			
			if(isExist_cartno) { // 로그인한 회원의 cart_no 가 맞는경우

				request.setAttribute("pvo", pvo);

				// 특정 제품의 사이즈 조회
				List<ProductVO> sizeList = pdao.selectSizeList(pvo);
				request.setAttribute("sizeList", sizeList);

				// 특정 제품의 색상(이미지) 조회
				List<ProductVO> colorList = pdao.selectColorList(pvo);
				request.setAttribute("colorList", colorList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/sukyung/cartListOptionEdit.jsp");
			}
			else { // 사용자가 임의로 입력한 cart_no 일 경우
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/index.moc");
			}

		} // if(super.checkLogin(request)) 로그인한 경우
		
		else { // 로그인을 안한 경우
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/login/login.moc");
		}
		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}