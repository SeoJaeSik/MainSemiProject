package sujin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.MemberVO;

public class MemberEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// ** 내정보(회원정보)를 수정하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		// 부모클래스에있는.로그인유무확인함수() 를 가져와 쓰겠다
		if(super.checkLogin(request)) { 
			// 1) 로그인을 했으면
			
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if( loginuser.getUserid().equals(userid) ) {
				// - 로그인한 사용자가 내정보를 수정하는 경우
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/sujin/member/memberEdit.jsp");
			}
			else {
				// - 로그인한 사용자가 다른 사용자의 정보를 수정하려고 시도하는 경우
				String message = "다른 사용자의 정보를 수정하려는 시도는 불가합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				super.setRedirect(false);
				super.setViewPage("/WEB-INF/sujin/msg.jsp");				
			}
		}
		else {
			// 2) 로그인을 안했으면 
			String message = "회원정보를 수정하기 위해서는 먼저 로그인 하세요.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/sujin/msg.jsp");
		}
		
	}

}
