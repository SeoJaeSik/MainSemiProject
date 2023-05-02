package sujin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import sujin.model.*;

public class EmailDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equals(method)) {
			
			String email = request.getParameter("email");
		// 	System.out.println("~~~ 확인용 email : " + email);
		//  ~~~ 확인용 email : sudin@naver.com
			
			InterMemberDAO mdao = new MemberDAO();
			boolean isExists = mdao.emailDuplicateCheck(email);
			// 있으면 true 없으면 false
			
			
			/* 아래처럼 객체로 담을 수 있게 만들어주는 json 관련 라이브러리 2개를 꼭 lib 에 설치해야함!!! */
			JSONObject jsonObj = new JSONObject(); // {} : 배열이 아니라 javascript의 객체임!
			jsonObj.put("isExists", isExists);     // {"isExists":true} 또는 
			                                       // {"isExists":false}
			
			String json = jsonObj.toString(); // 문자열 형태인 "{"isExists":true}" 또는 "{"isExists":false}" 으로 만들어준다
		//	System.out.println(">> 확인용 : json => " + json);
		/*	
		 *  if("GET"~~) 으로 바꾸고 아래처럼 해보면 확인가능!
		  	http://localhost:9090/MyMVC/member/emailDuplicateCheck.up?email=leess@naver.com 를 주소창에 넣어보면 >> 확인용 : json => {"isExists":true}
			http://localhost:9090/MyMVC/member/emailDuplicateCheck.up?email=leesssss@naver.com 를 주소창에 넣어보면 >> 확인용 : json => {"isExists":false}	
		*/	
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
	}

}