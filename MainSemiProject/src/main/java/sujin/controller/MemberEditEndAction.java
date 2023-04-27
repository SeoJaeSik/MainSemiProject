package sujin.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import sujin.model.*;

public class MemberEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		String message = ""; /* alert 에 띄울 메세지 */
		String loc = "";     /* 돌아갈 페이지(위치값) */
		
		if("POST".equals(method)) { /* POST 방식으로 넘어왔다면, */
		
			String userid = request.getParameter("userid");
			
			String name = request.getParameter("name");
			String pwd = request.getParameter("pwd");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String extraAddress = request.getParameter("extraAddress");
			
			String birthyyyy = request.getParameter("birthyyyy");
			String birthmm = request.getParameter("birthmm");
			String birthdd = request.getParameter("birthdd"); 
			
			String mobile = hp1 + hp2 + hp3;                 // 01012345678
			String birthday = birthyyyy + birthmm + birthdd; // 19930425
			
			// 파라미터가 있는 생성자 생성
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress, birthday);
			
			try {
				InterMemberDAO mdao = new MemberDAO();
				int n = mdao.updateMember(member);
				
				if(n==1) {
					
					// !!! session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다 !!! (다시 로그인 하지 않아도 바로 수정된 게 적용되도록!)
					HttpSession session = request.getSession();
					MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
					
					loginuser.setName(name);
					loginuser.setPwd(pwd);
					loginuser.setEmail(email);
					loginuser.setMobile(mobile);
					loginuser.setPostcode(postcode);
					loginuser.setAddress(address);
					loginuser.setDetailaddress(detailAddress);
					loginuser.setExtraaddress(extraAddress);
					loginuser.setBirthday(birthyyyy + birthmm + birthdd);
					
					message = "회원정보수정 성공";
				}
				
			} catch (SQLException e) {
				message = "SQL구문 오류발생";
				e.printStackTrace();
			}
			
		}
		else { /* POST 방식으로 넘어온것이 아니라면, */ 
			
			message = "비정상적인 경로를 통해 들어왔습니다."; /* alert 에 띄울 메세지 */
		}

		loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전 페이지로 이동한다. *[암기]*
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");
		
	}

}
