package sujin.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

//인증받는 클래스
public class MySMTPAuthenticator extends Authenticator {

   @Override
   public PasswordAuthentication getPasswordAuthentication() {
      
      // Gmail 의 경우 @gmail.com 을 제외한 아이디만 입력한다.
      return new PasswordAuthentication("yonsudin0210","ozrrmlvvmnmjcode"); 
      // "" 은 Google에 로그인 하기위한 앱비밀번호 이다.
   }
   
}
