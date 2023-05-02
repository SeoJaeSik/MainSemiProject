package jaesik.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import jaesik.model.JS_InterMemberDAO;
import jaesik.model.JS_MemberDAO;
import sujin.model.MemberVO;

public class MemberOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if ( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
			
			String userid = request.getParameter("userid");
			JS_InterMemberDAO mdao = new JS_MemberDAO();
			MemberVO mvo = mdao.memberOneDetailAction(userid);
			
			request.setAttribute("mvo", mvo);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jaesik/memberOneDetailAction.jsp");
			
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