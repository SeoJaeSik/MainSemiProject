package sujin.controller;

import javax.servlet.http.HttpServletRequest;

// 자주 쓰는 메소드들을 이곳에 만들어두겠다
public class MyUtil {
	
	// *** ? 다음의 데이터까지 포함한 현재 url 주소를 알려주는 메소드를 생성하자 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		// 예를들어 아래처럼 웹브라우저 주소 입력창에 링크를 입력하면 
		// http://localhost:9090/MyMVC/member/memberList.up?searchType=name&searchWord=유&sizePerPage=5
		
		// [getRequestURL] url 은 ? 앞까지만 보여준다 
		String currentURL = request.getRequestURL().toString();
			// http://localhost:9090/MyMVC/member/memberList.up

		// [getQueryString] ? 뒤에 데이터값을 보여준다
		String queryString = request.getQueryString();
			// (GET방식일때)  searchType=name&searchWord=유&sizePerPage=5  
			// (POST방식일때) null 
		
		
		if(queryString != null) { // GET 방식인 경우
			currentURL += "?" + queryString;
			// http://localhost:9090/MyMVC/member/memberList.up?searchType=name&searchWord=유&sizePerPage=5
			// -> 이렇게 원상복구가 되어진다~
		}
		
		
		String ctxPath = request.getContextPath(); 	// ctxPath = /SemiProject_MOSACOYA
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();	
		// beginIndex (41) = ctxPath 가 시작되는 곳의 위치값 (21) + ctxPath 의 길이 (20)
		
		currentURL = currentURL.substring(beginIndex);
		// --> "/member/memberList.up?searchType=name&searchWord=유&sizePerPage=5" 만을 얻어왔다
		
		return currentURL;
	}
	

}
