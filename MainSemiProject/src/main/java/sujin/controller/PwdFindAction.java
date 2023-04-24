package sujin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.controller.GoogleMail;
import sujin.model.*;

public class PwdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" 또는 "POST"

		if ("POST".equals(method)) {
			
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
		
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>(); 
			paraMap.put("userid", userid);
			paraMap.put("email", email);
			System.out.println("paraMap ? " + paraMap);
			boolean isUserExist = mdao.isUserExist(paraMap); // isUserExist : 입력한 아이디&이메일을 가진 회원이 존재하는지 알아보는 함수 

			boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도

			if (isUserExist) { // 회원으로 존재하는 경우

				// 비밀번호 변경가능한 링크를 사용자의 email 로 전송
				GoogleMail mail = new GoogleMail();
				
				try {
					
					mail.sendmail(email);
					sendMailSuccess = true; /* 메일 전송이 성공했음을 기록함 */
					
					// * 세션 불러오기
					HttpSession session = request.getSession();
					session.setAttribute("email", email);
					// -> 발급한 인증코드를 세션에 저장시킨다 (=> 그래서 다른 클래스에서도 꺼내어 사용할 수 있게 됨) !!!
					
				} catch (Exception e) { // * 메일 전송이 실패한 경우 *
					System.out.println("메일 전송이 실패함...");
					e.printStackTrace();
					sendMailSuccess = false; /* 메일 전송이 실패했음을 기록함(default 값이 false 이므로 쓸필요 없음) */
				}
				
				
			} // end of if 회원존재---------------------------------

			request.setAttribute("isUserExist", isUserExist); 			// 회원이 존재하는지 남김
			request.setAttribute("userid", userid);						// 아이디
			request.setAttribute("email", email);						// 이메일
			request.setAttribute("sendMailSuccess", sendMailSuccess);	// 메일전송여부

		} // end of "POST"방식-----------------------------

		
		// GET 이든 POST 이든 나와야 하는 공통부분 으로 pwdFind.jsp 에서 받아 사용한다
		request.setAttribute("method", method);
		System.out.println("비번찾기 action method? : " + method);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/sujin/login/pwdFind.jsp");

	}

}
