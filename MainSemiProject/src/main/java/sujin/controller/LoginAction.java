package sujin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.InterMemberDAO;
import sujin.model.MemberDAO;
import sujin.model.MemberVO;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// loginFrm 폼태그에서 post 로 보냈으니까 무조건 post 로만 받을 수 있음
		
		String method = request.getMethod();
		
		if("GET".equals(method)) {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/sujin/login/login.jsp");
		}
		
		else {
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
			//	System.out.println(">>> 확인용 로그인한 사용자명 loginuser.getName() : " + loginuser.getName());
			//  >>> 확인용 로그인한 사용자명 loginuser.getName() : 용수진
				
				// > WAS 메모리 ram 에 생성되어져 있는 session 을 불러오는 것이다. 
				HttpSession session = request.getSession();
				
				session.setAttribute("loginuser", loginuser); // session 에 로그인된 사용자를 "loginuser" 로 저장
			
				if( loginuser.isRequirePwdChange() ) {
					System.out.println();
					String message = "비밀번호를 변경한지 3개월이 지났습니다. 암호를 변경하세요.";
					String loc = request.getContextPath()+"/index.moc"; /* 메시지 띄우고 마이페이지로 간다 */
					// 원래는 위와같이 index.moc 이 아니라 사용자의 암호를 변경해주는 페이지로 잡아주어야 한다. *[플젝에서적용하기]*
	
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					
				}
				else {
					// 비밀번호를 변경한지 3개월 이내인 경우, 시작페이지로 간다.
					
					// true 는 페이지 이동을 시킨다
					super.setRedirect(true);
					
					// 로그인을 하면 시작페이지(index.moc)로 가는 것이 아니라 로그인을 시도하려고 머물렀던 그 페이지로 돌아가기 위한 것이다.
					// --- 부모 abstract 에서 setattribute 해온것을 get 해온다! ---
					String goBackURL = (String) session.getAttribute("goBackURL");
					// -> goBackURL 은 /shop/prodView.up?pnum=5 또는 null 이 들어올 수도 있다.
					
					if(goBackURL != null) { // => 세션에 goBackURL 정보가 있다면 그곳으로 가고
						super.setViewPage(request.getContextPath() + goBackURL);
					}
					else {					// => 세션에 goBackURL 정보가 없다면 시작페이지로 간다
						super.setViewPage(request.getContextPath()+"/index.moc");
					}
				}
			
			}//end of (loginuser != null)--------------------
	
			else {
				String message = "로그인 실패";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			
			}//end of (loginuser == null)--------------------
	 
		}// end of if~else---------------------------
		
	}//end of execute--------------------------
	
}
