package sujin.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import sujin.model.*;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equals(method)) {
			super.setRedirect(false); /* 꼭 써서 회원가입 끝나고 true 로 바뀐것을 다시 false 로 바꿔줌 */
			super.setViewPage("/WEB-INF/sujin/login/memberRegister.jsp");	
		}
		else { // 어떤 페이지를 보여주는 것이 아니라 DB 에 받아온 데이터를 넣어주기 위한 곳
						
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String extraAddress = request.getParameter("extraAddress");
			String gender = request.getParameter("gender");
			
			String birthyyyy = request.getParameter("birthyyyy");
			String birthmm = request.getParameter("birthmm");
			String birthdd = request.getParameter("birthdd"); 
			
			String mobile = hp1 + hp2 + hp3;                 // 01012345678
			String birthday = birthyyyy + birthmm + birthdd; // 19930425
			
			// 파라미터가 있는 생성자 생성
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress, gender, birthday);
			
			
			// #### 회원가입이 성공되어지면 자동으로 로그인 되도록 하겠다. #### //
			try {
				
				InterMemberDAO mdao = new MemberDAO();
				int n = mdao.registerMember(member);
				
				if(n==1) { // 회원이 정상적으로 가입되었다면,
					
					request.setAttribute("userid", userid);
					request.setAttribute("pwd", pwd);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/sujin/login/registerAfterAutoLogin.jsp"); // 이 페이지로간다
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				
				String message = "SQL구문 오류발생";
				String loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전 페이지로 이동한다. *[암기]*
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			
		}//end of else()-------------------------

	}

}
