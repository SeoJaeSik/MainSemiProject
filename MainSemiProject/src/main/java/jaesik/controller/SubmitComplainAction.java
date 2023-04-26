package jaesik.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import jaesik.model.BoardVO;
import jaesik.model.JS_InterMemberDAO;
import jaesik.model.JS_MemberDAO;

public class SubmitComplainAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();

		if ("POST".equalsIgnoreCase(method)) {
			
			String userid = request.getParameter("userid");
			String board_title = request.getParameter("board_title");
			String board_content = request.getParameter("board_content");
			
			JS_InterMemberDAO mdao = new JS_MemberDAO();
			boolean isUserExist = mdao.isUserExist(userid);
			
			String message = "";
			String loc = "";
			
			if (isUserExist) {
				
				BoardVO bvo = new BoardVO();
				board_content = board_content.replaceAll("<", "&lt;");
				board_content = board_content.replaceAll(">", "&gt;");
				
				bvo.setFk_userid(userid);
				bvo.setBoard_title(board_title);
				bvo.setBoard_content(board_content);
				
				int n = mdao.uploadBoard(bvo);
				
				if (n == 1) {
					message = "메시지가 성공적으로 전달되었습니다.";
					loc = request.getContextPath()+"/index.moc";
				}
				else {
					message = "메시지 전송 오류. 관리자에게 문의하세요.";
					loc = request.getContextPath()+"/index.moc";
				}
			
			}
			else {
				message = "존재하지않는 유저입니다. 회원가입 후 이용해주세요.";
				loc = request.getContextPath()+"/index.moc";
			}
			
			request.setAttribute("message", message);
            request.setAttribute("loc", loc);
			
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/jaesik/msg.jsp");
		}
		
	}

}
