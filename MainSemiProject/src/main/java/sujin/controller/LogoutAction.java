package sujin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class LogoutAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그아웃 처리하기	
		HttpSession session = request.getSession(); // .getSession() : 세션 불러오기
		
		// WAS의 메모리(RAM)상에서 세션을 통째로 삭제하기
		session.invalidate(); /* 세션에 올라온것 자체를 없애줌 */
		
		super.setRedirect(true);
		super.setViewPage(request.getContextPath()+"/index.moc");
	}

}
