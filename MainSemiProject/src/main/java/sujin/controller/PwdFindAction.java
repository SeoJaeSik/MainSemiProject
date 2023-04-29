package sujin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.*;

public class PwdFindAction extends AbstractController {

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" 또는 "POST"

		if ("POST".equalsIgnoreCase(method)) {
			
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
		//	System.out.println("userid : " + userid + ", email : " + email);
		//	form 에서 값을 넘기받기위해서는 name 을 꼭!!! 잡아줘야함
		
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>(); 
			paraMap.put("userid", userid);
			paraMap.put("email", email);
			
			boolean isUserExist = mdao.isUserExist(paraMap); // isUserExist : 입력한 아이디&이메일을 가진 회원이 존재한다면 true, 아니면 false
			boolean sendMailSuccess = false; 				 // sendMailSuccess : 메일이 정상적으로 전송됐다면 true, 실패하면 false
			
			if (isUserExist) { // 회원으로 존재하는 경우

				// == 비밀번호 변경가능한 링크를 사용자의 email 로 전송 ==
				GoogleMail mail = new GoogleMail();
				
				// -- 이메일에 보낼 링크에 필요한 사용자의 정보얻어오는 것 --
				MemberVO mbrforpwdReset = mdao.selectmbrforpwdReset(paraMap);
				System.out.println("mbrforpwdReset 확인 : " + mbrforpwdReset);
				
				try {
					
					StringBuilder sb = new StringBuilder();
					sb.append("<div style='background-color:#fefce7; padding: 30px;'>");
					
					sb.append("	<div>");
					sb.append("		<a style='display:block; color:black; text-align:center; line-height:40px; font-size: 30px; font-weight: bold; text-decoration: none !important; text-underline: none;' href='http://localhost:9090/SemiProject_MOSACOYA/index.moc'>MOSACOYA<br>"); 	
					sb.append("		OY! LET'S TRY THIS AGAIN!</a>");
					sb.append("	</div>");
					
					sb.append("	<div>");
					sb.append("		<small style='text-align:left;'>Hiya, <br> ");
					sb.append("		Let’s reset your MOSCOT password by clicking the link below: </small><br>");
					
					sb.append("		<a style='display:block; color:black; text-align:center; background-color:#fdd007; width:350px; height:50px; font-size: 15pt; text-decoration: none !important; text-underline: none;' href='http://localhost:9090/SemiProject_MOSACOYA/login/pwdUpdateEnd.moc?userid=" + mbrforpwdReset.getUserid() + "&email=" + mbrforpwdReset.getEmail() + "'>RESET PASSWORD</a>");
					
					sb.append("		<small style='text-align:left;'>If you didn’t request a password reset, just toss this mail in the trash!<br> ");
					sb.append("		– The MOSACOYA Family</small>");
					sb.append("	</div>");
					
					sb.append("</div>");
					
					String emailContents = sb.toString();
					System.out.println("emailContents 확인 : " + emailContents);
					
					mail.sendmail(email, emailContents);
					sendMailSuccess = true; // 메일 전송이 성공했음을 기록함 
					System.out.println("sendMailSuccess 확인 : " + sendMailSuccess);
					
					// * 세션 불러오기 -> 현재 비밀번호 찾기에서 입력한 이메일을 세션에 저장시킨다
					HttpSession session = request.getSession();
					session.setAttribute("pwdfindsend_email", email);
					System.out.println("email 확인 : " + email);
					
				} catch (Exception e) { // 메일 전송이 실패한 경우 
					System.out.println("메일 전송이 실패함...");
					e.printStackTrace();
					sendMailSuccess = false; // 메일 전송이 실패했음을 기록함(default 값이 false 이므로 쓸필요 없음) 
				}
				
				
			} // end of if 회원존재---------------------------------

			request.setAttribute("isUserExist", isUserExist); 			// 회원이 존재하는지 남김 (있으면 있습니다, 없으면 없습니다 나옴)
			request.setAttribute("userid", userid);						// 아이디
			request.setAttribute("email", email);						// 이메일
			request.setAttribute("sendMailSuccess", sendMailSuccess);	// 메일전송여부 ==> 근데 이 4가지 굳이 해야하나???? 어디다 쓰지??

		} // end of "POST"방식-----------------------------

		
		// GET 이든 POST 이든 나와야 하는 공통부분 으로 pwdFind.jsp 에서 받아 사용한다
		request.setAttribute("method", method);

		super.setRedirect(false);
		super.setViewPage("/WEB-INF/sujin/login/pwdFind.jsp");

	}

}
