package jaesik.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.MemberVO;

public class ProductRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if ( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
			// 관리자로만 로그인한 경우 일반유저와 로그아웃일때 url만 입력해서 들어오는 것을 막아야 한다.
			
			String method = request.getMethod();
			
			if( !"POST".equalsIgnoreCase(method) ) {

//				// spec 목록을 조회해오기
//				InterProductDAO pdao = new ProductDAO();
//				List<SpecVO> specList = pdao.selectSpecList();
//				
//				request.setAttribute("specList", specList);
//				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jaesik/productRegister.jsp");
			}
			else {
				
				
				
			}
			
			
			
		}
		else {
			String message = "접근 불가합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}

}
