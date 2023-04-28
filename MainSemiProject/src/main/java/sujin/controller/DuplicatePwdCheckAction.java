package sujin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import sujin.model.*;

public class DuplicatePwdCheckAction extends AbstractController {

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String method = request.getMethod();  // "GET" 또는 "POST"
		
		if("POST".equals(method)) {
		
			String new_pwd = request.getParameter("new_pwd");	/* ajax 에서 보낸 data "new_pwd" */
			String userid = request.getParameter("userid");     /* ajax 에서 보낸 data "userid" */
			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("new_pwd", new_pwd);
			paraMap.put("userid", userid);
			
			int n = mdao.duplicatePwdCheck(paraMap);
			// n = 1 이라면 현재 사용중인 암호를 새암호로 준 경우
			// n = 0 이라면 현재 사용중인 암호와 다른 것을 새암호로 준 경우
			
			JSONObject jsonObj = new JSONObject(); // {} : 자바스크립트의 객체 하나 만듬
			jsonObj.put("n",n); // 생성된 json 객체에 key값이 n 으로 담아져 온다. 즉, => {"n":0} 또는 {"n":1}
			
			String json = jsonObj.toString(); // "{"n":0}" 또는 "{"n":1}"
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
 		
	}
	
}
