package sujin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import sujin.model.*;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		// "POST" 로 들어왔을 때 입력한 값들을 map 에 저장해 찾으러간다
		if("POST".equals(method)) {
			
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>(); 
			paraMap.put("name", name);
			paraMap.put("email", email);
			
			String userid = mdao.findUserid(paraMap); // 매개변수 2개를 Map 으로 묶어 보내는 함수 findUserid() 호출 
		
			if(userid != null ) {
				request.setAttribute("userid", userid);
			}
			else {
				request.setAttribute("userid", "존재하지 않습니다.");
			}
			
			request.setAttribute("name", name);
			request.setAttribute("email", email);
			
		}//end of "POST"방식--------------------------------------

		
		// GET 이든 POST 이든 나와야 하는 공통부분으로 idFind.jsp 에서 받아 사용한다
		request.setAttribute("method", method);
		
		// => get 방식일때는 form 태그만 보여줄것이다.
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/sujin/login/idFind.jsp");
	}

}
