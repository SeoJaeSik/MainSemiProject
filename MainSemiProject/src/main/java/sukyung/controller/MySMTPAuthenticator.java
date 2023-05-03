package sukyung.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {
	
	@Override
	public PasswordAuthentication getPasswordAuthentication() {
      
		return new PasswordAuthentication("abc0101test","gxxlhmehctsvkerp"); 
		// PasswordAuthentication("아이디","비밀번호")
		// Gmail 의 경우 @gmail.com 을 제외한 "아이디"만 입력한다.
		// "비밀번호"는 Google에 로그인 하기위한 앱비밀번호 이다.
		
   } // end of public PasswordAuthentication getPasswordAuthentication()
	
}
