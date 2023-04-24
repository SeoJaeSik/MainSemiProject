package sujin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.*;

public class MyaccountAction extends AbstractController {

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// loginFrm 폼태그에서 post 로 보냈으니까 무조건 post 로만 받을 수 있음
		
		String method = request.getMethod();
		
	/*	if(!"POST".equals(method)) {
			// POST 방식으로 넘어온 것이 아니라 주소창에 get 방식으로 아이디&비번을 입력한 경우
			
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()"; 
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;  // execute() 메소드 종료
		}
	*/	
		// POST 방식으로 넘어온 것이라면(사용자 아이디/비밀번호/접속IP주소),
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String clientip = request.getRemoteAddr();
		
	//	System.out.println("~~~ 확인용 userid: " + userid + ", pwd: " + pwd + ", clientip: " + clientip);
		// ~~~ 확인용 userid: "sudin", pwd: "qwer1234!", clientip: 127.0.0.1
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid",userid);
		paraMap.put("pwd",pwd);
		paraMap.put("clientip",clientip);
		
		InterMemberDAO mdao = new MemberDAO();
		
		MemberVO loginuser = mdao.selectOneMember(paraMap);
	//	System.out.println("나와라 loginuser : " + loginuser);
	//	나와라 loginuser : sujin.model.MemberVO@5c9f0728	
		
		if(loginuser != null) { // DB 에 있는데, 
			
			// 1) 휴면계정이라면
			if(loginuser.getIdle() == 1) {
				String message = "로그인을 한지 1년이 지나 휴면계정으로 전환되었습니다. 관리자에게 문의바랍니다.";
				String loc = request.getContextPath() + "/index.moc";   
				/* 원래는 위와같이 index.up 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다. 플젝에서 그렇게 하시오~ */
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return; // 메소드 종료
			}
			
			// 2) 찐 로그인 성공
		//	System.out.println(">>> 확인용 로그인한 사용자명 : " + loginuser.getName());
		//  >>> 확인용 로그인한 사용자명 : 용수진
			
			// > WAS 메모리 ram 에 생성되어져 있는 session 을 불러오는 것이다. 
			HttpSession session = request.getSession();
			
			session.setAttribute("loginuser", loginuser); // session 에 로그인된 사용자를 "loginuser" 로 저장
		
			if( loginuser.isRequirePwdChange() ) {
				System.out.println();
				String message = "비밀번호를 변경한지 3개월이 지났습니다. 암호를 변경하세요.";
				String loc = request.getContextPath()+"/login/loginaftermove.moc"; /* 메시지 띄우고 마이페이지로 간다 */
				// 원래는 위와같이 index.up 이 아니라 사용자의 암호를 변경해주는 페이지로 잡아주어야 한다. *[플젝에서적용하기]*

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			else {
				// 비밀번호를 변경한지 3개월 이내인 경우, 마이페이지로 간다.
			//	System.out.println("마이페이지로 출발은 한다..!!");
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/login/loginaftermove.moc");
			}
			
		}
		else {
			String message = "로그인 실패";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}
