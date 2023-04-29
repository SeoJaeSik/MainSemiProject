package sujin.controller;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

public class GoogleMail {

	// 비밀번호 변경을 할 수 있는 링크를 email 로 전송해주는 메소드 생성
	public void sendmail(String recipient, String emailContents) throws Exception { 
		
		// 1. 정보를 담기 위한 객체
        Properties prop = new Properties(); 
        
        // 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
        //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
        prop.put("mail.smtp.user", "yonsudin0210@gmail.com");
		
        // 3. SMTP 서버 정보 설정
        //    Google Gmail 인 경우  smtp.gmail.com
        prop.put("mail.smtp.host", "smtp.gmail.com"); /* 내가쓰는 smtp 서버는 google 이다 */
        
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.debug", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        prop.put("mail.smtp.socketFactory.fallback", "false");
        
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
          
        
        Authenticator smtpAuth = new MySMTPAuthenticator();
        Session ses = Session.getInstance(prop, smtpAuth);
           
        // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다. *잘 가나 확인용*
        ses.setDebug(true);
                
        // 메일의 내용을 담기 위한 객체생성
        MimeMessage msg = new MimeMessage(ses);

        // 제목 설정
        String subject = "[MOSACOYA] Password Reset";
        msg.setSubject(subject);
                
        // 보내는 사람의 메일주소
        String sender = "yonsudin0210@gmail.com";
        Address fromAddr = new InternetAddress(sender);
        msg.setFrom(fromAddr);
                
        // 받는 사람의 메일주소
        Address toAddr = new InternetAddress(recipient);
        msg.addRecipient(Message.RecipientType.TO, toAddr);
                
        msg.setContent(emailContents, "text/html;charset=UTF-8");
        
        // 메일 발송하기
        Transport.send(msg);
        
        
	}//end of sendmail----------------------------------------------------- 

}
