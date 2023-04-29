package sujin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import sujin.model.*;

public class PwdUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String method = request.getMethod();  // "GET" 또는 "POST"
		
		String userid = request.getParameter("userid"); /* 넘어온 userid */
		
		//*** [GET방식일때 form 만 보이다가 버튼을 클릭해 POST 방식으로 암호를 변경하면 변경된게 DB 에도 적용되게 하고 메인으로 로그인창으로 간다 ]
		
		if("POST".equals(method)) { 
			// 암호변경하기 버튼을 클릭한 경우
			
			String pwd = request.getParameter("pwd"); /* 넘어온 새암호 */
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pwd", pwd);
			paraMap.put("userid", userid);
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.pwdUpdate(paraMap);
			
			request.setAttribute("n", n); /* 성공이라면 1 이 나옴 */			
		}
		
		// GET 이든 POST 이든 나와야 하는 공통부분 으로 pwdUpdateEnd.jsp 에서 받아 사용한다
		
		request.setAttribute("method", method);
		request.setAttribute("userid", userid);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/sujin/login/pwdUpdateEnd.jsp");
		
	}

}
