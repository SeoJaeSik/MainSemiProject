package jaesik.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import jaesik.model.JS_InterMemberDAO;
import jaesik.model.JS_MemberDAO; 
//import member.controller.GoogleMail; 
//import member.model.InterMemberDAO; 
//import member.model.MemberDAO;

public class SubmitCouponAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if ("POST".equalsIgnoreCase(method)) {
			String email = request.getParameter("email");

			JS_InterMemberDAO mdao = new JS_MemberDAO();
			
			String isUserExistID = mdao.isUserExistID(email);
			// 입력받은 이메일로 가입된 유저로 존재하는지 알아오는 메소드 존재하면 해당 id를 리턴

			boolean sendMailSuccess = false;
			// 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
			
			String message = "";
			String loc = "";
			
			if (isUserExistID != null) {
				// 회원으로 존재하는 경우 인증코드 메일보내기 실행
				
				Random rnd = new Random();
				String certificationCode = "";
				// 인증코드는 영문대문자, 숫자 혼합하여 20글자로 구성하지만 중간에 'NEW10' 이라는 단어가 포함된다 
				
				for (int i=0; i<15; i++) {
					/*
	                min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
	                int rndnum = rnd.nextInt(max - min + 1) + min;
	                영문 소문자 'A' 부터 'Z' 까지 랜덤하게 1개를 만든다.     
					*/
					if ( i < 4 || 10 < i ) {
						char rndchar = (char) (rnd.nextInt('Z' - 'A' + 1) + 'A');
						certificationCode += rndchar;
					}
					else {
						int rndnum = rnd.nextInt(9 - 0 + 1) + 0;
						certificationCode += rndnum;
					}
				}
				certificationCode += "NEW10";
				
				// 신규회원 쿠폰을 이미 지급 받은사람인지 체크
				boolean isCouponExist = mdao.isCouponExist(isUserExistID);
				// 이미 발급된 유저이면 isCouponExist = true
				
				if (!isCouponExist) {
					// 쿠폰 발급이 처음인 유저인 경우
					
					// 랜덤하게 생성한 코드를 비밀번호 찾기를 하고자하는 사용자에게 전송
					GoogleMail mail = new GoogleMail();
					
					try {
						mail.sendmail(email, certificationCode);
						sendMailSuccess = true; // 메일전송이 성공시 true
						
						if (sendMailSuccess) {
							// 발급된 인증번호를 DB coupon 테이블에 insert
							int n = mdao.sendCouponCode(isUserExistID, certificationCode);
							
							if (n == 1) {
								message = "해당 이메일로 쿠폰번호가 전송되었습니다.";
								loc = "javascript:history.back()";
							}
							
						}
						
					} catch (Exception e) { // 메일전송이 실패한경우
						System.out.println("메일 전송이 실패함");
						e.printStackTrace();
						
						// 쿠폰테이블 insert 중 에러가 발생했을 경우
						message = "메일 전송중 오류가 발생하였습니다. 관리자에게 문의바랍니다.";
						loc = "javascript:history.back()";
					}
					
				}
				else {
					// 쿠폰이 이미 발급된 유저
					message = "첫 구매 할인쿠폰은 한번만 발행 가능합니다.";
					loc = "javascript:history.back()";
				}
				
				
			}
			else {
				// 이메일로 가입된 유저가 없을시
				message = "해당 이메일로 가입된 유저가 존재하지 않습니다.";
				loc = "javascript:history.back()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jaesik/msg.jsp");
		}
	}
}