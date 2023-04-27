package sujin.controller;

import javax.servlet.http.HttpServletRequest;

// 자주 쓰는 메소드들을 이곳에 만들어두겠다
public class MyUtil {
	
	// *** ? 다음의 데이터까지 포함한 현재 url 주소를 알려주는 메소드를 생성하자 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		// 1. [URL] 예를들어 웹브라우저 주소 입력창에서 
		// http://localhost:9090/MyMVC/member/memberList.up?searchType=name&searchWord=유&sizePerPage=5 와 같이 입력됐다면 
		String currentURL = request.getRequestURL().toString();
	//	System.out.println("~~~ 확인용 currentURL = > " + currentURL);
		// ~~~ 확인용 currentURL = > http://localhost:9090/MyMVC/member/memberList.up 로 url 은 ? 앞까지만 보여준다

		String queryString = request.getQueryString();
	//	System.out.println("~~~ 확인용 queryString = > " + queryString);
		// ~~~ 확인용 queryString  = > searchType=name&searchWord=유&sizePerPage=5 로 ? 뒤에 데이터값을 보여준다(GET방식일때)
		// ~~~ 확인용 queryString  = > null (POST방식일때)
		
		if(queryString != null) { // GET 방식인 경우
			currentURL += "?" + queryString;
			// http://localhost:9090/MyMVC/member/memberList.up?searchType=name&searchWord=유&sizePerPage=5
			// -> 이렇게 원상복구가 되어진다~
		}
		
		
		String ctxPath = request.getContextPath(); 	// ctxPath = /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();	
		// beginIndex (27) = ctxPath 가 시작되는 곳의 위치값 (21) + ctxPath 의 길이 (6)
		
		currentURL = currentURL.substring(beginIndex);
		// --> "/member/memberList.up?searchType=name&searchWord=유&sizePerPage=5" 만을 얻어왔다
		
		return currentURL;
	}

}
