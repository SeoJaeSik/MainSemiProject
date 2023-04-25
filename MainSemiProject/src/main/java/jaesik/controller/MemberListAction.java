package jaesik.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.MemberVO;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if ( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
			// 관리자로만 로그인한 경우 일반유저와 로그아웃일때 url만 입력해서 들어오는 것을 막아야 한다.
		

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jaesik/memberList.jsp");
			
		}
		else {
			// 로그인을 안했거나 일반 사용자가 해당 url을 접속한 경우
			
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
		
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jaesik/msg.jsp");
		}
	}

}
